//
//  ScreenView.h
//  BaseProject
//
//  Created by wuyb on 2018/3/22.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScreenViewDelegate<NSObject>

// 0、综合  1、销量  2、价格降序 3、价格升序  4、上新
-(void)screenViewDidSelectWihtIndex:(NSInteger)index;

@end

@interface ScreenView : UIView

@property(nonatomic,weak)id<ScreenViewDelegate>delegate;

@end
