//
//  HomeItemsCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "HomeItemsCell.h"

#import "ItemCollectionCell.h"

@interface HomeItemsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *dataArray;
//@property(nonatomic,strong)DPUserHealthModel *userHealthModel;


@end

@implementation HomeItemsCell

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
    
    
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SizeWidth(60), SizeWidth(85));
        if (_dataArray.count<=4) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(375),SizeWidth(100)) collectionViewLayout:layout];
        } else {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(375),SizeWidth(185)) collectionViewLayout:layout];
        }
        
        //        UIImageView *imgV = [UIImageView new];
        //        imgV.image = [UIImage imageNamed:@"我的背景黑2"];
        //        _collectionView.backgroundView = imgV;
        _collectionView.showsHorizontalScrollIndicator = NO;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = SizeWidth(31);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        [_collectionView registerClass:[ItemCollectionCell class] forCellWithReuseIdentifier:@"ItemCollectionCell"];
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
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ItemCollectionCell alloc] init];
    }
    [cell setUpData:self.dataArray[indexPath.item]];
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(SizeWidth(10), SizeWidth(20), SizeWidth(5),SizeWidth(20));
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeItemsDidSelectWithTag:)]) {
        [self.delegate homeItemsDidSelectWithTag:indexPath.row];
    }
}

- (void)setItemsArray:(NSArray *)itemsArray {
    _dataArray = itemsArray;
    [self.contentView removeAllSubviews];
    [self.contentView addSubview:self.collectionView];
    
    
    [_collectionView reloadData];
}

@end
