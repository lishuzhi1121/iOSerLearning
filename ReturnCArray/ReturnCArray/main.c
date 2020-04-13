//
//  main.c
//  ReturnCArray
//
//  Created by Sands_Lee on 2020/4/10.
//  Copyright © 2020 Sands_Lee. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>


/// 返回数组的函数
int * getRandomNums() {
    static int arr[10];
    
    /* 设置随机种子 */
    srand((unsigned)time(NULL));
    for (int i = 0; i < 10; ++i) {
        arr[i] = rand();
        printf("arr[%d] = %d \n", i, arr[i]);
    }
    
    return arr;
}


/// 指向数组的指针
void printArrNums() {
    double arr[5] = {1.0, 2.0, 4.0, 8.0, 16.0};
    double *p;
    
    p = arr;
    
    printf("使用指针遍历数组:\n");
    for (int i = 0; i < 5; ++i) {
        printf("*(p + %d) = %.1f \n", i, *(p + i));
    }
    
    printf("使用数组基地址遍历数组:\n");
    for (int j = 0; j < 5; ++j) {
        printf("*(arr + %d) = %.1f \n", j, *(arr + j));
    }
    
}


/// 数组作为参数的函数
/// @param arr 数组
/// @param size 数组大小
double getAverage(double arr[], int size) {
    double avg = 0;
    
    for (int i = 0; i < size; ++i) {
        avg += arr[i] / size;
    }
    
    return avg;
}


/// 数组作为参数的函数
/// @param arr 数组
double getAverage2(double arr[8]) {
    double avg = 0;
    
    for (int i = 0; i < 8; ++i) {
        avg += arr[i] / 8;
    }
    
    return avg;
}

/// 数组作为参数的函数
/// @param p 指向数组的指针
/// @param size 数组大小
double getAverage3(double *p, int size) {
    double avg = 0;
    
    for (int i = 0; i < size; ++i) {
        avg += *(p + i) / size;
    }
    
    return avg;
}



int main(int argc, const char * argv[]) {
    
    int *p = getRandomNums();
    for (int i = 0; i < 10; ++i) {
        printf("*(p + %d) = %d \n", i, *(p + i));
    }
    
    printArrNums();
    
    double arr[8] = {1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0, 128.0};
    double avg = getAverage(arr, 8);
    printf("avg = %.2f \n", avg);
    
    double avg2 = getAverage2(arr);
    printf("avg2 = %.2f \n", avg2);
    
    double avg3 = getAverage3(arr, 8);
    printf("avg3 = %.2f \n", avg3);
    
    return 0;
}
