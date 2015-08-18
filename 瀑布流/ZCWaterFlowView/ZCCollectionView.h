//
//  ZCCollectionView.h
//  瀑布流
//
//  Copyright (c) 2015年 张超. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZCCollectionView;
@protocol ZCCollectionViewDelagate <UICollectionViewDelegate>

/**
 *  根据给定的indexPath和列的宽度，返回一个等比例的图片高度，让图片显示的时候不会拉伸，等比例缩放
 *
 *  @param collectionView  ZCCollectionView
 *  @param width           列的宽度
 *  @param indexPath      CollectionView的indexPath
 *
 *  @return 图片高度
 */
@required
- (CGFloat)collectionView:(ZCCollectionView *)collectionView heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end


@interface ZCCollectionView : UICollectionView

/**
 *  根据给定的frame，初始化collectionView
 *
 *  @param frame collectionView的frame
 *
 *  @return 初始化好的collectionView
 */
+ (instancetype)collectionViewWithFrame:(CGRect)frame;


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

/**
 *  代理
 */
@property (nonatomic,weak) id<ZCCollectionViewDelagate> delegate;

@end
