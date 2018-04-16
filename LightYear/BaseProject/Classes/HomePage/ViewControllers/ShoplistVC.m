//
//  ShoplistVC.m
//  BaseProject
//
//  Created by wuyb on 2018/4/8.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ShoplistVC.h"
#import "ShopListCell.h"


@interface ShoplistVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *itemsArray;

@end

@implementation ShoplistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHomeData];
    [self setCustomerTitle:@"选择店铺"];
    [self showNavRightButton:@"" action:@selector(messageAction) image:[UIImage imageNamed:@"home_message"] imageOn:nil];
    [self creatView];
}

- (void)loadHomeData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"lat"] = @"24.488199";
    parameters[@"lng"] = @"118.180351";
    [HttpRequest postPath:shoplistURL params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        [self.itemsArray removeAllObjects];
        NSLog(@"re===%@",responseObject);
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"];
            for (NSDictionary *dic in arr) {
                ShopModel *shopModel = [ShopModel yy_modelWithDictionary:dic];
                [self.itemsArray addObject:shopModel];
            }
            [_tableView reloadData];
        }else {
            NSLog(@"====%@",baseModel.message);
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
    }];
}

- (void)creatView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGBColor(241, 241, 241);
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemsArray.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*cellIdentifier = @"ShopListCell";
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setUpData:self.itemsArray[indexPath.row]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SizeWidth(244);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark 按钮事件
- (void)messageAction {
    NSLog(@"message");
}

#pragma mark 懒加载
- (NSMutableArray *)itemsArray {
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray new];
    }
    return _itemsArray;
}
@end
