//
//  GoodsDetailVC.m
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "GoodsDetailVC.h"

#import "AllCommentsVC.h"
#import "MakeOrderViewController.h"

#import "GoodsDetailImgCell.h"
#import "GoodsDetailTitleCell.h"
#import "CommentCell.h"
#import "GoodsDetailCell.h"



@interface GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _carCount;
    NSString *_commentCount;
    CGFloat _webHeight;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) GoodsDetailModel *goodsDetailModel;
@property(nonatomic,strong) UILabel *countLb;//购物车数量
@property(nonatomic,strong) NSMutableArray *commentArray;

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"商品详情";
    [self creatView];
    [self loadGoodsData];
    [self loadCommentsData];
    [self creatBottomView];
    [self loadCarCountData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webviewHeight:) name:@"goodsDetailHeight" object:nil];
}

- (void)webviewHeight:(NSNotification *)noti {
    _webHeight = [noti.userInfo[@"height"] floatValue];
    [_tableView reloadData];
}

- (void)creatView {
    //    WEAKSELF
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-SizeWidth(48)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.backgroundColor = DPBGGrayColor;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)creatBottomView {
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
//    _countLb.text = [NSString stringWithFormat:@"%ld",_carCount];
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

- (UIView *)creatHeader:(NSString *)comment {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(44))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentDetailAction)];
    [backView addGestureRecognizer:tap];
    
    UILabel *lb = [UILabel new];
    lb.text = @"商品评论";
    lb.textColor = RGBColor(51, 51, 51);
    lb.font = BOLDSYSTEMFONT(17);
    [backView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.left.equalTo(backView).offset(SizeWidth(15));
    }];
    
    UIImageView *imgV = [UIImageView new];
    imgV.image = [UIImage imageNamed:@"wode_forward"];
    [backView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.right.equalTo(backView).offset(-SizeWidth(16));
    }];
    
    UILabel *lb2 = [UILabel new];
    lb2.text = comment;
    lb2.textColor = RGBColor(153, 153, 153);
    lb2.font = NormalFont(14);
    [backView addSubview:lb2];
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.right.equalTo(imgV.mas_left).offset(-SizeWidth(10));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = RGBColor(241, 241, 241);
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.height.mas_offset(0.5);
    }];
    
    return backView;
}

- (UIView *)creatHeader1{
    UIView *view = [UIView new];
    view.backgroundColor = RGBColor(241, 241, 241);
        
    UIView *line = [UIView new];
    line.backgroundColor = RGBColor(204, 204, 204);
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(SizeWidth(1));
        make.width.mas_offset(kScreenW);
        make.centerX.centerY.equalTo(view);
    }];
        
    UILabel *lb = [UILabel new];
    lb.text = @"上拉查看商品详情";
    lb.backgroundColor = RGBColor(241, 241, 241);
    lb.font = NormalFont(13);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = RGBColor(153, 153, 153);
    [view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(view);
        make.width.mas_offset(SizeWidth(130));
    }];
    return view;
    
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
//    parameters[@"sku_id"] = _goodsId;
    parameters[@"shopid"] = @"3";
    
    [HttpRequest postPath:setCarURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
//            NSDictionary *dic = responseObject[@"info"];
            _carCount ++;
            _countLb.text = [NSString stringWithFormat:@"%ld",_carCount];
            if (_carCount == 0) {
                _countLb.hidden = YES;
            }else {
                _countLb.hidden = NO;
            }
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        
    }];
}

- (void)loadCommentsData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"good_id"] = _goodsId;
    parameters[@"page"] = @"1";
    parameters[@"size"] = @"2";
    
    [HttpRequest postPath:commentUrl params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        [self.commentArray removeAllObjects];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            _commentCount = [NSString stringWithFormat:@"%@条评论",responseObject[@"info"][@"sorceinfo"][@"count"]];
            NSArray *arr = responseObject[@"info"][@"data"];
            for (NSDictionary *dic in arr) {
                CommentsModel *commentsModel = [CommentsModel yy_modelWithDictionary:dic];
                [self.commentArray addObject:commentsModel];
            }
            [_tableView reloadData];
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        
    }];
}

- (void)loadCarCountData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [HttpRequest postPath:carCountURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            _carCount = [responseObject[@"info"] integerValue];
            _countLb.text = [NSString stringWithFormat:@"%ld",_carCount];
            if (_carCount == 0) {
                _countLb.hidden = YES;
            }else {
                _countLb.hidden = NO;
            }
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
    if (section == 2) {
        return self.commentArray.count;
    } else {
        return 1;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return [self creatHeader:_commentCount];
    }else if (section == 3) {
        return [self creatHeader1];
    }
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
    }else if (section == 3) {
        return SizeWidth(36);
    } else {
        return 0.01;
    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            static NSString*cellIdentifier = @"GoodsDetailImgCell";
            GoodsDetailImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[GoodsDetailImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.imgArray = _goodsDetailModel.img_path;
            return cell;
        }
            break;
        case 1:
        {
            static NSString*cellIdentifier = @"GoodsDetailTitleCell";
            GoodsDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[GoodsDetailTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setUpData:_goodsDetailModel];
            return cell;
        }
            break;
        case 2:
        {
            static NSString*cellIdentifier = @"CommentCell";
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setUpData:self.commentArray[indexPath.row]];
            return cell;
        }
            break;
        default:
        {
            static NSString*cellIdentifier = @"GoodsDetailCell";
            GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[GoodsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setUpData: _goodsDetailModel.desc];
            return cell;
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return SizeWidth(375);
        }
            break;
        case 1:
        {
            return SizeWidth(131);
        }
            break;
        case 2:
        {
            CommentsModel *model = self.commentArray[indexPath.row];
            CGFloat textH = [UtilHelper getHeightWithString:model.content fontSize:14 maxWidth:SizeWidth(349)];
            CGFloat h = textH+SizeWidth(90);
            return h;
        }
            break;
        default:
        {
            return SizeWidth(_webHeight);
        }
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
    MakeOrderViewController *vc = [MakeOrderViewController new];
    vc.OrderID = _goodsDetailModel.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)commentDetailAction {
    AllCommentsVC *vc = [AllCommentsVC new];
    vc.goodsId = _goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 懒加载
- (NSMutableArray *)commentArray {
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray  new];
        
    }
    return _commentArray;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}


@end
