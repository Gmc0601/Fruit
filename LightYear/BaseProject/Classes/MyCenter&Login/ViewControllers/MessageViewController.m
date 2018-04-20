//
//  MessageViewController.m
//  BaseProject
//
//  Created by cc on 2018/4/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "UIView+LoadState.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *noUseTableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"消息";
    [self.rightBar setTitle:@"清空" forState:UIControlStateNormal];
    [self.view addSubview:self.noUseTableView];
//    [self.view showLoadStateWithMaskViewStateType:viewStateWithEmpty];
}

- (void)more:(UIButton *)sender {
//    清空
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid = @"cellid";
    MessageTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    return cell;
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:FRAME(0, 0, kScreenW, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:FRAME(0, 10, kScreenW, 20)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor =  RGBColor(153, 153, 153);
    lab.text = @"今天 12：25";
    lab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:lab];
    return headerView;
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
    }
    return _noUseTableView;
}

@end
