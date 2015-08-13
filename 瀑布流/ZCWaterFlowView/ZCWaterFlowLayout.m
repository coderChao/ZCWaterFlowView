//
//  WaterFlowLayout.m
//  瀑布流
//
//  Copyright (c) 2015年 张超. All rights reserved.
//

#import "ZCWaterFlowLayout.h"


@interface ZCWaterFlowLayout()

/**
 *  这个字典用来存储每一列最大的Y值（每一列的最大高度）
 */
@property (nonatomic,strong) NSDictionary *maxYDict;

/**
 *  存放所有的布局属性
 */
@property (nonatomic,strong) NSMutableArray *attributeArray;

@end

@implementation ZCWaterFlowLayout

- (NSDictionary *)maxYDict
{
    if(_maxYDict == nil)
    {
        _maxYDict=[NSMutableDictionary dictionary];
        
        for (int i = 0; i < self.columnCount; i++) {
            
            NSString *column = [NSString stringWithFormat:@"%d",i];
           
            [_maxYDict setValue:@(self.sectionInsets.top) forKey:column];
        }
    }
    return _maxYDict;
}

- (NSMutableArray *)attributeArray
{
    if(_attributeArray == nil)
    {
        _attributeArray = [NSMutableArray array];
    }
    return _attributeArray;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnCount = 3;
        
        
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//返回所有的尺寸
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    //找出最长的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if([self.maxYDict[maxColumn] floatValue] < [maxY floatValue])
        {
            maxColumn = column;
        }
        
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInsets.bottom);
}

//每次布局之前的准备
- (void)prepareLayout
{
    [super prepareLayout];
    
    //请空最大的Y值
    for (int i = 0; i < self.columnCount; i++) {
        
        NSString *column = [NSString stringWithFormat:@"%d",i];
        
        [_maxYDict setValue:@(self.sectionInsets.top) forKey:column];
    }
    
    //清空所有cell的属性
    [self.attributeArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        
        [self.attributeArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    
}

/**
 *  返回indexPath这个位置Item的布局属性
 *
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的那一列是第0列
    __block NSString *minColumn = @"0";
    //找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if([self.maxYDict[minColumn] floatValue] > [maxY floatValue])
        {
            minColumn = column;
        }
        
    }];
    
    //计算宽度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInsets.left - self.sectionInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    
    //通过代理获取高度
    CGFloat height = [self.delagate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    //计算位置
    CGFloat x = self.sectionInsets.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    
    //更新这一列的最大Y值
    [self.maxYDict setValue:@(y + height) forKey:minColumn];
    
    //创建属性
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(x, y, width, height);
    
    return attr;
}

/**
 *  返回rect范围内的布局属性
 *
 *  @param rect <#rect description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
        return self.attributeArray;
}


@end
