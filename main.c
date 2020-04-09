//
//  main.c
//  LeetCode
//
//  Created by Max on 2020/1/13.
//  Copyright © 2020 Max. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxDepth(struct TreeNode* root){
    if (root == NULL)
    {
        return 0;
    }
    else if (root->left == NULL && root ->right == NULL)
    {
        return 1;
    }
    else
    {
        int lenghtL=0;
        int lenghtR=0;
        if (root->left != NULL) {
            lenghtL = maxDepth(root->left)+1;
        }
        
        if (root->right != NULL) {
            lenghtR = maxDepth(root->right)+1;
        }
        
        return lenghtL>lenghtR?lenghtL:lenghtR;
    }
}


// 非递归
int maxDepth2(struct TreeNode* root)
{
    if (root == NULL)
    {
        return 0;
    }
    else
    {
        int length = 1;
        
        struct TreeNode*list[1000]={NULL};
        list[0] = root;
        int count = 1;
        int floorCount = 1;
                
        while (floorCount)
        {
            int tmp = 0;
            for (int i=0; i<floorCount; i++)
            {
                struct TreeNode *node = list[count-floorCount+i];
                
                if (node->left)
                {
                    list[count+tmp] = node->left;
                    tmp++;
                }
                
                if (node->right)
                {
                    list[count+tmp] = node->right;
                    tmp++;
                }
            }
            floorCount = tmp;
            count += floorCount;
            if (floorCount != 0)
            {
                length++;
            }
        }
        
        return length;
    }
}

int maxDepth3(struct TreeNode* root){

    struct TreeNode* head = root;
    struct TreeNode** stack = malloc(0);
    int index = -1;
//    int deep = -1;
//    int max = -1;

    while (head || index != -1)
    {
        if (head)
        {
//            deep++;
            stack = realloc(stack,(++index+1)*sizeof(void *));
            stack[index] = head;
            head = head -> left;
            if (head == NULL)
            {
                printf("------->%d\n",index);
            }
        }
        else
        {
            head = stack[index]->right;
            if (!head)
            {
                index--;
            }else
            {
                head ->left = NULL;
            }
        }
    }

    return index+1;
}

// 前序遍历递归
int* preorderTraversal(struct TreeNode* root, int* returnSize)
{
    int *res=NULL;
    
    if (root==NULL)
    {
        *returnSize=0;
        return res;
    }
    else
    {
        int left = 0;
        int right = 0;
        
        int *leftNodes = preorderTraversal(root->left,&left);
        int *rightNodes = preorderTraversal(root->right,&right);
        
        *returnSize = left+right+1;
        
        int *res = malloc((left+right+1)*sizeof(int));
        res[0] = root->val;
        for (int i=0; i<left; i++)
        {
            res[i+1] = leftNodes[i];
        }
        
        for (int i=0; i<right; i++)
        {
            res[i+1+left] = rightNodes[i];
        }
        
        return res;
    }
}

// 前序遍历非递归
int* preorderTraversal2(struct TreeNode* root, int* returnSize)
{
    int *res=malloc(0);
    *returnSize=0;
    
    struct TreeNode** stack = malloc(0);
    int index = -1;
    
    struct TreeNode* tmp = root;
    
    while (tmp || index != -1)
    {
        if (tmp)
        {
            (*returnSize)++;
            res = realloc(res, (*returnSize)*sizeof(int));
            res[(*returnSize)-1] = tmp -> val;
            
            index++;
            stack =realloc(stack, (index+1)*sizeof(void *));
            stack[index] = tmp;
            tmp = tmp -> left;
        }
        else
        {
            tmp = stack[index--] -> right;
        }
    }
    
    return res;
}


int* inorderTraversal(struct TreeNode* root, int* returnSize){
    
    int *res=NULL;
    
    if (root==NULL)
    {
        *returnSize=0;
        return res;
    }
    else
    {
        int left = 0;
        int right = 0;
        
        int *leftNodes = preorderTraversal(root->left,&left);
        int *rightNodes = preorderTraversal(root->right,&right);
        
        *returnSize = left+right+1;
        
        int *res = malloc((left+right+1)*sizeof(int));
        
        for (int i=0; i<left; i++)
        {
            res[i] = leftNodes[i];
        }
        res[left] = root->val;
        for (int i=0; i<right; i++)
        {
            res[i+1+left] = rightNodes[i];
        }
        
        return res;
    }
}

// 中序遍历非递归
int* inorderTraversal2(struct TreeNode* root, int* returnSize)
{
    int *res = malloc(0);
    *returnSize = 0;
    struct TreeNode** stack = malloc(0);
    struct TreeNode* tmp = root;
    int index = -1;
    
    while (tmp || index != -1)
    {
        if (tmp)
        {
            index++;
            stack = realloc(stack, (index+1)*sizeof(void *));
            stack[index] = tmp;
            tmp = tmp->left;
        }
        else
        {
            (*returnSize)++;
            res = realloc(res, (*returnSize)*sizeof(int));
            res[(*returnSize)-1] = stack[index] ->val;
            tmp = stack[index] -> right;
            index--;
        }
    }
    
    return res;
}

int* postorderTraversal(struct TreeNode* root, int* returnSize){
    int *res=NULL;
       
       if (root==NULL)
       {
           *returnSize=0;
           return res;
       }
       else
       {
           int left = 0;
           int right = 0;
           
           int *leftNodes = postorderTraversal(root->left,&left);
           int *rightNodes = postorderTraversal(root->right,&right);
           
           *returnSize = left+right+1;
           
           int *res = malloc((left+right+1)*sizeof(int));
           
           for (int i=0; i<left; i++)
           {
               res[i] = leftNodes[i];
           }
       
           for (int i=0; i<right; i++)
           {
               res[i+left] = rightNodes[i];
           }
           
            res[left+right] = root->val;
           
           return res;
       }
}

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeTwoLists(struct ListNode* l1, struct ListNode* l2){
    
    if (l1 == NULL || l2 == NULL)
    {
        if (l1) {
            return l1;
        }
        else if (l2)
        {
            return l2;
        }else
        {
            return NULL;
        }
    }
    else
    {
        struct ListNode* header = NULL;
        struct ListNode* tmp = NULL;
        
        while (!l1 && !l2)
        {
            if (header)
            {
                tmp = l1->val < l2->val ? l1:l2;
                printf("%d\n",tmp->val);
                tmp = tmp -> next;
            }
            else
            {
                tmp = l1->val < l2->val ? l1:l2;
                header = tmp;
                tmp = tmp -> next;
            }
            
            if (l1->val < l2->val)
            {
                l1 = l1->next;
            }
            else
            {
                l2 = l2->next;
            }
        }
        
        return header;
    }
}

struct ListNode* mergeKLists(struct ListNode** lists, int listsSize){
    
    int min,index;
    struct ListNode* res = NULL;
    struct ListNode* head = NULL;
    
    while (1)
    {
        min = 0x7fffffff;
        index = -1;
        for (int i=0; i<listsSize; i++)
        {
            if (!lists[i])
            {
                continue;
            }
            if (lists[i] -> val < min)
            {
                min = lists[i] -> val;
                index = i;
            }
        }
        
        if (index == -1)
        {
            break;
        }
        
        if (res)
        {
            head -> next = lists[index];
            lists[index] = lists[index] -> next;
            head = head -> next;
        }
        else
        {
            res = lists[index];
            lists[index] = lists[index] -> next;
            head = res;
        }
    }
        
    return res;
}


void backTrack(int* nums, int ***res, int *resSize, int k, int numsSize, int *elem)
{
    if (k == numsSize)
    {
//        printf("%d,%d,%d\n",elem[0],elem[1],elem[2]);
        int **tmp = realloc(*res,(++(*resSize))*(sizeof(int *)));
        tmp[(*resSize)-1] = elem;
        *res = tmp;
    }
    else
    {
        for(int i=0; i<numsSize; i++)
        {
            int value = nums[i];
            if(k==0)
            {
                elem = malloc(numsSize * sizeof(int));
                elem[k] = value;
            }
            else
            {
                elem[k] = value;
            }
            
            backTrack(nums,res,resSize,k+1,numsSize,elem);
        }
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes)
{
    int **set = malloc(0);
    int ***res = &set;
    int k = 0;
    *returnSize = 0;
    
    backTrack(nums,res,returnSize,k,numsSize,NULL);

    int *columnSizes = malloc((*returnSize)*sizeof(int));
    for(int i=0;i<*returnSize;i++)
    {
        columnSizes[i] = numsSize;
    }
    returnColumnSizes = &columnSizes;
    return *res;
}


int main(int argc, const char * argv[]) {
    
//    struct TreeNode node1 = {15,NULL,NULL};
//    struct TreeNode node2 = {7,NULL,NULL};
//    struct TreeNode node3 = {20,&node1,&node2};
//    struct TreeNode node4 = {9,NULL,NULL};
//    struct TreeNode node5 = {5,&node4,&node3};
//
//    int a;
//    int res = maxDepth3(&node5);

//    for (int i=0; i<a; i++)
//    {
//        printf("%d\n",res[i]);
//    }
    
//    struct ListNode node1 = {5,NULL};
//    struct ListNode node2 = {4,NULL};
//    struct ListNode node3 = {4,&node1};
//    struct ListNode node4 = {3,&node2};
//    struct ListNode node5 = {6,NULL};
//    struct ListNode node6 = {1,&node3};
//    struct ListNode node7 = {1,&node4};
//    struct ListNode node8 = {2,&node5};
//
//    struct ListNode *nodes[] = {&node6,&node7,&node8};
//
//    struct ListNode *res = mergeKLists(nodes, 3);
    
    int test[3] = {1,2,3};
    int returnSize;
    int *returnColumnSizes;
    int **res = permute(test, 3, &returnSize, &returnColumnSizes);
    
    for (int i=0; i<10; i++)
    {
        int *elem = res[i];
        printf("%d,%d,%d\n",elem[0],elem[1],elem[2]);
    }
    
    return 0;
}
