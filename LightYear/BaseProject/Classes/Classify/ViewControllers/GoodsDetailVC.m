//
//  GoodsDetailVC.m
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "GoodsDetailVC.h"

@interface GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _carCount;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) GoodsDetailModel *goodsDetailModel;
@property(nonatomic,strong) UILabel *countLb;//购物车数量

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"商品详情";
    [self loadGoodsData];
    [self creatBottomView];
}

- (void)creatView {
    //    WEAKSELF
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.backgroundColor = DPBGGrayColor;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)creatBottomView {
    _carCount = 1;
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kScreenW);
        make.height.mas_offset(SizeWidth(48));
        make.bottom.left.equalTo(self.view);
    }];
    
    UIButton *carBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(105), SizeWidth(48))];
    [carBtn addTarget:self action:@selector(shopCarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:carBtn];
    
    UIImageView *carImgV = [UIImageView new];
    carImgV.image = [UIImage imageNamed:@"details_gouwuche"];
    [carBtn addSubview:carImgV];
    [carImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(carBtn);
        make.top.equalTo(carBtn).offset(SizeWidth(8));
    }];
    
    UILabel *carLb = [UILabel new];
    carLb.text = @"购物车";
    carLb.textColor = RGBColor(102, 102, 102);
    carLb.font = NormalFont(10);
    [carBtn addSubview:carLb];
    [carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(carBtn);
        make.bottom.equalTo(carBtn).offset(-SizeWidth(5));
    }];
    
    _countLb = [UILabel new];
    _countLb.text = [NSString stringWithFormat:@"%ld",_carCount];
    _countLb.textAlignment = NSTextAlignmentCenter;
    _countLb.layer.masksToBounds = YES;
    _countLb.layer.cornerRadius = SizeWidth(7);
    _countLb.backgroundColor = RGBColor(255, 76, 68);
    _countLb.textColor = [UIColor whiteColor];
    _countLb.font = NormalFont(11);
    [carBtn addSubview:_countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(carImgV.mas_top);
        make.centerX.equalTo(carImgV.mas_right);
        make.height.width.mas_offset(SizeWidth(14));
    }];
    
    UIButton *joinCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(105), 0, SizeWidth(135), SizeWidth(48))];
    joinCarBtn.backgroundColor = RGBColor(255, 190, 89);
    [joinCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [joinCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    joinCarBtn.titleLabel.font = NormalFont(16);
    [joinCarBtn addTarget:self action:@selector(joinShopCarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:joinCarBtn];
    
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(240), 0, SizeWidth(135), SizeWidth(48))];
    buyBtn.backgroundColor = RGBColor(52, 187, 42);
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = NormalFont(16);
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyBtn];
}

- (void)loadGoodsData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"id"] = _goodsId;

    [HttpRequest postPath:goodsInfoURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];

        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSDictionary *dic = responseObject[@"info"];
            _goodsDetailModel = [GoodsDetailModel yy_modelWithDictionary:dic];
            
            [_tableView reloadData];
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }

    }];
}

- (void)loadSetCarData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"count"] = @"1";
    parameters[@"price"] = _goodsDetailModel.original_price;
    parameters[@"good_id"] = _goodsDetailModel.goodsId;
    parameters[@"sku_id"] = _goodsId;
    parameters[@"shopid"] = @"3";
    
    [HttpRequest postPath:setCarURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
//            NSDictionary *dic = responseObject[@"info"];
            _carCount ++;
            _countLb.text = [NSString stringWithFormat:@"%ld",_carCount];
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = RGBColor(241, 241, 241);
    return view;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
    
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
            static NSString*cellIdentifier = @"UITableViewCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
//            cell.bannerArray = @[@""];
//            cell.delegate = self;
            return cell;
        }
            break;
        case 1:
        {
            static NSString*cellIdentifier = @"HomeItemsCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
//            cell.delegate = self;
            return cell;
        }
            break;
            
        default:
        {
            static NSString*cellIdentifier = @"UITableViewCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
//            cell.delegate = self;
            return cell;
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return SizeWidth(375);
            break;
        case 1:
            return SizeWidth(131);
            break;
        default:
            return SizeWidth(1000);
            break;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark 按钮事件
- (void)shopCarBtnAction {
    
}

- (void)joinShopCarBtnAction {
    [self loadSetCarData];
    
}

- (void)buyBtnAction {
    
}

@end
