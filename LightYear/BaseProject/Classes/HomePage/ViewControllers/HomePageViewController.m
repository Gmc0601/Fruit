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

#import "HomeBannerCell.h"
#import "HomeItemsCell.h"
#import "HomeHotCell.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,HomeBannerCellDelegate,HomeItemsCellDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    [self creatLeftBtn];
    [self showNavRightButton:@"" action:@selector(messageAction) image:[UIImage imageNamed:@"home_message"] imageOn:nil];
//    [self loadHomeData];
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
//- (void)loadHomeData {
//    [ConfigModel showHud:self];
//    NSDictionary * params = @{@"shopid":@"82"};
//    [HttpRequest postPath:ShopGoodsType params:params resultBlock:^(id responseObject, NSError *error) {
//        [ConfigModel hideHud:self];
//        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
//        if (baseModel.error == 0) {
//
//            NSLog(@"====%@",responseObject);
//        }else {
//            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
//        }
//    }];
//}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
            cell.bannerArray = @[@""];
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
            
            return cell;
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return SizeWidth(180);
            break;
        case 1:
            return SizeWidth(185);
            break;
        default:
            return SizeWidth(1000);
            break;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark HomeBannerCellDelegate,HomeItemsCellDelegate
/**
 *  点击了广告
 */
-(void)showAdDetailWithIndex:(NSInteger)index {
    NSLog(@"===%ld",index);
}

/**
 *  点击了按钮
 */
- (void)homeItemsDidSelectWithTag:(NSInteger )tag {
    NSLog(@"===%ld",tag);
    ReclassifyVC *vc = [ReclassifyVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 按钮事件
- (void)messageAction {
    NSLog(@"message");
}

- (void)searchBtnAction {
    NSLog(@"search");
    SearchVC *vc = [[SearchVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.definesPresentationContext = YES;
//    vc.delegate = self;
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}

@end
