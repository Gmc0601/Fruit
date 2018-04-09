//
//  GoodsDetailVC.m
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "GoodsDetailVC.h"

@interface GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"商品详情";
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

#pragma mark UITableViewDelegate,UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [UIView new];
//    view.backgroundColor = RGBColor(241, 241, 241);
//    return view;
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 2) {
//        return [self creatHeaderView];
//    } else {
//        return nil;
//    }
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 1) {
//        return SizeWidth(10);
//    } else {
//        return 0.01;
//    }
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 2) {
//        return SizeWidth(44);
//    } else {
//        return 0.01;
//    }
//    
//}
//
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case 0:
//        {
//            static NSString*cellIdentifier = @"HomeBannerCell";
//            HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            if (cell == nil) {
//                cell = [[HomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            }
//            cell.bannerArray = @[@""];
//            cell.delegate = self;
//            return cell;
//        }
//            break;
//        case 1:
//        {
//            static NSString*cellIdentifier = @"HomeItemsCell";
//            HomeItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            if (cell == nil) {
//                cell = [[HomeItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            }
//            cell.delegate = self;
//            return cell;
//        }
//            break;
//            
//        default:
//        {
//            static NSString*cellIdentifier = @"HomeHotCell";
//            HomeHotCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            if (cell == nil) {
//                cell = [[HomeHotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            }
//            cell.delegate = self;
//            return cell;
//        }
//            break;
//    }
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case 0:
//            return SizeWidth(180);
//            break;
//        case 1:
//            return SizeWidth(185);
//            break;
//        default:
//            return SizeWidth(1000);
//            break;
//    }
//    return 0.01;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

@end
