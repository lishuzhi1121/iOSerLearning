//
//  main.c
//  twoNumsSum
//
//  Created by Sands_Lee on 2020/4/8.
//  Copyright © 2020 Sands_Lee. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

int* twoSum(int* nums, int numsSize, int target, int* returnSize);

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
//    int nums[] = {2, 7, 11, 15};
    int *nums = (int *)malloc(sizeof(int) * 4);
    nums[0] = 2;
    nums[1] = 11;
    nums[2] = 7;
    nums[3] = 15;
    int returnSize;
    int *res = twoSum(nums, 4, 9, &returnSize);
    for (int j = 0; j < returnSize; j ++) {
        printf("res %d: %d \n", j, res[j]);
    }
    
    return 0;
}

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    int *res = (int *)malloc(sizeof(int) * 2);
    int i,j;
    *returnSize = 0;
    for (i = 0; i < numsSize - 1; i++) {
        for (j = i + 1; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                res[0] = i;
                res[1] = j;
                *returnSize = 2;
                return res;
            }
        }
    }
    return res;
}
