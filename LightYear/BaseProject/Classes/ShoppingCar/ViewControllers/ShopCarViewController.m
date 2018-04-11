//
//  CartVC.m
//  QuWeiFinal
//
//  Created by huangfu on 16/5/31.
//  Copyright © 2016年 quwei. All rights reserved.
//

#import "ShopCarViewController.h"



@interface ShopCarViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * showTbv;
@property (nonatomic,strong)NSMutableArray *cartDatasArr;

@end

@implementation ShopCarViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNav];
    [self createContentView];

}

#pragma mark - 界面初始化
-(void)createNav
{
   
    self.navigationItem.title = @"购物车";
 
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    [rightBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)rightAction
{
    
}

-(void)createContentView
{

//    [self.view addSubview:self.showTbv];
//    [self.showTbv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//   
//    }];
}


#pragma mark - 控件初始化
-(UITableView *)showTbv
{
    if (_showTbv == nil) {
        self.showTbv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.showTbv.sectionHeaderHeight = 0 ;
        self.showTbv.sectionFooterHeight = 0 ;
        self.showTbv.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        //        self.showTbv = [[UITableView alloc ] init];
        self.showTbv.backgroundColor = [UIColor clearColor];
        self.showTbv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
       
        self.showTbv.delegate = self;
        self.showTbv.dataSource = self;
        self.showTbv.separatorColor = [UIColor whiteColor];
        self.showTbv.sectionIndexBackgroundColor = [UIColor whiteColor];

    }
    return _showTbv;
    
}

-(NSMutableArray *)cartDatasArr
{
    if(_cartDatasArr == nil)
    {
        _cartDatasArr = [[NSMutableArray alloc] init];
    }
    return _cartDatasArr;
}


@end
