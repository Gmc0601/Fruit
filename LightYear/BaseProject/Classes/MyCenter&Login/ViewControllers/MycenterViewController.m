//
//  MycenterViewController.m
//  BaseProject
//
//  Created by cc on 2017/9/6.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "MycenterViewController.h"
#import "UserInfoViewController.h"
#import "MycenterHeadView.h"
#import "DeliveryAddressViewController.h"
#import "EditFeedBackViewController.h"
#import "UserInfoPicketView.h"
#import "OrderViewController.h"
#import "LoginViewController.h"
#import "WMHomePageViewController.h"
#import "UserModel.h"
#import "WalletViewController.h"
#import "ShoplistVC.h"
#import "InspectCouponViewController.h"

@interface MycenterViewController ()<UITableViewDelegate,UITableViewDataSource,MycenterHeadViewDelegate,UserInfoPicketViewDelegate>
{
    UIButton * bottomButton;
    UITableView * myTableView;
    NSMutableArray * dataArray;
    MycenterHeadView * headView;
    UserInfoPicketView * picketView;
        UserInfo * userModel;
}
@end

@implementation MycenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    NSArray *arr = @[@[@"收货地址",@"意见反馈",@"切换店铺"],@[@"设置"]];
    dataArray = [NSMutableArray arrayWithArray:arr];//,@"分享App给朋友
    self.navigationView.hidden = YES;
    [self createBaseView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![ConfigModel getBoolObjectforKey:IsLogin]) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.clickBlock = ^(NSString *str) {
            self.tabBarController.selectedIndex = 0;
        };
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:na animated:YES completion:nil];
        return;
    }
    
    [HttpRequest postPath:@"_user_score_total_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = datadic[@"info"];
//            NSString *intgral = infoDic[@"integral"];
            NSString *amount = [NSString stringWithFormat:@"%@", infoDic[@"amount"]];
            NSString *coupon = [NSString stringWithFormat:@"%@", infoDic[@"coupon"]];
            headView.blanceLab.text = [NSString stringWithFormat:@"%.2f", [amount floatValue]];
            headView.couponLab.text = coupon;
            
        }else {
            NSString *str = datadic[@"info"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    userModel = [[TMCache sharedCache] objectForKey:UserInfoModel];
    self.rightBar.hidden = YES;
    if (userModel) {
        headView.nickLab.text = userModel.nickname;
//        if ([userModel.nickname containsString:@","]) {
//            NSArray *nameArr = [userModel.nickname componentsSeparatedByString:@","];
//            NSString *name = [nameArr componentsJoinedByString:@""];
//            self.titleLab.text = [NSString stringWithFormat:@"%@ %@",[self getCurrentTime],name];
//        } else {
//            self.titleLab.text = [NSString stringWithFormat:@"%@ %@",[self getCurrentTime],userModel.nickname];
//        }
    }else{
//        self.titleLab.text = [self getCurrentTime];
    }
}
//- (void)back:(UIButton *)sender{
//    for (UIViewController * controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[WMHomePageViewController class]]) {
//            WMHomePageViewController * homeVC =(WMHomePageViewController *)controller;
//            [self.navigationController popToViewController:homeVC animated:YES];
//        }
//    }
//}
- (void)createBaseView{
    bottomButton = [UIButton new];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [bottomButton setTitle:@"退出" forState:UIControlStateNormal];
    [bottomButton setTitleColor:ThemeGreen forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(exitLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-20);
        make.centerX.mas_offset(0);
    }];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
//    myTableView.bounces = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor whiteColor];
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(-20);
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(bottomButton.mas_top).mas_offset(-10);
    }];
    [self initTbaleViewHeadView];
    [self.view addSubview:self.titleLab];
    self.titleLab.text = @"个人中心";
    self.titleLab.textColor = [UIColor whiteColor];
    [self.view addSubview:self.rightBar];
    [self.rightBar setTitle:@"" forState:UIControlStateNormal];
    [self.rightBar setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    self.rightBar.backgroundColor = [UIColor clearColor];
    self.rightBar.frame =CGRectMake(kScreenW - 10 - 40, 20, 40, 30);
    
}
- (void)initTbaleViewHeadView{
    UserInfo * userModel = [[TMCache sharedCache] objectForKey:UserInfoModel];
    headView = [[MycenterHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 300)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.delegate = self;
    headView.headImage.image = [UIImage imageNamed:@"icon_grzx_tx"];
    [headView.headImage sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url] placeholderImage:[UIImage imageNamed:@"icon_grzl_tx"]];
    myTableView.tableHeaderView = headView;
}
#pragma mark MycenterHeadViewDelegate
- (void)didMycenterHeadViewButton:(UIButton*)button{
    if (button.tag == 10) {
        //个人中心
        UserInfoViewController * userInfoVC = [[UserInfoViewController alloc] init];
        [userInfoVC setFinishBlock:^(NSString * headImg){
            [headView.headImage sd_setImageWithURL:[NSURL URLWithString:headImg] placeholderImage:[UIImage imageNamed:@"icon_grzl_tx"]];
        }];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }else{
        //订单 20--24
        OrderViewController *vc = [[OrderViewController alloc] init];
        /*
         OrderList_All,            //  全部订单
         OrderList_Distribution,   //  待配送
         OrderList_Invite,         //  待自取
         OrderList_Distributioning,//  配送中
         OrderList_Topay           //  待支付
         */
        
        if (button.tag >= 25) {
            
            if (button.tag == 25) {
                WalletViewController *vc = [[WalletViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (button.tag == 26) {
                InspectCouponViewController *vc = [[InspectCouponViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            return;
        }
        
        switch (button.tag) {
            case 20:
                vc.listType = OrderList_All;
                break;
            case 21:
                vc.listType = OrderList_Distribution;
                break;
            case 22:
                vc.listType = OrderList_Invite;
                break;
            case 23:
                vc.listType = OrderList_Distributioning;
                break;
            case 24:
                vc.listType = OrderList_Topay;
                break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = RGBColor(239, 240, 241);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = UIColorFromHex(0xcccccc);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
//    if (indexPath.section == 2) {
//        UILabel * detailLabel = [UILabel new];
//        detailLabel.text = @"0571-0000999";
//        detailLabel.textColor = UIColorFromHex(0x999999);
//        detailLabel.font = [UIFont systemFontOfSize:14];
//        [cell.textLabel addSubview:detailLabel];
//        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_offset(0);
//            make.centerY.mas_offset(0);
//        }];
//    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //收货地址
            DeliveryAddressViewController * addressVC = [[DeliveryAddressViewController alloc] init];
            [self.navigationController pushViewController:addressVC animated:YES];
        }else if (indexPath.row == 1){
            //意见反馈
            EditFeedBackViewController * feedBackVC = [[EditFeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }else if (indexPath.row == 2){
            //联系我们
            //        切换店铺
            ShoplistVC *vc = [[ShoplistVC alloc] init];
            vc.back = YES;
            [self.navigationController pushViewController:vc animated:YES];
            //        NSMutableArray * array = [NSMutableArray arrayWithObjects:@"13879888888",@"13097890000", nil];
            //        picketView = [[UserInfoPicketView alloc] init];
            //        picketView.delegate = self;
            //        picketView.tag = 10;
            //        picketView.picketTitle = @"联系我们";
            //        picketView.sureButtonTitle = @"立即联系";
            //        picketView.pickViewTextArray = array;
            //        picketView.picketType = PicketViewTypeDefault;
            //        [self.view addSubview:picketView];
        }
        else if (indexPath.section == 3){
            //        //分享
            //        NSMutableArray * array = [NSMutableArray arrayWithObjects:@"朋友圈",@"微信好友", @"QQ好友",@"QQ空间",nil];
            //        NSMutableArray * imgArray = [NSMutableArray arrayWithObjects:@"icon_fx_pyq",@"icon_fx_wx", @"icon_fx_qq",@"icon_fx_qqkj",nil];
            //        picketView = [[UserInfoPicketView alloc] init];
            //        picketView.delegate = self;
            //        picketView.pickViewTextArray = array;
            //        picketView.pickViewImageArray = imgArray;
            //        picketView.picketType = PicketViewTypeNormal;
            //        [self.view addSubview:picketView];
        }
    }else {
        //个人中心
        UserInfoViewController * userInfoVC = [[UserInfoViewController alloc] init];
        [userInfoVC setFinishBlock:^(NSString * headImg){
            [headView.headImage sd_setImageWithURL:[NSURL URLWithString:headImg] placeholderImage:[UIImage imageNamed:@"icon_grzl_tx"]];
        }];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
    
}
#pragma mark -- UserInfoPicketViewDelegate
-(void)PickerSelectorIndex:(NSInteger)index contentString:(NSString *)str{
    if (picketView.tag == 10) {
        //联系我们
        NSMutableString * mStr=[[NSMutableString alloc] initWithFormat:@"tel:%@",str];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mStr]]];
        [self.view addSubview:callWebview];
    }else if (picketView.tag == 20){
        //分享 index=0=@"朋友圈",index=1=@"微信好友", index=2=@"QQ好友",index=3=@"QQ空间"
        
    }
    NSLog(@"PickerView:%ld 选中的是:%ld===%@",picketView.tag,index,str);
    picketView = nil;
}

//退出登录
- (void)exitLoginAction{
    for (UIViewController * controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[WMHomePageViewController class]]) {
            WMHomePageViewController * homeVC =(WMHomePageViewController *)controller;
            [self.navigationController popToViewController:homeVC animated:YES];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:@(1)];
}
//获取当前时间
- (NSString * )getCurrentTime{
    //获取当前的时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [comps hour];
    NSString * timeStr;
    if (hour > 5 &&hour < 12) {
        timeStr = @"早上好!";
    }else if (hour > 11 &&hour < 18){
        timeStr = @"下午好!";
    }else{
        timeStr = @"晚上好!";
    }
    return timeStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
