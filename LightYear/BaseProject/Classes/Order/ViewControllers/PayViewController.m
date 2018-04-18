//
//  PayViewController.m
//  BaseProject
//
//  Created by cc on 2018/4/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "PayViewController.h"
#import "PaytypeTableViewCell.h"

@interface PayViewController ()<UITableViewDelegate, UITableViewDataSource>{
    int paytype;
}

@property (nonatomic, strong) NSArray *titleArr, *iconArr;

@property (nonatomic, strong) UITableView *noUseTableView;

@property (nonatomic, strong) UIButton *payBtn;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"支付";
    self.rightBar.hidden = YES;
    [self.view addSubview:self.noUseTableView];
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
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = self.payMoney;
    }
    if (indexPath.row == 1) {
        cell.btn.hidden = YES;
        cell.backgroundColor = RGBColor(239, 240, 241);
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
    [cell.imageView sizeToFit];
    return cell;
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row  == 1? 50 : 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i = 2; i < 5; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        PaytypeTableViewCell *cell = [self.noUseTableView cellForRowAtIndexPath:index];
        if (indexPath.row == i) {
            cell.btn.selected = YES;
        }else {
            cell.btn.selected = NO;
        }
        paytype = (int)indexPath.row - 2;
    }
    

    
    
}
- (UITableView *)noUseTableView {
    if (!_noUseTableView) {
        _noUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStyleGrouped];
        _noUseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noUseTableView.backgroundColor = RGBColor(239, 240, 241);
        _noUseTableView.delegate = self;
        _noUseTableView.dataSource = self;
        _noUseTableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *line = [[UILabel alloc] initWithFrame:FRAME(0, 0, kScreenW, 20)];
            line.backgroundColor = RGBColor(239, 240, 241);
            [view addSubview:line];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:FRAME(20, 20, kScreenW - 40, 50)];
        _payBtn.backgroundColor = ThemeGreen;
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.cornerRadius = 3;
        [_payBtn addTarget:self action:@selector(payclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (void)payclick:(UIButton *)sender {
    
    
}
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"订单需支付", @"支付方式", @"支付宝支付", @"微信支付", @"钱包支付(余额:￥500)"];
    }
    return _titleArr;
}
- (NSArray *)iconArr {
    if (!_iconArr) {
        _iconArr = @[@"", @"", @"chongzhi_zfb", @"chongzhi_wx", @"chongzhi_vip"];
    }
    return _iconArr;
}

@end
