//
//  ZCCollectionView.m
//  瀑布流
//
//  Copyright (c) 2015年 张超. All rights reserved.
//

#import "ZCCollectionView.h"
#import "ZCWaterFlowLayout.h"

@interface ZCCollectionView()<ZCWaterflowLayoutDelagate>

@property (nonatomic,strong) ZCWaterFlowLayout *waterFlow;

@end

@implementation ZCCollectionView

+ (instancetype)collectionViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initCollectionViewWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    return [self initCollectionViewWithFrame:frame];
}

- (instancetype)initCollectionViewWithFrame:(CGRect)frame
{
    ZCWaterFlowLayout *waterFlow = [[ZCWaterFlowLayout alloc] init];
    self.waterFlow = waterFlow;
    
    if(self = [super initWithFrame:frame collectionViewLayout:waterFlow])
    {
        self.backgroundColor = [UIColor whiteColor];
        waterFlow.delagate = self;
    }
    return self;
}
- (CGFloat)waterflowLayout:(ZCWaterFlowLayout *)layout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    return  [self.delagate collectionView:self heightForWidth:width atIndexPath:indexPath];
}

- (void)setRowMargin:(CGFloat)rowMargin
{
    self.waterFlow.rowMargin = rowMargin;
}

- (void)setColumnCount:(int)columnCount
{
    self.waterFlow.columnCount = columnCount;
}

- (void)setColumnMargin:(CGFloat)columnMargin
{
    self.waterFlow.columnMargin = columnMargin;
}


@end
