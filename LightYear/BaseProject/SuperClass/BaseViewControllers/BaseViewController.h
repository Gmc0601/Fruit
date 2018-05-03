//
//  BaseViewController.h
//  BaseProject
//
//  Created by cc on 2017/6/22.
//  Copyright © 2017年 cc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIViewController+BarButton.h"
@interface BaseViewController : UIViewController

//  设置标题
-(void)setCustomerTitle:(NSString *)title;
//  设置头视图
- (void)setTitleImage:(NSString *)imageStr;

#pragma mark - 导航栏左右按钮设置

/**
 *  显示右按钮
 *
 *  @param title       按钮文字
 *  @param sel         sel
 *  @param imageName   默认图片
 *  @param imageOnName 按下图片
 */
-(void)showNavRightButton:(NSString*)title action:(SEL)sel image:(UIImage *)imageName imageOn:(UIImage*)imageOnName;


@end
