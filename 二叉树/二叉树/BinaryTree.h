//
//  BinaryTree.h
//  二叉树
//
//  Created by GhostClock on 2018/9/15.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

/**
 值
 */
@property (nonatomic, assign) NSInteger value;

/**
 左节点
 */
@property (nonatomic, strong) BinaryTreeNode *leftNode;

/**
 右节点
 */
@property (nonatomic, strong) BinaryTreeNode *rightNode;

@end

@interface BinaryTree : NSObject

/**
 创建二叉排序树
 二叉排序树：左节点值全部小于根节点，右节点全部大于根节点值====> 左 < 中 < 右
 @param values 数组
 @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValue:(NSArray *)values;

/**
 向二叉树添加一个节点
 
 @param treeNode 根节点
 @param value 值
 @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value;

/**
 查找某个位置的节点
 
 @param index 节点的索引
 @param rootNode 根节点
 @param completionHandler 回调查找到的节点
 */
+ (void)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))completionHandler;

/**
 先序遍历 中 -> 左 -> 右
 先访问根节点，再遍历左子树，最后访问右子树
 
 @param rootNode 根节点
 @param completionHandler 根节点的回调
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^) (BinaryTreeNode *treeNode))completionHandler;

/**
 中序遍历 左 -> 中 -> 右
 先访问左子树，再访问根节点，最后访问右子树
 @param rootNode 根节点
 @param completionHandler 返回节点的回调
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))completionHandler;

/**
 后序遍历 左 -> 右 -> 中
 先遍历左子树，再遍历右子树，最后访问根节点
 @param rootNode 根节点
 @param completionHandler 返回节点的回调
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^) (BinaryTreeNode *treeNode))completionHandler;

/**
 层次遍历（广度优先）
 按照从上到下, 从左到右的次序进行遍历，先遍历完一层，再遍历下一层
 
 @param rootNode 根节点
 @param completionHandler 返回遍历到的节点
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))completionHandler;

/**
 二叉树的深度
 
 @param rootNode 根节点
 @return 返回二叉树的深度
 */
+ (NSInteger)deepOfTree:(BinaryTreeNode *)rootNode;

/**
 二叉树的宽度
 各层节点数的最大值
 
 @param rootNode 根节点
 @return 返回二叉树的宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode;

/**
 二叉树的所有节点树
 递归思想: 二叉树的所有节点树=左子树节点树+右子树节点树 + 1
 
 @param rootNode 根节点
 @return 返回所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode;

/**
 某层中的节点树
 1.根节点为空，则节点树为0
 2.层为1时,则节点树为1(只有根节点)
 3.递归思想: 二叉树第k层节点树=左子树第k-1层的节点树+右子树第k-1层的节点树
 
 @param level 层
 @param rootNode 根节点
 @return 层中的节点树
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode;

/**
 叶子节点树
 叶子节点树:也叫终端节点,是左右子树都是空的节点
 
 @param rootNode 根节点
 @return 叶子节点树
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode;

/**
  二叉树最大距离(二叉树的直径) 方案1

 @param rootNode 根节点
 @return 最大距离
 */
+ (NSInteger)A_maxDistanceOfTree:(BinaryTreeNode *)rootNode;

/**
 二叉树最大距离(二叉树的直径)  方案2
 
 @param rootNode 根节点
 @return 最大直径
 */
+ (NSInteger)B_maxDistanceOfTree:(BinaryTreeNode *)rootNode;

/**
 某节点到根节点的路径
 即是寻路问题，又是查找问题
 定义一个存放路径的栈
 1.压入根节点，再从左子树种查找,如果未找到，就再从右子树查找，如果也未找到，则弹出根节点，再遍历栈中的上一个节点
 2.如果找到，则栈中存放的节点就是路径经过的节点
 
 @param treeNode 节点
 @param rootNode 根节点
 */
+ (void)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode paths:(void(^)(NSArray *paths))completionHandler;

/**
 两个节点最近的公共父节点
 根节点肯定是二叉树中任意两个节点的公共父节点，但是不一定是最近的,因此2个最近的公共父节点一定在从根节点到这个节点的路径，因此我们可以先分别从根节点到这2个节点的路径，再从这两个路径中找到最近的公共父节点
 
 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

/**
 两个节点之间的路径
 从查找最近的公共节点衍生出来的
 
 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 返回两个节点间的路径
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

/**
 两个节点之间的距离
 可以从两个节点的路径衍生而来
 
 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 两个节点的距离 -1：表示没有找到路径
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

/**
 翻转二叉树
 翻转二叉树，又叫做二叉树的镜像,就是把二叉树的左右子树对调
 
 @param rootNode 根节点
 @return 翻转后的的根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode;

/**
 是否完全二叉树
 完全二叉树: 如果设二叉树的高度为h,除了第h层，其他各层的节点树都达到最大个数,第h层右叶子节点,并且叶子节点都是从左到右依次排布
 完全二叉树必须满足两个条件:
 1.如果某个节点的右子树不为空，则它的左子树必须为空
 2.如果某个节点的右子树不为空，则排在它后面的节点必须没有孩子节点
 
 @param rootNode 根节点
 @return YES:完全二叉树 NO:不完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode;

/**
 是否满二叉树
 满二叉树: 除了叶节点外, 每个节点都有左右子叶且叶子节点都出在最底层的二叉树
 特性:叶子数=2^(深度-1),因此我们可以根据这个特性来判断二叉树是否为满二叉树
 
 @param rootNode 根节点
 @return YES:满二叉树 NO:非满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode;

/**
 判断是否平衡二叉树
 平衡二叉树:是一个空树或者它的左右两个子树的高度差的绝对值不超过1,并且左右两个子树都是一颗平衡二叉树
 平衡二叉树又叫AVL数
 
 @param rootNode 根节点
 @return YES:平衡二叉树 NO: 非平衡二叉树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode;

@end
