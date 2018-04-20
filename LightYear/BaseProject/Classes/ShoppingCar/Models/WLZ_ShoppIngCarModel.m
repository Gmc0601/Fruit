//
//  WLZ_ShoppIngCarModel.m
//  WLZ_ShoppingCart
//
//  Created by lijiarui on 15/12/14.
//  Copyright © 2015年 lijiarui. All rights reserved.
//

#import "WLZ_ShoppIngCarModel.h"

@implementation WLZ_ShoppIngCarModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"card_id" : @"id"};
}


- (void)setVm:(WLZ_ShopViewModel *)vm
{
    _vm = vm;
    [self addObserver:vm forKeyPath:@"isSelect" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

@end
