//
//  ShopCell.m
//  瀑布流
//
//  Copyright (c) 2015年 张超. All rights reserved.
//

#import "ShopCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"

@interface ShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation ShopCell

- (void)setShop:(Shop *)shop
{
    _shop = shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageLowPriority];
    
    [self.detailLabel setText:shop.price];
}

@end
