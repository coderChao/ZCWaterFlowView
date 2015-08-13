//
//  WaterFlowLayout.h
//  瀑布流
//
//  Copyright (c) 2015年 张超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCWaterFlowLayout;
@protocol ZCWaterflowLayoutDelagate <NSObject>

- (CGFloat)waterflowLayout:(ZCWaterFlowLayout *)layout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZCWaterFlowLayout : UICollectionViewLayout

@property (nonatomic,assign) UIEdgeInsets sectionInsets;


/**
 *  每一列之间的间距
 */
@property (nonatomic,assign) CGFloat columnMargin;

/**
 *  每一行之间的间距
 */
@property (nonatomic,assign) CGFloat rowMargin;

/**
 *  显示多少列
 */
@property (nonatomic,assign) int  columnCount;

@property (nonatomic,weak) id<ZCWaterflowLayoutDelagate>  delagate;

@end
