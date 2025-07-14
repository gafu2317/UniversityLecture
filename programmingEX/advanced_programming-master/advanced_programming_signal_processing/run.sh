#!/bin/sh
# Debug-enhanced image processing and template matching script

for image in $1/final/*.ppm; do
    bname=$(basename "$image")
    name="imgproc/$bname"
    echo "Processing: $name"

    # Select image processing based on level
    case $1 in
        *level1*) magick "$image" "$name"; threshold=0.5 ;;
        *level2*) magick "$image" -median 3 "$name"; threshold=1.0 ;;
        *level3*) magick "$image" -equalize "$name"; threshold=1.5 ;;
        *level4*) magick "$image" "$name"; threshold=0.5 ;;
        *level5*) magick "$image" -blur 1x1 "$name"; threshold=2.5 ;;
        *level6*) magick "$image" -blur 2x2 "$name"; threshold=0.6 ;;
        *level7*) magick "$image" -median 3 -equalize -blur 0.5x0.5 "$name"; threshold=1.8 ;;
        *) magick "$image" "$name"; threshold=0.5 ;;
    esac

    echo "$bname:"
    result_file="result/${bname%.*}.txt"
    > "$result_file"

    best_distance=999999
    best_result=""

    # 基本のテンプレートマッチング
    for template in $1/*.ppm; do
        template_name=$(basename "$template" .ppm)
        echo "Template: $template_name"

        # レベルに応じて回転角度を設定
        if [[ $1 == *level6* ]] || [[ $1 == *level7* ]]; then
            angles="0 90 180 270"
        else
            angles="0"
        fi

        for angle in $angles; do
            echo "  Testing angle: $angle"
            rotated_template="temp_${angle}_${template_name}.ppm"

            if magick "$template" -background black -rotate "$angle" -blur 0x1 "$rotated_template" 2>/dev/null; then
                output=$(./matching "$name" "$rotated_template" "$angle" "$threshold" p "$template_name" 2>/dev/null)

                echo "  Matching output for $rotated_template:" >> debug.log
                echo "$output" >> debug.log

                # 修正: [Result]を正しく処理
                if echo "$output" | grep -q "\[Result"; then
                    found_line=$(echo "$output" | grep "\[Result" | head -n 1)
                    echo "  Result line: $found_line" >> debug.log

                    # 正しい列番号を使用
                    res_x=$(echo "$found_line" | awk '{print $3}')
                    res_y=$(echo "$found_line" | awk '{print $4}')
                    res_w=$(echo "$found_line" | awk '{print $5}')
                    res_h=$(echo "$found_line" | awk '{print $6}')
                    res_angle=$(echo "$found_line" | awk '{print $7}')
                    distance=$(echo "$found_line" | awk '{print $8}')

                    echo "  Distance from matching: $distance (threshold: $threshold)" >> debug.log
                    echo "  Final Match Position: ($res_x, $res_y), Size: ${res_w}x${res_h}, Angle: $angle" >> debug.log

                    if awk "BEGIN {exit !($distance < $best_distance)}"; then
                        best_distance=$distance
                        best_result="$template_name $res_x $res_y $res_w $res_h $res_angle"
                    fi
                fi
            else
                echo "  Failed to rotate: $template at angle $angle" >> debug.log
            fi

            rm -f "$rotated_template"
        done
    done

    # Level5専用: マルチスケール処理
    if [[ $1 == *level5* ]]; then
        echo "Level5: Multi-scale processing..."
        
        for template in $1/*.ppm; do
            template_name=$(basename "$template" .ppm)
            echo "Level5 Multi-scale Template: $template_name"

            for angle in 0 90 180 270; do
                for scale in 50 75 100 125 150 175 200; do
                    echo "  Testing scale: ${scale}%, angle: $angle"
                    scaled_template="temp_${angle}_${scale}_${template_name}.ppm"

                    if magick "$template" -resize "${scale}%" -background black -rotate "$angle" -blur 0x1 "$scaled_template" 2>/dev/null; then
                        output=$(./matching "$name" "$scaled_template" "$angle" "$threshold" p 2>/dev/null)

                        if echo "$output" | grep -q "\[Result"; then
                            found_line=$(echo "$output" | grep "\[Result" | head -n 1)
                            res_x=$(echo "$found_line" | awk '{print $3}')
                            res_y=$(echo "$found_line" | awk '{print $4}')
                            res_w=$(echo "$found_line" | awk '{print $5}')
                            res_h=$(echo "$found_line" | awk '{print $6}')
                            res_angle=$(echo "$found_line" | awk '{print $7}')
                            distance=$(echo "$found_line" | awk '{print $8}')

                            if awk "BEGIN {exit !($distance < $best_distance)}"; then
                                best_distance=$distance
                                best_result="$template_name $res_x $res_y $res_w $res_h $res_angle"
                            fi
                        fi
                    fi
                    rm -f "$scaled_template"
                done
            done
        done
    fi

    # Level7専用の追加処理
    if [[ $1 == *level7* ]]; then
        echo "Level7: Additional multi-scale processing..."
        
        for template in $1/*.ppm; do
            template_name=$(basename "$template" .ppm)
            echo "Level7 Multi-scale Template: $template_name"

            for angle in 0 90 180 270; do
                for scale in 85 95 105 115; do
                    echo "  Testing scale: ${scale}%, angle: $angle"
                    scaled_template="temp_${angle}_${scale}_${template_name}.ppm"

                    if magick "$template" -resize "${scale}%" -background black -rotate "$angle" -blur 0x1 "$scaled_template" 2>/dev/null; then
                        output=$(./matching "$name" "$scaled_template" "$angle" "$threshold" p 2>/dev/null)

                        if echo "$output" | grep -q "\[Result"; then
                            found_line=$(echo "$output" | grep "\[Result" | head -n 1)
                            res_x=$(echo "$found_line" | awk '{print $3}')
                            res_y=$(echo "$found_line" | awk '{print $4}')
                            res_w=$(echo "$found_line" | awk '{print $5}')
                            res_h=$(echo "$found_line" | awk '{print $6}')
                            res_angle=$(echo "$found_line" | awk '{print $7}')
                            distance=$(echo "$found_line" | awk '{print $8}')

                            if awk "BEGIN {exit !($distance < $best_distance)}"; then
                                best_distance=$distance
                                best_result="$template_name $res_x $res_y $res_w $res_h $res_angle"
                                echo "Level7: Better match found at scale ${scale}%, distance: $distance" >> debug.log
                            fi
                        fi
                    fi
                    rm -f "$scaled_template"
                done
            done
        done
    fi

    # 最終的な閾値判定と結果出力
    if [ ! -z "$best_result" ]; then
        echo "Best result for $bname: $best_result (distance: $best_distance)" | tee -a debug.log
        
        # 閾値判定を行う
        if awk "BEGIN {exit !($best_distance < $threshold)}"; then
            echo "$best_result" > "$result_file"
            echo "Match accepted (distance: $best_distance < threshold: $threshold)" >> debug.log
        else
            echo "Match rejected (distance: $best_distance >= threshold: $threshold)" >> debug.log
            # 結果ファイルは空のまま（検出失敗）
        fi
    else
        echo "No match found for $bname" | tee -a debug.log
    fi

    echo "" >> debug.log
    echo ""
done

wait
