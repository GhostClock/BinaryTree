//
//  main.m
//  二叉树
//
//  Created by GhostClock on 2018/9/15.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTree.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BinaryTreeNode *node = [BinaryTree createTreeWithValue:@[@1, @2, @4, @2, @1, @5]];
        node = [BinaryTree addTreeNode:node value:100];
        node = [BinaryTree addTreeNode:node value:-1];
        
        [BinaryTree treeNodeAtIndex:4 inTree:node handler:^(BinaryTreeNode *treeNode) {
            NSLog(@"%ld", node.value);
        }];
        
        // 先序遍历 中 左 右
        [BinaryTree preOrderTraverseTree:node handler:^(BinaryTreeNode *treeNode) {
            NSLog(@"先序遍历 %ld", treeNode.value);
        }];
        
        // 中序遍历 左 中 右
        [BinaryTree inOrderTraverseTree:node handler:^(BinaryTreeNode *treeNode) {
             NSLog(@"中序遍历 %ld", treeNode.value);
        }];
        
        // 后序遍历: 左 右 中
        [BinaryTree postOrderTraverseTree:node handler:^(BinaryTreeNode *treeNode) {
            NSLog(@"后序遍历 %ld", treeNode.value);
        }];
        
        // 层级遍历 广度优先
        [BinaryTree levelTraverseTree:node handler:^(BinaryTreeNode *treeNode) {
           NSLog(@"层级遍历 %ld", treeNode.value);
        }];
        
        NSInteger deep = [BinaryTree deepOfTree:node];
        NSLog(@"二叉树的深度为: %ld", deep);
        
        NSInteger nodes =  [BinaryTree numberOfNodesInTree:node];
        NSLog(@"二叉树所有的节点为: %ld", nodes);
        
    }
    return 0;
}
