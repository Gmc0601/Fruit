//
//  TopUpViewController.m
//  BaseProject
//
//  Created by cc on 2018/4/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "TopUpViewController.h"
#import "ABButton.h"
#import "UIView+Extension.h"
#import "TopupModel.h"
#import <MJExtension/MJExtension.h>
#import "PaytypeTableViewCell.h"
#import "PayViewController.h"
#import "HHPayPasswordView.h"
#import "OrderDetialViewController.h"
#import "OrderViewController.h"
#import "ChangeUserInfoViewController.h"


@interface TopUpViewController ()<UITableViewDelegate, UITableViewDataSource,HHPayPasswordViewDelegate>{
    float viewheigh;
    int selecedID, paytype;
    NSString *paybtnStr;
}

@property (nonatomic, strong) UITableView *noUseTableView;

@property (nonatomic, strong) UIButton *payBtn;

@property (nonatomic, strong) NSMutableArray *moneyArr;

@property (nonatomic, strong) NSArray *titleArr, *iconArr;

@property (nonatomic, strong) UILabel *topaylab;

@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    paytype = -1;
    self.titleLab.text = @"充值";
    self.rightBar.hidden = YES;
    
    if (self.type == Topup_wallet) {
        [HttpRequest postPath:@"_user_recharge_list_001" params:nil resultBlock:^(id responseObject, NSError *error) {
            NSLog(@"%@", responseObject);
            if([error isEqual:[NSNull null]] || error == nil){
                NSLog(@"success");
            }
            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] == 0) {
                NSArray *info = datadic[@"info"];
                self.moneyArr =[TopupModel mj_objectArrayWithKeyValuesArray:info];
                UIView *view = [[UIView alloc] initWithFrame:FRAME(0, 0, 10, 10)];
                view.hidden = YES;
                [self addmoneyBtn:view];
                paybtnStr = @"立即充值";
                [self.view addSubview:self.noUseTableView];
                
            }else {
                NSString *str = datadic[@"info"];
                [ConfigModel mbProgressHUD:str andView:nil];
            }
        }];
    }
    
    if (self.type == Topup_order) {
        //  订单支付
        viewheigh = 70;
        paybtnStr = @"立即支付";
        NSString *vip = [NSString stringWithFormat:@"会员卡(余额:￥%@)",self.model.blance];
        self.titleArr = @[@"支付方式", @"支付宝支付", @"微信支付", vip];
        self.iconArr = @[@"", @"chongzhi_zfb", @"chongzhi_wx", @"chongzhi_vip"];
        [self.view addSubview:self.noUseTableView];
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cellid";
    PaytypeTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PaytypeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        cell.btn.hidden = YES;
        cell.backgroundColor = RGBColor(239, 240, 241);
    }
    if (indexPath.row == paytype) {
        cell.btn.selected = YES;
    }else {
        cell.btn.selected = NO;
    }
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
    [cell.imageView sizeToFit];
    return cell;
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row ? 65 : 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PaytypeTableViewCell *cell = [self.noUseTableView cellForRowAtIndexPath:indexPath];
//    cell.btn.selected = YES;
//    NSIndexPath *index;
    if (indexPath.row == 1) {
//        index = [NSIndexPath indexPathForRow:2 inSection:0];
        paytype = 1;
    }
    if (indexPath.row == 2) {
        paytype = 2;
//        index = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    if (indexPath.row == 3) {
        paytype = 3;
//        index = [NSIndexPath indexPathForRow:3 inSection:<#(NSInteger)#>]
    }
//    PaytypeTableViewCell *chancle  = [self.noUseTableView cellForRowAtIndexPath:index];
//    chancle.btn.selected = NO;
    [self.noUseTableView reloadData];

}
- (UITableView *)noUseTableView {
    if (!_noUseTableView) {
        _noUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStyleGrouped];
        _noUseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noUseTableView.backgroundColor = RGBColor(239, 240, 241);
        _noUseTableView.delegate = self;
        _noUseTableView.dataSource = self;
        _noUseTableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, viewheigh)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *line = [[UILabel alloc] initWithFrame:FRAME(0, 0, kScreenW, 20)];
            line.backgroundColor = RGBColor(239, 240, 241);
            [view addSubview:line];
            if (self.type == Topup_wallet) {
               [self addmoneyBtn:view];
            }
            if (self.type == Topup_order) {
                [self addblancel:view];
            }
            view;
        });
        _noUseTableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,  90)];
            [view addSubview:self.payBtn];
            view;
        });
    }
    return _noUseTableView;
}

- (void)addblancel:(UIView *)view {
    

    
    UILabel *title = [[UILabel alloc] initWithFrame:FRAME(15, 15 + 20, kScreenW, 15)];
    title.text = @"订单需支付：";
    title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    title.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
    [view addSubview:title];
    
    self.topaylab = [[UILabel alloc] initWithFrame:FRAME(0, 15 + 20, kScreenW - 15, 15)];
    self.topaylab.font = [UIFont fontWithName:@"DINAlternate-Bold" size:18];
    self.topaylab.textColor = [UIColor colorWithRed:255/255 green:76/255 blue:68/255 alpha:1];
    self.topaylab.text = [NSString stringWithFormat:@"￥%.2f", self.model.amount];
    self.topaylab.textAlignment = NSTextAlignmentRight;
    [view addSubview:self.topaylab];
    
}

- (void)addmoneyBtn:(UIView *)view {
    #define ABButtonMargin 10.0
    float heigh = 0;
    for (int i = 0; i < self.moneyArr.count; i++) {
        ABButton *abBtn = [[ABButton alloc] init];
        abBtn.tag = 100 + i;
        TopupModel *model = self.moneyArr[i];
        abBtn.aboveL.tag = [model.id intValue]+ 1000;
        [abBtn buttonWithAboveLabelTitle:[NSString stringWithFormat:@"￥%@",model.online_money] belowLabelTitle:[NSString stringWithFormat:@"送%@元", model.free_money]];
        int col = i % 3;
        abBtn.x = col * (abBtn.width + ABButtonMargin)+20;
        int row = i / 3;
        abBtn.y = row * (abBtn.height + ABButtonMargin)+40;
        if (abBtn.y > heigh) {
            heigh = abBtn.y;
        }
        [view addSubview:abBtn];
        [abBtn addTarget:self action:@selector(chargePhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    heigh = heigh + 10 + 60;
    viewheigh = heigh;
}

-(void)chargePhone:(ABButton*)sender{
    
    sender.selected = !sender.selected;
    int tagint = (int)sender.tag - 100;
    selecedID = (int)sender.aboveL.tag - 1000;
    sender.backgroundColor = ThemeGreen ;
    sender.aboveL.textColor =  [UIColor whiteColor] ;
    sender.belowL.textColor =  [UIColor whiteColor] ;
    
    for (int i = 0; i < self.moneyArr.count; i++) {
        ABButton *btn = (ABButton *)[self.view viewWithTag:100 + i];
        if (i == tagint) {
            continue;
        }
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
        btn.aboveL.textColor = ThemeGreen;
        btn.belowL.textColor = [UIColor blackColor];
    }
    
    NSLog(@"充值%@", sender.aboveL.text);
    
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:FRAME(20, 20, kScreenW - 40, 50)];
        _payBtn.backgroundColor = ThemeGreen;
        [_payBtn setTitle:paybtnStr forState:UIControlStateNormal];
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.cornerRadius = 3;
        [_payBtn addTarget:self action:@selector(payclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (void)payclick:(UIButton *)sender {
    
    if (paytype < 0) {
        [ConfigModel mbProgressHUD:@"请选择支付方式" andView:nil];
        return;
    }
    
    if (paytype < 3) {
    //  支付宝 和 微信
        
    }
    
    if (paytype == 3) {
        //  余额 支付
        //    //  原来支付
            HHPayPasswordView *payPasswordView = [[HHPayPasswordView alloc] init];
            payPasswordView.delegate = self;
            WeakSelf(weak);
            payPasswordView.closeBlock = ^{
                OrderDetialViewController *vc = [[OrderDetialViewController alloc] init];
                vc.OrderID = self.model.orderid;
                vc.orderType = Order_Topay;
                vc.backHome = YES;
                [weak.navigationController pushViewController:vc animated:YES];
            };
            [payPasswordView showInView:self.view];
    }
    
}
#pragma mark - HHPayPasswordViewDelegate
- (void)passwordView:(HHPayPasswordView *)passwordView didFinishInputPayPassword:(NSString *)password{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //   请求网络
        NSDictionary *dic = @{
                              @"invest_id" : self.model.orderid,
                              @"tradePwd" : password
                              };
        WeakSelf(weakself);
        [HttpRequest postPath:@"_pay_001" params:dic resultBlock:^(id responseObject, NSError *error) {
            NSLog(@"%@", responseObject);
            
            if([error isEqual:[NSNull null]] || error == nil){
                NSLog(@"success");
                
            }
            
            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] == 0) {
                [passwordView paySuccess];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [passwordView hide];
                    OrderViewController  *vc = [[OrderViewController alloc] init];
                    vc.listType = OrderList_All;
                    vc.backHome = YES;
                    [weakself.navigationController pushViewController:vc animated:YES];
                });
            }else {
                [passwordView payFailureWithPasswordError:YES withErrorLimit:3];
                [ConfigModel mbProgressHUD:@"支付密码错误" andView:nil];
            }
        }];
        
        
    });
}

- (void)forgetPayPassword {
    //  忘记密码
    ChangeUserInfoViewController * changeUserInfoVC = [[ChangeUserInfoViewController alloc] init];
    changeUserInfoVC.type = UserInfoTypePayPassword;
    [self.navigationController pushViewController:changeUserInfoVC animated:YES];
    
}

- (NSMutableArray *)moneyArr {
    if (!_moneyArr) {
        _moneyArr = [[NSMutableArray alloc] init];
    }
    return _moneyArr;
}


- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"支付方式", @"支付宝支付", @"微信支付"];
    }
    return _titleArr;
}

- (NSArray *)iconArr {
    if (!_iconArr) {
        _iconArr = @[@"", @"chongzhi_zfb", @"chongzhi_wx"];
    }
    return _iconArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
