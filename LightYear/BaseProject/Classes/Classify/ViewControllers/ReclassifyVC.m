//
//  ReclassifyVC.m
//  BaseProject
//
//  Created by wuyb on 2018/3/22.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ReclassifyVC.h"

#import "ScreenView.h"
#import "HotCollectionCell.h"

@interface ReclassifyVC ()<ScreenViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ReclassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"爆炸分类";
    self.rightBar.hidden = YES;
    [self creatView];
}

- (void)creatView {
    ScreenView *screenView = [[ScreenView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, SizeWidth(44))];
    screenView.delegate = self;
    [self.view addSubview:screenView];
    
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SizeWidth(165), SizeWidth(250));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+SizeWidth(44), SizeWidth(375),kScreenH-64-SizeWidth(44)) collectionViewLayout:layout];
        //        UIImageView *imgV = [UIImageView new];
        //        imgV.image = [UIImage imageNamed:@"我的背景黑2"];
        //        _collectionView.backgroundView = imgV;
        _collectionView.showsHorizontalScrollIndicator = NO;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = SizeWidth(15);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        [_collectionView registerClass:[HotCollectionCell class] forCellWithReuseIdentifier:@"HotCollectionCell"];
        _collectionView.backgroundColor = RGBColor(255, 255, 255);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HotCollectionCell alloc] init];
    }
    
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, SizeWidth(15),0,SizeWidth(15));
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(homeItemsDidSelectWithTag:)]) {
    //        [self.delegate homeItemsDidSelectWithTag:indexPath.row];
    //    }
}

#pragma mark ScreenViewDelegate
// 0、综合  1、销量  2、价格降序 3、价格升序  4、上新
-(void)screenViewDidSelectWihtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSLog(@"综合");
        }
            break;
        case 1:
        {
            NSLog(@"销量");
        }
            break;
        case 2:
        {
            NSLog(@"价格降序");
        }
            break;
        case 3:
        {
            NSLog(@"价格升序");
        }
            break;
        case 4:
        {
            NSLog(@"上新");
        }
            break;
            
        default:
            break;
    }
}

@end
