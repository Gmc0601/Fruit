//
//  HomePageViewController.m
//  BaseProject
//
//  Created by cc on 2018/3/20.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "HomePageViewController.h"

#import "SearchVC.h"
#import "ReclassifyVC.h"
#import "GoodsDetailVC.h"

#import "ShoplistVC.h"

#import "HomeBannerCell.h"
#import "HomeItemsCell.h"
#import "HomeHotCell.h"



@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,HomeBannerCellDelegate,HomeItemsCellDelegate,HomeHotCellDelegate>
{
    NSInteger _leftPage;
}

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *bannerArr;
@property(nonatomic,strong) NSMutableArray *goodsTypeArr;
@property(nonatomic,strong) NSMutableArray *goodsArr;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftPage = 1;
    [self creatView];
    [self creatLeftBtn];
    [self showNavRightButton:@"" action:@selector(messageAction) image:[UIImage imageNamed:@"home_message"] imageOn:nil];
    [self loadBannerData];
    [self loadShopGoodsTypeData];
    [self loadGoodsIndexData];
    
}

- (void)creatView {
    //    WEAKSELF
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = DPBGGrayColor;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setUpRefresh];
}

- (void)creatLeftBtn {
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(312), SizeWidth(33))];
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 4;
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SizeWidth(10), SizeWidth(9), SizeWidth(15), SizeWidth(15))];
    imgV.image = [UIImage imageNamed:@"home_search"];
    [searchBtn addSubview:imgV];

    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(SizeWidth(35), SizeWidth(4), 120, 14)];
    lb.text = @"搜索商品、美食";
    lb.font = NormalFont(14);
    lb.textColor = RGBColor(153, 153, 153);
    [searchBtn addSubview:lb];
    lb.centerY = imgV.centerY;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (UIView *)creatHeaderView {
    UIView *bgV = [UIView new];
    bgV.backgroundColor = [UIColor whiteColor];
    
    UIView *redV = [UIView new];
    redV.backgroundColor = RGBColor(255, 76, 68);
    [bgV addSubview:redV];
    [redV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(bgV);
        make.width.mas_offset(SizeWidth(105));
        make.height.mas_offset(SizeWidth(2));
    }];
    
    UILabel *lb = [UILabel new];
    lb.backgroundColor = [UIColor whiteColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"畅销榜";
    lb.font = BOLDSYSTEMFONT(17);
    lb.textColor = RGBColor(47, 47, 47);
    [bgV addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(bgV);
        make.width.mas_offset(SizeWidth(70));
    }];
    return bgV;
}

#pragma mark 加载数据
/**
 *  添加下拉加载
 */
-(void)setUpRefresh
{
    WEAKSELF
    _tableView.mj_footer  = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _leftPage ++;
        [weakSelf loadGoodsIndexData];
    }];
}

- (void)loadBannerData {
    [ConfigModel showHud:self];
    NSString *shopId = [ConfigModel getStringforKey:ShopId];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"shopid"] = shopId;
    [HttpRequest postPath:homeBannerURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"];
            for (NSDictionary *dic in arr) {
                BannerModel *bannerModel = [BannerModel yy_modelWithDictionary:dic];
                [self.bannerArr addObject:bannerModel];
            }
            [_tableView reloadData];
    
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
    }];
}

- (void)loadShopGoodsTypeData {
    [ConfigModel showHud:self];
    NSString *shopId = [ConfigModel getStringforKey:ShopId];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"shopid"] = shopId;
    [HttpRequest postPath:shopGoodsTypeURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"][@"details"];
            for (NSDictionary *dic in arr) {
                ShopGoodsTypeModel *shopGoodsTypeModel = [ShopGoodsTypeModel yy_modelWithDictionary:dic];
                [self.goodsTypeArr addObject:shopGoodsTypeModel];
            }
            [_tableView reloadData];
            
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
    }];
}

- (void)loadGoodsIndexData {
    [ConfigModel showHud:self];
    NSString *shopId = [ConfigModel getStringforKey:ShopId];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"shopid"] = shopId;
    parameters[@"page"] = @(_leftPage);
    parameters[@"size"] = @"20";
    [HttpRequest postPath:goodsIndexURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"];
            for (NSDictionary *dic in arr) {
                GoodsIndexModel *goodsIndexModel = [GoodsIndexModel yy_modelWithDictionary:dic];
                [self.goodsArr addObject:goodsIndexModel];
            }
            [_tableView reloadData];
            
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        [_tableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.bannerArr.count == 0) {
            return 0;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = RGBColor(241, 241, 241);
    return view;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return [self creatHeaderView];
    } else {
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return SizeWidth(10);
    } else {
        return 0.01;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return SizeWidth(44);
    } else {
        return 0.01;
    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            static NSString*cellIdentifier = @"HomeBannerCell";
            HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.bannerArray = self.bannerArr;
            cell.delegate = self;
            return cell;
        }
            break;
        case 1:
        {
            static NSString*cellIdentifier = @"HomeItemsCell";
            HomeItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HomeItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.delegate = self;
            cell.itemsArray = self.goodsTypeArr;
            return cell;
        }
            break;
            
        default:
        {
            static NSString*cellIdentifier = @"HomeHotCell";
            HomeHotCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HomeHotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.delegate = self;
            cell.dataArr = self.goodsArr;
            return cell;
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            if (self.bannerArr.count == 0) {
                return 0.01;
            } else {
                return SizeWidth(180);
            }
        }

            break;
        case 1:
        {
            if (self.goodsTypeArr.count <= 4) {
                return SizeWidth(100);
            } else {
                return SizeWidth(185);
            }
        }
            break;
        default:
        {
            CGFloat heigh = (self.goodsArr.count/2 + self.goodsArr.count%2)*SizeWidth(250);
            return heigh;
        }
            break;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark HomeBannerCellDelegate  HomeItemsCellDelegate  HomeHotCellDelegate
/**
 *  点击了广告
 */
-(void)showAdDetailWithIndex:(NSInteger)index {
    NSLog(@"===%ld",index);
    BannerModel *bannerModel  = self.bannerArr[index];
    GoodsDetailVC *vc = [GoodsDetailVC new];
    vc.goodsId = bannerModel.goodid;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  点击了按钮
 */
- (void)homeItemsDidSelectWithTag:(NSInteger )tag {
    ShopGoodsTypeModel *shopGoodsTypeModel = self.goodsTypeArr[tag];
    ReclassifyVC *vc = [ReclassifyVC new];
    vc.typeId = shopGoodsTypeModel.typeId;
    vc.titleStr = shopGoodsTypeModel.name;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  点击了畅销榜
 */
-(void)homeHotItemsDidSelectWithTag:(NSInteger)tag {
    GoodsIndexModel *model = self.goodsArr[tag];
    GoodsDetailVC *vc = [GoodsDetailVC new];
    vc.goodsId = model.goodsId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 按钮事件
- (void)messageAction {
    NSLog(@"message");
    
//    JumpMessage([GoodsDetailVC new]);//消息跳转，把类名换掉即可
}

- (void)searchBtnAction {
    NSLog(@"search");
    SearchVC *vc = [[SearchVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.definesPresentationContext = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark 懒加载
- (NSMutableArray *)bannerArr {
    if (_bannerArr == nil) {
        _bannerArr = [NSMutableArray new] ;
    }
    return _bannerArr;
}

- (NSMutableArray *)goodsTypeArr {
    if (_goodsTypeArr == nil) {
        _goodsTypeArr = [NSMutableArray new] ;
    }
    return _goodsTypeArr;
}

- (NSMutableArray *)goodsArr {
    if (_goodsArr == nil) {
        _goodsArr = [NSMutableArray new] ;
    }
    return _goodsArr;
}
@end
