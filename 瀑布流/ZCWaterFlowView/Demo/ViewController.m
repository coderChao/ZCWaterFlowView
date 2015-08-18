//
//  ViewController.m
//  瀑布流
//
//  Copyright (c) 2015年 张超. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "Shop.h"
#import "ShopCell.h"
#import "SDWebImageManager.h"
#import "ZCCollectionView.h"

@interface ViewController ()<UICollectionViewDataSource,ZCCollectionViewDelagate>

@property (nonatomic,strong) ZCCollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *shops;

@end

@implementation ViewController

static NSString *const ID = @"shop";

- (NSMutableArray *)shops
{
    if(_shops==nil)
    {
        _shops=[NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化数据
    NSArray *shopArray = [Shop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopArray];
    
    ZCCollectionView *collectionView = [ZCCollectionView collectionViewWithFrame:self.view.bounds];
    
    collectionView.delagate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
}

- (void)loadMoreShops
{
    NSArray *shopArray = [Shop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopArray];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.collectionView reloadData];
    });
}

#pragma mark -ZCCollectionViewDelagate
- (CGFloat)collectionView:(ZCCollectionView *)collectionView heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    Shop *shop = self.shops[indexPath.item];
    return  shop.h / shop.w * width;

}

#pragma mark -UICollecionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
