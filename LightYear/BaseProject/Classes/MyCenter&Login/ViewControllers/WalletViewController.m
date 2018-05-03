//
//  WalletViewController.m
//  BaseProject
//
//  Created by cc on 2018/4/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "WalletViewController.h"
#import "UIView+Frame.h"
#import "TransformTableViewCell.h"
#import "TopUpViewController.h"
#import "TransformModel.h"
#import <MJExtension/MJExtension.h>

@interface WalletViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *noUseTableView;

@property (nonatomic, strong) UILabel *blanceLab;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.backgroundColor = ThemeGreen;
    [self.leftBar setImage:[UIImage imageNamed:@"zz"] forState:UIControlStateNormal];
    self.titleLab.textColor = [UIColor whiteColor];
    self.titleLab.text = @"钱包";
    [self.rightBar setTitle:@"充值" forState:UIControlStateNormal];
    [self.rightBar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.noUseTableView];
    
 

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HttpRequest postPath:@"_user_score_total_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = datadic[@"info"];
            //            NSString *intgral = infoDic[@"integral"];
            NSString *amount = [NSString stringWithFormat:@"%@", infoDic[@"amount"]];
            self.blanceLab.text = [NSString stringWithFormat:@"%.2f", [amount floatValue]];
            
        }else {
            NSString *str = datadic[@"info"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    
    [HttpRequest postPath:@"_trade_list_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSArray *info = datadic[@"info"];
            self.dataArr = [TransformModel mj_objectArrayWithKeyValuesArray:info];
            [self.noUseTableView reloadData];
        }else {
            NSString *str = datadic[@"info"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
}

- (void)more:(UIButton *)sender {
    TopUpViewController *vc = [[TopUpViewController alloc] init];
    vc.type = Topup_wallet;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section ? self.dataArr.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid = [NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row];
    if (indexPath.section == 0) {
        UITableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        }
        cell.textLabel.text = @"钱包明细";
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        return cell;
    }else {
        TransformTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TransformTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        }
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (UITableView *)noUseTableView {
    if (!_noUseTableView) {
        _noUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
        _noUseTableView.backgroundColor = RGBColor(239, 240, 241);
        _noUseTableView.delegate = self;
        _noUseTableView.dataSource = self;
        _noUseTableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 110)];
            view.backgroundColor = ThemeGreen;
            [view addSubview:self.blanceLab];
            [self.blanceLab setCenterX:view.centerX];
            [self.blanceLab setCenterY:view.centerY];
            UILabel *lab = [[UILabel alloc] initWithFrame:FRAME(0, self.blanceLab.bottom + 10, kScreenW, 16)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:16];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = RGBColor(255, 255, 255);
            lab.text = @"我的余额";
            [view addSubview:lab];
            view;
        });
        _noUseTableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,  SizeHeigh(0))];
            view;
        });
    }
    return _noUseTableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UILabel *)blanceLab {
    if (!_blanceLab) {
        _blanceLab = [[UILabel alloc] initWithFrame:FRAME(0, 0, kScreenW, 30)];
        _blanceLab.font = [UIFont fontWithName:@"DINAlternate-Bold" size:36];
        _blanceLab.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
        _blanceLab.textAlignment = NSTextAlignmentCenter;
        _blanceLab.text = @"1000";
    }
    return _blanceLab;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
