# ZCWaterFlowView
一个简单的瀑布流效果，只实现了布局，里面的cell需要自己填充

######只需要将ZCCollectionView里面的四个文件拖入即可，需要自己去实现一个Controller，并填充collectionView里面应该显示的cell
######需要实现ZCCollectionView的一个代理方法，根据列的宽度给出当前indexPath上等比例缩放的图片高度   
    - (CGFloat)collectionView:(ZCCollectionView *)collectionView heightForWidth:(CGFloat)width           atIndexPath:(NSIndexPath *)indexPath 
  
######有三个属性，可以控制显示的效果
    @property (nonatomic,assign) CGFloat columnMargin;  每一列之间的间距
    @property (nonatomic,assign) CGFloat rowMargin;  每一行之间的间距
    @property (nonatomic,assign) CGFloat rowMargin;  显示多少列
  
这个ZCCollectionView是继承自UICollectionView的，所以UICollectionView拥有的样式一样可以去设置
