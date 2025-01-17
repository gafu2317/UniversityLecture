#include <stdio.h>
#include <stdlib.h>
#include "task14.h"

int* create_array(int size) {
    return (int*)malloc(size * sizeof(int));
}

void fill_array(int *array, int size) {
    for (int i = 0; i < size; i++) {
        array[i] = size - i;
    }
}

void print_array(int *array, int size) {
    printf("配列の中身: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}
