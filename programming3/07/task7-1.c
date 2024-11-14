#include <stdio.h> 

int main() {
    char filename[100];
    printf("Enter the filename: ");
    scanf("%s", filename);
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("そのファイルは存在しません。\n");
    } else {
        printf("そのファイルは存在します。\n");
        fclose(file);
    }
    return 0;
}