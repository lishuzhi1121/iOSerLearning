//
//  main.c
//  InvertTree
//
//  Created by Sands_Lee on 2020/4/10.
//  Copyright © 2020 Sands_Lee. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

// 二叉树元素类型定义
typedef int ElementType;

// 二叉树结构定义
typedef struct TreeNode {
    ElementType value;          // 值域
    struct TreeNode *lchild;    // 左孩子
    struct TreeNode *rchild;    // 右孩子
} BitTree;

/// 根据给定数组创建二叉树
/// @param bt 二叉树指针的指针
/// @param arr 数组
/// @param size 数组长度
/// @param index 起始位置
void createBitTree(BitTree **bt, int *arr, int size, int index)    //传入一个BitTree指针的指针（作为输出参数）
{
    if (index >= size) {
        *bt = NULL;
        return;
    }
    
    *bt = (BitTree *)malloc(sizeof(struct TreeNode));
    (*bt)->value = *(arr + index);
    (*bt)->lchild = NULL;
    (*bt)->rchild = NULL;
    
    createBitTree(&((*bt)->lchild), arr, size, 2 * index + 1);
    createBitTree(&((*bt)->rchild), arr, size, 2 * index + 2);
}


void preOrder(BitTree *bt)
{
    if (bt == NULL) {
        return;
    }
    printf("%d ", bt->value);
    // 递归左右子树
    preOrder(bt->lchild);
    preOrder(bt->rchild);
}


void inOrder(BitTree *bt)
{
    if (bt == NULL) {
        return;
    }
    inOrder(bt->lchild);
    printf("%d ", bt->value);   // 访问节点值
    inOrder(bt->rchild);
}

void postOrder(BitTree *bt)
{
    if (bt == NULL) {
        return;
    }
    postOrder(bt->lchild);
    postOrder(bt->rchild);
    printf("%d ", bt->value);   // 访问节点值
}




//struct TreeNode {
//    int val;
//    struct TreeNode *left;
//    struct TreeNode *right;
//};

//struct TreeNode* invertTree(struct TreeNode* root) {
//    if (root == NULL) {
//        return NULL;
//    }
//
//    struct TreeNode *right = invertTree(root->right);
//    struct TreeNode *left = invertTree(root->left);
//    root->right = left;
//    root->left  = right;
//    return root;
//}



//void createTree(struct TreeNode ** treeNode, int *arr, int size, int index) {
//    if (index >= size) {
//        return;
//    }
//
//    struct TreeNode *tree = NULL;
//    tree->val = *(arr + index);
//    tree->left = NULL;
//    tree->right = NULL;
//
//    createTree(&tree->left, arr, size, 2 * index + 1);
//    createTree(&tree->right, arr, size, 2 * index + 2);
//}



int main(int argc, const char * argv[]) {
    
    int arr[10] = {3,6,2,1,2,9,0,7,3,7};
    BitTree *bitTree = NULL;
    createBitTree(&bitTree, arr, 10, 0);
    // 先序遍历
    preOrder(bitTree);
    printf("\n");
    inOrder(bitTree);
    printf("\n");
    postOrder(bitTree);
    printf("Hello, World!\n");
    return 0;
}
