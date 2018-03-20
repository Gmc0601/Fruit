//
//  BaseViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/22.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "BaseViewController.h"
#include "FactorySet.h"


#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define ViewController_BackGround [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]//视图控制器背景颜色
@interface BaseViewController ()
@property (nonatomic, retain) UIView* overlayView;
@property (nonatomic, retain) UIView* bgview;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIImageView *loadingImageView;
@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor =[UIColor whiteColor];
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1){
        [self addLeftBarButtonWithImage:[UIImage imageNamed:@"ic_back"] action:@selector(backAction)];
    }else{
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ThemeNab.png"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent ;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white.png"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)backSweepGesture:(UISwipeGestureRecognizer*)gesture{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark Action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCustomerTitle:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
}

- (void)setTitleImage:(NSString *)imageStr {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 20)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:view.frame];
    img.image = [UIImage imageNamed:@"icon_jyb"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:img];
    self.navigationItem.titleView = view;
}


@end
