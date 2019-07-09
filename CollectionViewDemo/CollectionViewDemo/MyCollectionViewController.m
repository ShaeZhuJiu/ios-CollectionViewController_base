//
//  MyCollectionViewController.m
//  CollectionViewDemo
//
//  Created by 谢鑫 on 2019/7/7.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "MyFooter.h"
#import "MyHeader.h"
#define kMargin 10
@interface MyCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"MyCell";
static NSString *const reuseIdentifierHeader=@"MyHeaderCell";
static NSString *const reuseIdentifierFooter=@"MyFooterCell";
- (void)viewDidLoad {
    [super viewDidLoad];
 //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
     [self.collectionView registerNib:[UINib nibWithNibName:@"MyFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
    self.collectionView.allowsMultipleSelection=YES;
    

}
#pragma mark 形状设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取屏幕大小
    CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width;
    //计算cell的宽度
    CGFloat cellWidth=(screenWidth-3*kMargin)*0.5;
    return CGSizeMake(cellWidth, cellWidth);
}

//整体边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}
//cell之间的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}
#pragma mark <UICollectionViewDataSource>
//有多少个段
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

//指定每个在每个section里有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
//设置每一个cell的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //在缓存池中获取cell
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//选中item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取点击的单元格
    MyCollectionViewCell *cell=(MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
}
//取消选中item
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取点击的单元格
    MyCollectionViewCell *cell=(MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor blueColor];
}
# pragma mark -补充视图数据源方法-
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *supplementaryView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //设置Header的属性
        //缓存池中获取Header
        MyHeader *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        view.headerLabel.text=[NSString stringWithFormat:@"Header:%ld",(long)indexPath.section];
        supplementaryView=view;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //设置Footer的属性
        MyFooter *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        view.footerLabel.text=[NSString stringWithFormat:@"Footer:%ld",(long)indexPath.section];
        supplementaryView=view;
    }
    return supplementaryView;
}
//必须设置Header和Footer的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 50);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 50);
}
@end
