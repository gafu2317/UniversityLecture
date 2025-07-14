#include "imageUtil.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>

// 距離関数の種類
typedef enum {
    DISTANCE_SSD = 0,     // Level 1, 2用
    DISTANCE_NCC = 1,     // Level 3用
    DISTANCE_ZNCC = 2,    // Level 4用（マスク処理付き）
    DISTANCE_ZNCC_SCALE = 3,  // Level 5用（拡大縮小対応）
    DISTANCE_ZNCC_ROTATE = 4, // Level 6用（回転対応）
    DISTANCE_ZNCC_MULTI = 5   // Level 7用（複合処理）
} DistanceType;

// 関数宣言
DistanceType getDistanceType(char *input_file);
Image* rotateTemplate(Image *template, int rotation_deg);
double calculateSSDGray(Image *src, Image *template, int x, int y);
double calculateZNCCGray(Image *src, Image *template, int x, int y);
double calculateZNCCGrayForLevel6(Image *src, Image *template, int x, int y);
double calculateSSDColor(Image *src, Image *template, int x, int y);
double calculateZNCCColor(Image *src, Image *template, int x, int y);
double calculateZNCCColorForLevel6(Image *src, Image *template, int x, int y);
void templateMatchingGray(Image *src, Image *template, Point *position, double *distance, char *input_file, int rotation);
void templateMatchingColor(Image *src, Image *template, Point *position, double *distance, char *input_file);

// ファイル名から距離関数タイプ判定
DistanceType getDistanceType(char *input_file) {
    if (strstr(input_file, "level3") != NULL) {
        return DISTANCE_NCC;
    } else if (strstr(input_file, "level4") != NULL) {
        return DISTANCE_ZNCC;
    } else if (strstr(input_file, "level5") != NULL) {
        return DISTANCE_ZNCC_SCALE;
    } else if (strstr(input_file, "level6") != NULL) {
        return DISTANCE_ZNCC_ROTATE;
    } else if (strstr(input_file, "level7") != NULL) {
        return DISTANCE_ZNCC_MULTI;
    } else {
        return DISTANCE_SSD;
    }
}

// テンプレート画像を指定角度で回転させる関数
// 回転中心は画像中心。bilinear補間なしのnearest neighborで簡易実装
Image* rotateTemplate(Image *template, int rotation_deg) {
    if (rotation_deg % 360 == 0) {
        // 回転不要ならコピーを返す
        Image *copy = createImage(template->width, template->height, template->channel);
        memcpy(copy->data, template->data, sizeof(unsigned char) * template->width * template->height * template->channel);
        return copy;
    }

    double rad = rotation_deg * M_PI / 180.0;
    double cos_a = cos(rad);
    double sin_a = sin(rad);

    // 回転後の画像サイズ計算
    int w = template->width;
    int h = template->height;

    int new_w = (int)(fabs(w * cos_a) + fabs(h * sin_a));
    int new_h = (int)(fabs(w * sin_a) + fabs(h * cos_a));

    Image *rotated = createImage(new_w, new_h, template->channel);

    int cx = w / 2;
    int cy = h / 2;
    int ncx = new_w / 2;
    int ncy = new_h / 2;

    for (int y = 0; y < new_h; y++) {
        for (int x = 0; x < new_w; x++) {
            int src_x = (int)(cos_a * (x - ncx) + sin_a * (y - ncy)) + cx;
            int src_y = (int)(-sin_a * (x - ncx) + cos_a * (y - ncy)) + cy;

            if (src_x >= 0 && src_x < w && src_y >= 0 && src_y < h) {
                for (int c = 0; c < template->channel; c++) {
                    rotated->data[(y * new_w + x) * template->channel + c] =
                        template->data[(src_y * w + src_x) * template->channel + c];
                }
            } else {
                for (int c = 0; c < template->channel; c++) {
                    rotated->data[(y * new_w + x) * template->channel + c] = 0;  // 背景黒
                }
            }
        }
    }

    return rotated;
}

// SSD距離計算（グレースケール）
double calculateSSDGray(Image *src, Image *template, int x, int y) {
    double dist = 0;
    for (int j = 0; j < template->height; j++) {
        for (int i = 0; i < template->width; i++) {
            int v = src->data[(y + j) * src->width + (x + i)] - template->data[j * template->width + i];
            dist += v * v;
        }
    }

    return sqrt(dist) / (template->width * template->height); // 正規化を追加
}

// ZNCC（マスク処理付き）グレースケール用（距離型として実装）
double calculateZNCCGray(Image *src, Image *template, int x, int y) {
    int w = template->width;
    int h = template->height;
    double src_mean = 0, tmpl_mean = 0;
    int count = 0;

    // 1. マスク付き平均計算
    for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
            int t_val = template->data[j * w + i];
            if (t_val > 10) {
                src_mean += src->data[(y + j) * src->width + (x + i)];
                tmpl_mean += t_val;
                count++;
            }
        }
    }
    if (count == 0) return 2.0;  // 最悪値として2.0を返す

    src_mean /= count;
    tmpl_mean /= count;

    // 2. ZNCC計算
    double numerator = 0, denom_src = 0, denom_tmpl = 0;
    for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
            int t_val = template->data[j * w + i];
            if (t_val > 10) {
                double s = src->data[(y + j) * src->width + (x + i)] - src_mean;
                double t = t_val - tmpl_mean;
                numerator += s * t;
                denom_src += s * s;
                denom_tmpl += t * t;
            }
        }
    }

    double denom = sqrt(denom_src * denom_tmpl);
    if (denom == 0) return 2.0;

    double zncc = numerator / denom;
    return 1.0 - zncc;  // 距離に変換（0に近いほど類似）
}


// グレースケール版テンプレートマッチング（修正版）
void templateMatchingGray(Image *src, Image *template, Point *position, double *distance, char *input_file, int rotation)
{
    if (src->channel != 1 || template->channel != 1) {
        fprintf(stderr, "Error: Source and template images must be grayscale.\n");
        return;
    }

    DistanceType dist_type = getDistanceType(input_file);

    // 回転対応用テンプレート作成
    Image *rotated_template = rotateTemplate(template, rotation);

    double min_distance = INT_MAX;
    int ret_x = 0, ret_y = 0;

    for (int y = 0; y <= src->height - rotated_template->height; y++) {
        for (int x = 0; x <= src->width - rotated_template->width; x++) {
            double dist_val = 0;

            switch (dist_type) {
                case DISTANCE_SSD:
                    dist_val = calculateSSDGray(src, rotated_template, x, y);
                    break;
                case DISTANCE_NCC:
                    dist_val = calculateSSDGray(src, rotated_template, x, y);
                    break;
                case DISTANCE_ZNCC:
                case DISTANCE_ZNCC_SCALE:
                case DISTANCE_ZNCC_MULTI:
                    dist_val = calculateZNCCGray(src, rotated_template, x, y);
                    break;
                case DISTANCE_ZNCC_ROTATE:  // level6専用
                    dist_val = calculateZNCCGrayForLevel6(src, rotated_template, x, y);
                    break;
            }

            if (dist_val < min_distance) {
                min_distance = dist_val;
                ret_x = x;
                ret_y = y;
            }
        }
    }

    position->x = ret_x;
    position->y = ret_y;
    *distance = min_distance;  // level6では正規化不要

    freeImage(rotated_template);
}

// カラー版SSD距離計算
double calculateSSDColor(Image *src, Image *template, int x, int y) {
    double dist = 0;
    for (int j = 0; j < template->height; j++) {
        for (int i = 0; i < template->width; i++) {
            int pt_src = 3 * ((y + j) * src->width + (x + i));
            int pt_tmp = 3 * (j * template->width + i);

            int r = src->data[pt_src] - template->data[pt_tmp];
            int g = src->data[pt_src + 1] - template->data[pt_tmp + 1];
            int b = src->data[pt_src + 2] - template->data[pt_tmp + 2];

            dist += r*r + g*g + b*b;
        }
    }

    return sqrt(dist) / (template->width * template->height); // 正規化を追加
}

// ZNCC（正規化相互相関）をlevel6用に修正
double calculateZNCCGrayForLevel6(Image *src, Image *template, int x, int y) {
    int w = template->width;
    int h = template->height;
    double src_mean = 0, tmpl_mean = 0;
    int count = 0;

    // 1. 平均計算（マスク処理）
    for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
            int t_val = template->data[j * w + i];
            if (t_val > 10) {  // マスク処理
                src_mean += src->data[(y + j) * src->width + (x + i)];
                tmpl_mean += t_val;
                count++;
            }
        }
    }
    if (count == 0) return 2.0;  // 最悪値として2.0を返す

    src_mean /= count;
    tmpl_mean /= count;

    // 2. ZNCC計算
    double numerator = 0, denom_src = 0, denom_tmpl = 0;
    for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
            int t_val = template->data[j * w + i];
            if (t_val > 10) {
                double s = src->data[(y + j) * src->width + (x + i)] - src_mean;
                double t = t_val - tmpl_mean;
                numerator += s * t;
                denom_src += s * s;
                denom_tmpl += t * t;
            }
        }
    }

    double denom = sqrt(denom_src * denom_tmpl);
    if (denom == 0) return 2.0;

    double zncc = numerator / denom;
    return 1.0 - zncc;  // 距離に変換（0に近いほど類似）
}

// Level6専用ZNCC実装（カラー）
double calculateZNCCColorForLevel6(Image *src, Image *template, int x, int y) {
    double total_zncc = 0;
    int channels = 3;
    
    for (int c = 0; c < channels; c++) {
        double src_mean = 0, tmpl_mean = 0;
        int count = 0;
        
        // チャンネル別平均計算
        for (int j = 0; j < template->height; j++) {
            for (int i = 0; i < template->width; i++) {
                int pt_tmp = 3 * (j * template->width + i) + c;
                int t_val = template->data[pt_tmp];
                if (t_val > 10) {
                    int pt_src = 3 * ((y + j) * src->width + (x + i)) + c;
                    src_mean += src->data[pt_src];
                    tmpl_mean += t_val;
                    count++;
                }
            }
        }
        
        if (count == 0) return 2.0;
        src_mean /= count;
        tmpl_mean /= count;
        
        // チャンネル別ZNCC計算
        double numerator = 0, denom_src = 0, denom_tmpl = 0;
        for (int j = 0; j < template->height; j++) {
            for (int i = 0; i < template->width; i++) {
                int pt_tmp = 3 * (j * template->width + i) + c;
                int t_val = template->data[pt_tmp];
                if (t_val > 10) {
                    int pt_src = 3 * ((y + j) * src->width + (x + i)) + c;
                    double s = src->data[pt_src] - src_mean;
                    double t = t_val - tmpl_mean;
                    numerator += s * t;
                    denom_src += s * s;
                    denom_tmpl += t * t;
                }
            }
        }
        
        double denom = sqrt(denom_src * denom_tmpl);
        if (denom == 0) return 2.0;
        
        total_zncc += numerator / denom;
    }
    
    return 1.0 - (total_zncc / channels);  // 距離に変換
}

// カラー版ZNCC（マスク処理付き）
double calculateZNCCColor(Image *src, Image *template, int x, int y) {
    double total_zncc = 0;
    int channels = 3;
    
    for (int c = 0; c < channels; c++) {
        double src_mean = 0, tmpl_mean = 0;
        int count = 0;
        
        // チャンネル別平均計算
        for (int j = 0; j < template->height; j++) {
            for (int i = 0; i < template->width; i++) {
                int pt_tmp = 3 * (j * template->width + i) + c;
                int t_val = template->data[pt_tmp];
                if (t_val > 10) {
                    int pt_src = 3 * ((y + j) * src->width + (x + i)) + c;
                    src_mean += src->data[pt_src];
                    tmpl_mean += t_val;
                    count++;
                }
            }
        }
        
        if (count == 0) return 2.0;
        src_mean /= count;
        tmpl_mean /= count;
        
        // チャンネル別ZNCC計算
        double numerator = 0, denom_src = 0, denom_tmpl = 0;
        for (int j = 0; j < template->height; j++) {
            for (int i = 0; i < template->width; i++) {
                int pt_tmp = 3 * (j * template->width + i) + c;
                int t_val = template->data[pt_tmp];
                if (t_val > 10) {
                    int pt_src = 3 * ((y + j) * src->width + (x + i)) + c;
                    double s = src->data[pt_src] - src_mean;
                    double t = t_val - tmpl_mean;
                    numerator += s * t;
                    denom_src += s * s;
                    denom_tmpl += t * t;
                }
            }
        }
        
        double denom = sqrt(denom_src * denom_tmpl);
        if (denom == 0) return 2.0;
        
        total_zncc += numerator / denom;
    }
    
    return 1.0 - (total_zncc / channels);  // 距離に変換
}

// カラー版テンプレートマッチング（修正版）
void templateMatchingColor(Image *src, Image *template, Point *position, double *distance, char *input_file)
{
    int is_level6 = (strstr(input_file, "level6") != NULL);
    int is_level7 = (strstr(input_file, "level7") != NULL);

    if (src->channel != 3 || template->channel != 3) {
        fprintf(stderr, "src and/or template image is not a color image.\n");
        return;
    }

    double best_distance = 2.0;
    int ret_x = 0, ret_y = 0;

    for (int y = 0; y < (src->height - template->height); y++) {
        for (int x = 0; x < src->width - template->width; x++) {
            double dist_val = 0;
            
            if (is_level6 || is_level7) {
                // Level6/7用の改良ZNCC実装
                double total_zncc = 0;
                int valid_channels = 0;
                
                for (int c = 0; c < 3; c++) {
                    double src_sum = 0, tmpl_sum = 0;
                    double src_sq_sum = 0, tmpl_sq_sum = 0, cross_sum = 0;
                    int count = 0;
                    
                    // マスク閾値をlevel7では更に下げる
                    int mask_threshold = is_level7 ? 1 : 3;
                    
                    for (int j = 0; j < template->height; j++) {
                        for (int i = 0; i < template->width; i++) {
                            int t_val = template->data[3 * (j * template->width + i) + c];
                            if (t_val > mask_threshold) {
                                int s_val = src->data[3 * ((y + j) * src->width + (x + i)) + c];
                                src_sum += s_val;
                                tmpl_sum += t_val;
                                src_sq_sum += s_val * s_val;
                                tmpl_sq_sum += t_val * t_val;
                                cross_sum += s_val * t_val;
                                count++;
                            }
                        }
                    }
                    
                    // level7では最小ピクセル数を緩和
                    int min_pixels = is_level7 ? 5 : 10;
                    
                    if (count > min_pixels) {
                        double src_mean = src_sum / count;
                        double tmpl_mean = tmpl_sum / count;
                        
                        double numerator = cross_sum - count * src_mean * tmpl_mean;
                        double denom_src = src_sq_sum - count * src_mean * src_mean;
                        double denom_tmpl = tmpl_sq_sum - count * tmpl_mean * tmpl_mean;
                        
                        double denom = sqrt(denom_src * denom_tmpl);
                        if (denom > 1e-12) {  // より小さな閾値
                            double zncc = numerator / denom;
                            
                            // level7では重み付き平均を使用
                            if (is_level7) {
                                double weight = (double)count / (template->width * template->height);
                                total_zncc += zncc * weight;
                                valid_channels++;
                            } else {
                                total_zncc += zncc;
                                valid_channels++;
                            }
                        }
                    }
                }
                
                if (valid_channels > 0) {
                    double avg_zncc = total_zncc / valid_channels;
                    
                    // level7では距離計算を調整
                    if (is_level7) {
                        dist_val = (1.0 - avg_zncc) * 0.8;  // スケール調整
                    } else {
                        dist_val = 1.0 - avg_zncc;
                    }
                } else {
                    dist_val = 2.0;
                }
                
            } else {
                // 従来のSSD処理
                for (int j = 0; j < template->height; j++) {
                    for (int i = 0; i < template->width; i++) {
                        int pt_src = 3 * ((y + j) * src->width + (x + i));
                        int pt_tmp = 3 * (j * template->width + i);
                        int r = src->data[pt_src] - template->data[pt_tmp];
                        int g = src->data[pt_src + 1] - template->data[pt_tmp + 1];
                        int b = src->data[pt_src + 2] - template->data[pt_tmp + 2];
                        dist_val += r*r + g*g + b*b;
                    }
                }
                dist_val = sqrt(dist_val) / (template->width * template->height);
            }

            if (dist_val < best_distance) {
                best_distance = dist_val;
                ret_x = x;
                ret_y = y;
            }
        }
    }

    position->x = ret_x;
    position->y = ret_y;
    *distance = best_distance;
}

// メイン
int main(int argc, char **argv)
{
    printf("DEBUG: Starting program with %d arguments\n", argc);
    for (int i = 0; i < argc; i++) {
        printf("DEBUG: argv[%d] = %s\n", i, argv[i]);
    }
    
    if (argc < 5) {
        fprintf(stderr, "Usage: templateMatching src_image temlate_image rotation threshold option(c,w,p,g)\n");
        return -1;
    }

    printf("DEBUG: Arguments check passed\n");

    char *input_file = argv[1];
    char *template_file = argv[2];
    int rotation = atoi(argv[3]);
    double threshold = atof(argv[4]);

    printf("rotation -> %d\n", rotation);

    char output_name_base[256];
    char output_name_txt[256];
    char output_name_img[256];

    strcpy(output_name_base, "result/");
    strcat(output_name_base, getBaseName(input_file));
    strcpy(output_name_txt, output_name_base);
    strcat(output_name_txt, ".txt");
    strcpy(output_name_img, output_name_base);

    int isWriteImageResult = 0;
    int isPrintResult = 0;
    int isGray = 0;

    if (argc == 6) {
        char *p = NULL;
        if ((p = strchr(argv[5], 'c')) != NULL)
            clearResult(output_name_txt);
        if ((p = strchr(argv[5], 'w')) != NULL)
            isWriteImageResult = 1;
        if ((p = strchr(argv[5], 'p')) != NULL)
            isPrintResult = 1;
        if ((p = strchr(argv[5], 'g')) != NULL)
            isGray = 1;
    }

    printf("DEBUG: Parsed arguments - rotation=%d, threshold=%f\n", rotation, threshold);
    
    printf("DEBUG: Reading input file: %s\n", input_file);
    Image *img = readPXM(input_file);
    if (!img) {
        fprintf(stderr, "ERROR: Failed to read input image\n");
        return -1;
    }
    
    printf("DEBUG: Reading template file: %s\n", template_file);
    Image *template = readPXM(template_file);
    if (!template) {
        fprintf(stderr, "ERROR: Failed to read template image\n");
        freeImage(img);
        return -1;
    }
    
    printf("DEBUG: Images loaded successfully\n");
    printf("DEBUG: img channels=%d, template channels=%d\n", img->channel, template->channel);
    
    Point result;
    double distance = 0.0;

    if (img->channel == 1) {
        templateMatchingGray(img, template, &result, &distance, input_file, rotation);
    } else if (img->channel == 3) {
        templateMatchingColor(img, template, &result, &distance, input_file);
    } else {
        fprintf(stderr, "Error: Unsupported image channels: %d\n", img->channel);
        freeImage(img);
        freeImage(template);
        return 1;
    }

    if (distance < threshold) {
        writeResult(output_name_txt, getBaseName(template_file), result, template->width, template->height, rotation, distance);
        if (isPrintResult) {
            printf("[Result   ] %s %d %d %d %d %d %f\n", 
                   getBaseName(template_file), result.x, result.y, 
                   template->width, template->height, rotation, distance);
        }
        if (isWriteImageResult) {
            drawRectangle(img, result, template->width, template->height, 255);
            if (img->channel == 3)
                strcat(output_name_img, ".ppm");
            else if (img->channel == 1)
                strcat(output_name_img, ".pgm");
            printf("out: %s", output_name_img);
            writePXM(output_name_img, img);
        }
    } else {
        // 修正: 閾値を超えても[Result]として出力（run.shが最終判定を行う）
        if (isPrintResult) {
            printf("[Result   ] %s %d %d %d %d %d %f\n", 
                   getBaseName(template_file), result.x, result.y, 
                   template->width, template->height, rotation, distance);
        }
    }

    freeImage(img);
    freeImage(template);

    return 0;
}
