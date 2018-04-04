//
//  HomeHotCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "HomeHotCell.h"

#import "HotCollectionCell.h"


@interface HomeHotCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

//@property(nonatomic,strong)DPUserHealthModel *userHealthModel;


@end

@implementation HomeHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //        self.contentView.backgroundColor = DPWhiteColor;
        [self creatView];
    }
    return self;
}

- (void)creatView {
    [self.contentView addSubview:self.collectionView];
    
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SizeWidth(165), SizeWidth(250));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(375),SizeWidth(1000)) collectionViewLayout:layout];
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

//- (void)setHealthModel:(DPUserHealthModel *)healthModel {
//    _userHealthModel = healthModel;
//    [_collectionView reloadData];
//}

@end
