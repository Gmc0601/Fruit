//
//  BaseView.m
//  QuWeiFinal
//
//  Created by huangfu on 16/5/20.
//  Copyright © 2016年 quwei. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(UIViewController *)getThisViewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



@end
