//
//  MycenterHeadView.h
//  BaseProject
//
//  Created by WeiYuLong on 2017/9/13.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MycenterHeadViewDelegate <NSObject>

@optional

- (void)didMycenterHeadViewButton:(UIButton*)button;

@end

@interface MycenterHeadView : UIView

@property (nonatomic, weak) id<MycenterHeadViewDelegate> delegate;

@property (nonatomic, strong) UIImageView * headImage;

@property (nonatomic, strong) UIImageView *logoimage, *halfimage;

@property (nonatomic, strong) UILabel *nickLab, *blanceLab, *couponLab;

@property (nonatomic, copy) void(^blanceBlock)(id);

@property (nonatomic, copy) void(^couponBlock)(id);

@end
