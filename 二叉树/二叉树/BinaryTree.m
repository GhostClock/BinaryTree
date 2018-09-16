//
//  BinaryTree.m
//  二叉树
//
//  Created by GhostClock on 2018/9/15.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "BinaryTree.h"

@implementation BinaryTreeNode

@end

@interface TreeNodeProperty : NSObject

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, assign) NSInteger deep;

@end

@implementation TreeNodeProperty

@end

@implementation BinaryTree

/**
 创建二叉排序树
 二叉排序树：左节点值全部小于根节点，右节点全部大于根节点值====> 左 < 中 < 右
 @param values 数组
 @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValue:(NSArray *)values {
    __block BinaryTreeNode *root = nil;
    for (int i = 0; i < values.count; i ++) {
        NSInteger value = [values[i] integerValue];
        root = [BinaryTree addTreeNode:root value:value];
    }
    return root;
}

/**
 向二叉树添加一个节点

 @param treeNode 根节点
 @param value 值
 @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    // 如果根节点不存在，就创建节点
    if (!treeNode) {
        treeNode = BinaryTreeNode.new;
        treeNode.value = value;
        NSLog(@"node:%ld", value);
    } else if (value <= treeNode.value) {
        NSLog(@"to left");
        // 值小于跟节点，则插入到左子树
        treeNode.leftNode = [BinaryTree addTreeNode:treeNode.leftNode value:value];
    } else {
        NSLog(@"to right");
        // 值大于根节点，则插入到右子树
        treeNode.rightNode = [BinaryTree addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/**
 查找某个位置的节点

 @param index 节点的索引
 @param rootNode 根节点
 @param completionHandler 回调查找到的节点
 */
+ (void)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))completionHandler {
    // 按层次遍历
    if (!rootNode || index < 0) {
        return;
    }
    NSMutableArray *quereArray = NSMutableArray.array;
    [quereArray addObject:rootNode]; // 把根节点加入数组
    while (quereArray.count > 0) {
        BinaryTreeNode *node = [quereArray firstObject];
        if (index == 0) { // 如果index==0,就表示是第一个节点，直接回调回去
            !completionHandler ?: completionHandler(node);
        }
        [quereArray removeObjectAtIndex:0]; // 弹出最前面的节点
        index --;
        
        if (node.leftNode) { // 如果左节点存在
            [quereArray addObject:node.leftNode]; // 就压入左节点
        }
        if (node.rightNode) { // 如果右节点存在
            [quereArray addObject:node.rightNode]; // 就压入右节点
        }
    }
}

/**
 先序遍历 中 -> 左 -> 右
 先访问根节点，再遍历左子树，最后访问右子树

 @param rootNode 根节点
 @param completionHandler 根节点的回调
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^) (BinaryTreeNode *treeNode))completionHandler {
    if (rootNode) {
        // 中
        !completionHandler ?: completionHandler(rootNode);
        
        // 左
        [self preOrderTraverseTree:rootNode.leftNode handler:completionHandler];
        
        // 右
        [self preOrderTraverseTree:rootNode.rightNode handler:completionHandler];
    }
}

/**
 中序遍历 左 -> 中 -> 右
 先访问左子树，再访问根节点，最后访问右子树
 @param rootNode 根节点
 @param completionHandler 返回节点的回调
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))completionHandler {
    if (rootNode) {
        // 左
        [self inOrderTraverseTree:rootNode.leftNode handler:completionHandler];
        
        // 中
        !completionHandler ?: completionHandler(rootNode);
        
        // 右
        [self inOrderTraverseTree:rootNode.rightNode handler:completionHandler];
    }
}

/**
 后序遍历 左 -> 右 -> 中
 先遍历左子树，再遍历右子树，最后访问根节点
 @param rootNode 根节点
 @param completionHandler 返回节点的回调
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^) (BinaryTreeNode *treeNode))completionHandler {
    if (rootNode) {
        // 左
        [self postOrderTraverseTree:rootNode.leftNode handler:completionHandler];
        
        // 右
        [self postOrderTraverseTree:rootNode.rightNode handler:completionHandler];
        
        // 中
        !completionHandler ?: completionHandler(rootNode);
    }
}

/**
 层次遍历（广度优先）
 按照从上到下, 从左到右的次序进行遍历，先遍历完一层，再遍历下一层

 @param rootNode 根节点
 @param completionHandler 返回遍历到的节点
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))completionHandler {
    if (!rootNode) {
        return;
    }
    
    NSMutableArray *queueArray = NSMutableArray.array;
    [queueArray addObject:rootNode]; // 把根节点add到数组中
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = queueArray.firstObject;
        !completionHandler ?: completionHandler(node); // 取出第一个节点，并回调出去
        
        [queueArray removeObjectAtIndex:0]; // 删除第一个节点
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; // 把左节点加入数组
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; // 把右节点加入数组
        }
    }
}

/**
 二叉树的深度
 
 从根节点到子节点依次经过的节点形成树的一条路径,最长路径的长度就是树的深度
 1.如果根节点为空,则深度为0
 2.如果左右节点都为空，深度为1
 3.递归思想: 二叉树的深度=MAX(左子树的深度，右子树的深度) + 1
 
 @param rootNode 根节点
 @return 返回二叉树的深度
 */
+ (NSInteger)deepOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    NSInteger leftDeep = [self deepOfTree:rootNode.leftNode];
    NSInteger rightDeep = [self deepOfTree:rootNode.rightNode];
    
    return MAX(leftDeep, rightDeep) + 1;
}

/**
 二叉树的宽度
 各层节点数的最大值
 
 @param rootNode 根节点
 @return 返回二叉树的宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    NSMutableArray *queueArray = NSMutableArray.array;
    [queueArray addObject:rootNode]; // 把根节点add到Array中
    NSInteger maxWidth = 1; // 最大的宽度,初始化为1，为已经有根节点了
    NSInteger currentWidth = 0; // 当前层的宽度
    
    while (queueArray.count > 0) {
        currentWidth = queueArray.count;
        // 依次变量当前层的节点
        for (int i = 0; i < currentWidth; i ++) {
            BinaryTreeNode *node = queueArray.firstObject;
            [queueArray removeObjectAtIndex:0]; // 得到当前层的节点后，把第一个元素remove掉
            
            if (node.leftNode) {
                [queueArray addObject:node.leftNode]; // 如果有左节点，把左节点add到数组
            }
            
            if (node.rightNode) {
                [queueArray addObject:node.rightNode]; // 如果有右节点，把左节点add到数组
            }
        }
        // 宽度 = 当前层节点树
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    return maxWidth;
}

/**
 二叉树的所有节点树
 递归思想: 二叉树的所有节点树=左子树节点树+右子树节点树 + 1
 
 @param rootNode 根节点
 @return 返回所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    // 节点树=左节点树 + 右节点树 + 1
    return [self numberOfNodesInTree:rootNode.leftNode] + [self numberOfNodesInTree:rootNode.rightNode] + 1;
}

/**
 某层中的节点树
 1.根节点为空，则节点树为0
 2.层为1时,则节点树为1(只有根节点)
 3.递归思想: 二叉树第k层节点树=左子树第k-1层的节点树+右子树第k-1层的节点树

 @param level 层
 @param rootNode 根节点
 @return 层中的节点树
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || level < 1) { //没有根节点或者传下来的level < 0
        return 0;
    }
    if (level == 1) { //只有根节点
        return 1;
    }
    // 递归: level层节点树 = 左子树level-1层节点树+ 右子树level-1层节点树
    return [self numberOfNodesOnLevel:level - 1 inTree:rootNode.leftNode] + [self numberOfNodesOnLevel:level - 1 inTree:rootNode.rightNode];
}

/**
 叶子节点树
 叶子节点树:也叫终端节点,是左右子树都是空的节点

 @param rootNode 根节点
 @return 叶子节点树
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    // 递归: 叶子数 = 左子树叶子数 + 右子叶叶子数
    return [self numberOfLeafsInTree:rootNode.leftNode] + [self numberOfLeafsInTree:rootNode.rightNode];
}

/**
 二叉树最大距离(二叉树的直径)
 二叉树中任意两个节点都有且仅有一条路径，这个路径的长度叫做两个节点的距离。二叉树中所有节点之间距离的最大值就是这个二叉树的直径
 A:
 1.这2个节点分别在根节点的左子树和右子树上,他们直接的路径一定经过根节点,而且他们肯定是根节点左右子树上最远的叶子节点
 2.这两个节点都在左子树上
 3.这两个节点都在右子树上
 只要取3种情况的最大值，就是二叉树的直径
 效率较低, 因为计算子树的深度和最远距离是分开递归的，存在重复递归的情况
 @param rootNode 根节点
 @return 最大距离
 */
+ (NSInteger)A_maxDistanceOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    // 分为3种情况
    // 1. 最远距离经过根节点: 距离 = 左子树深度 + 右子树深度
    NSInteger distance = [self deepOfTree:rootNode.leftNode] + [self deepOfTree:rootNode.rightNode];
    // 2.最远距离在根节点左子树上,即计算左子树最远距离
    NSInteger disLeft = [self A_maxDistanceOfTree:rootNode.leftNode];
    // 3.最远距离在根节点右子树上,即计算右子树最远距离
    NSInteger disRight = [self A_maxDistanceOfTree:rootNode.rightNode];
    
    return MAX(MAX(disLeft, disRight), distance);
}

/**
 二叉树最大距离(二叉树的直径)
 方案2

 @param rootNode 根节点
 @return 最大直径
 */
+ (NSInteger)B_maxDistanceOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    // 方案2: 计算节点深度和最大距离放在一次递归中计算
    TreeNodeProperty *nodeProperty = [self propertyOfThreeNode:rootNode];
    return nodeProperty.distance;
}


/**
 计算树节点的最大深度和最大距离

 @param rootNode 根节点
 @return TreeNodeProperty对象
 */
+ (TreeNodeProperty *)propertyOfThreeNode:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    
    TreeNodeProperty *left = [self propertyOfThreeNode:rootNode.leftNode];
    TreeNodeProperty *right = [self propertyOfThreeNode:rootNode.rightNode];
    TreeNodeProperty *nodePreperty = TreeNodeProperty.new;
    // 节点的深度=左子树深度、右子树深度 + 1(根节点)
    nodePreperty.deep = MAX(left.deep, right.deep) + 1;
    // 最远距离: 左子树最远距离、右子树最远距离和横跨左右子树最远距离种最大值
    nodePreperty.distance = MAX(MAX(left.distance, right.distance), left.deep + right.deep);
    
    return nodePreperty;
}

/**
 某节点到根节点的路径
 即是寻路问题，又是查找问题
 定义一个存放路径的栈
 1.压入根节点，再从左子树种查找,如果未找到，就再从右子树查找，如果也未找到，则弹出根节点，再遍历栈中的上一个节点
 2.如果找到，则栈中存放的节点就是路径经过的节点
 
 @param treeNode 节点
 @param rootNode 根节点
 */
+ (void)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode paths:(void(^)(NSArray *paths))completionHandler {
    NSMutableArray *pathArray = NSMutableArray.array;
    [self isFoundThreeNode:treeNode inTree:rootNode routePath:pathArray];
    
    !completionHandler ?: completionHandler(pathArray);
}

/**
 查找某个节点是否在树中

 @param treeNode 节点
 @param rootNode 根节点
 @param path 根节点到待查节点的路径
 @return YES为找到，NO为未找到
 */
+ (BOOL)isFoundThreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path {
    if (!rootNode || !treeNode) {
        return NO;
    }
    
    if ([rootNode isEqual:treeNode]) {
        [path addObject:rootNode];
        return YES;
    }
    // 把根节点加入到数组中，开始递归
    [path addObject:rootNode];
    // 先从左子树开始查找
    BOOL find = [self isFoundThreeNode:treeNode inTree:rootNode.leftNode routePath:path];
    // 如果没找到，再从右子树开始查找
    if (!find) {
        find = [self isFoundThreeNode:treeNode inTree:rootNode.rightNode routePath:path];
    }
    // 如果两遍都没找到，就删除该根节点
    if (!find) {
        [path removeLastObject];
    }
    return find;
}

/**
 两个节点最近的公共父节点
 根节点肯定是二叉树中任意两个节点的公共父节点，但是不一定是最近的,因此2个最近的公共父节点一定在从根节点到这个节点的路径，因此我们可以先分别从根节点到这2个节点的路径，再从这两个路径中找到最近的公共父节点

 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    if ([nodeA isEqual:nodeB]) {
        return nodeA;
    }
    
    // 从根节点到节点A的路径
    __block NSArray *pathA = nil;
    [self pathOfTreeNode:nodeA inTree:rootNode paths:^(NSArray *paths) {
        pathA = [paths copy];
    }];
    
    // 从根节点到节点B的路径
    __block NSArray *pathB = nil;
    [self pathOfTreeNode:nodeB inTree:rootNode paths:^(NSArray *paths) {
        pathB = [paths copy];
    }];
    // 其中一个节点不在树中,则没有公共父节点
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    // 从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count - 1; i >= 0; i --) {
        for (NSInteger j = pathB.count - 1; j >= 0; j --) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                // 找到
                return [pathA objectAtIndex:i];
            }
        }
    }
    return nil;
}

/**
 两个节点之间的路径
 从查找最近的公共节点衍生出来的

 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 返回两个节点间的路径
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    NSMutableArray *path = NSMutableArray.array;
    if ([nodeA isEqual:nodeB]) {
        [path addObject:nodeA];
        [path addObject:nodeB];
        return path;
    }
    // 从根节点到节点A的距离
    __block NSArray *pathA = nil;
    [self pathOfTreeNode:nodeA inTree:rootNode paths:^(NSArray *paths) {
        pathA = [paths copy];
    }];
    // 从根节点到节点B的距离
    __block NSArray *pathB = nil;
    [self pathOfTreeNode:nodeA inTree:rootNode paths:^(NSArray *paths) {
        pathB = [paths copy];
    }];
    // 其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    // 从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count - 1; i >= 0; i--) {
        [path addObject:pathA[i]];
        for (NSInteger j = pathB.count - 1; j >= 0; j --) {
            if ([pathA[i] isEqual:pathB[j]]) {
                j ++; // 为了避免公共父节点
                while (j < pathB.count) {
                    [path addObject:pathB[j]];
                    j ++;
                }
                return pathB;
            }
        }
    }
    return nil;
}

/**
 两个节点之间的距离
 可以从两个节点的路径衍生而来

 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 两个节点的距离 -1：表示没有找到路径
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return -1;
    }
    if ([nodeA isEqual:nodeB]) {
        return 0;
    }
    
    // 从根节点到节点A的距离
    __block NSArray *pathA = nil;
    [self pathOfTreeNode:nodeA inTree:rootNode paths:^(NSArray *paths) {
        pathA = [paths copy];
    }];
    // 从根节点到节点B的距离
    __block NSArray *pathB = nil;
    [self pathOfTreeNode:nodeB inTree:rootNode paths:^(NSArray *paths) {
        pathB = [paths copy];
    }];
    
    if (pathA.count == 0 || pathB == 0) {
        return -1;
    }
    // 从后往前推,查找一个出现的公共节点
    for (NSInteger i = pathA.count - 1; i >= 0; i --) {
        for (NSInteger j = pathB.count - 1; j >= 0; j --) {
            // 找到公共父节点
            if ([pathA[i] isEqual:pathB[j]]) {
                return (pathA.count - 1) + (pathB.count -j) - 2;
            }
        }
    }
    return -1;
}

/**
 翻转二叉树
 翻转二叉树，又叫做二叉树的镜像,就是把二叉树的左右子树对调, 递归

 @param rootNode 根节点
 @return 翻转后的的根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *temp = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = temp;
    
    return rootNode;
}

@end

















































