//
//  TBTabBarController.m
//  BaseProject
//
//  Created by cc on 2017/6/22.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "TBTabBarController.h"
#import "HomepageViewController.h"
#import "ClassifyViewController.h"
#import "MyCenterViewController.h"
#import "WLZ_ShoppingCarController.h"
#import "ViewController.h"
#import "TBNavigationController.h"
//#import "TBTabBar.h"


#import "LoginViewController.h"

@interface TBTabBarController ()

@end

@implementation TBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化所有控制器
    [self setUpChildVC];
}


#pragma mark -初始化所有控制器 

- (void)setUpChildVC {
    
    HomePageViewController *homepage = [[HomePageViewController alloc] init];
    [self setChildVC:homepage title:@"首页" image:@"tab_home_wxz" selectedImage:@"tab_home_xz"];

    ClassifyViewController *classify = [[ClassifyViewController alloc] init];
    [self setChildVC:classify title:@"分类" image:@"tab_fenlei_wxz" selectedImage:@"tab_fenlei_xz"];

    WLZ_ShoppingCarController *car = [[WLZ_ShoppingCarController alloc] init];
    [self setChildVC:car title:@"购物车" image:@"tab_gouwuche_wxz" selectedImage:@"tab_gouwuche_xz"];

//    LoginViewController *myVC = [[LoginViewController alloc] init];
//    [self setChildVC:myVC title:@"我的" image:@"tab_wode_wxz" selectedImage:@"tab_wode_xz"];
    
    MycenterViewController *myVC = [[MycenterViewController alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tab_wode_wxz" selectedImage:@"tab_wode_xz"];

}

- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] 
     addAnimation:pulse forKey:nil]; 
}

@end
