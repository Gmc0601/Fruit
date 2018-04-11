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
{
    NSInteger _searchType; //1综合排序2销量3价格4上新
    NSInteger _sort;  //1升序2降序
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *goodsArray;

@end

@implementation ReclassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = _shopGoodsTypeModel.name;
    self.rightBar.hidden = YES;
    [self creatView];
    [self loadGoodsData];
}

- (void)creatView {
    _searchType = 1;
    _sort = 2;
    ScreenView *screenView = [[ScreenView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, SizeWidth(44))];
    screenView.delegate = self;
    [self.view addSubview:screenView];
    
    [self.view addSubview:self.collectionView];
}

- (void)loadGoodsData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"goodstype"] = _shopGoodsTypeModel.typeId;
    parameters[@"shopid"] = @"3";
    parameters[@"search_type"] = @(_searchType);
    parameters[@"sort"] = @(_sort);
    parameters[@"page"] = @"1";
    parameters[@"size"] = @"20";
    [HttpRequest postPath:goodsURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        [self.goodsArray removeAllObjects];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"];
            for (NSDictionary *dic in arr) {
                GoodsIndexModel *goodsIndexModel = [GoodsIndexModel yy_modelWithDictionary:dic];
                [self.goodsArray addObject:goodsIndexModel];
            }
            [_collectionView reloadData];
            
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
    }];
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

/**
 *  添加下拉加载
 */
-(void)setUpRefresh
{
    WEAKSELF
    
//    _collectionView.mj_footer  = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _leftPage ++;
//        _leftType = 1;
//        [weakSelf loadData];
//    }];
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HotCollectionCell alloc] init];
    }
    [cell setUpData:self.goodsArray[indexPath.item]];
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
            _searchType = 1;
            _sort = 2;
            NSLog(@"综合");
        }
            break;
        case 1:
        {
            _searchType = 2;
            _sort = 2;
            NSLog(@"销量");
        }
            break;
        case 2:
        {
            NSLog(@"价格降序");
            _searchType = 3;
            _sort = 2;
        }
            break;
        case 3:
        {
            NSLog(@"价格升序");
            _searchType = 3;
            _sort = 1;
        }
            break;
        case 4:
        {
            NSLog(@"上新");
            _searchType = 4;
            _sort = 2;
        }
            break;
            
        default:
            break;
    }
    
    [self loadGoodsData];
}

#pragma mark 懒加载
- (NSMutableArray *)goodsArray {
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

@end
