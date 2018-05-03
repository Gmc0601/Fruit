//
//  WLZ_ShoppIngCarModel.h
//  WLZ_ShoppingCart
//
//  Created by lijiarui on 15/12/14.
//  Copyright © 2015年 lijiarui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLZ_ShopViewModel.h"

@interface WLZ_ShoppIngCarModel : NSObject

@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *discount_price;
@property(nonatomic,copy)NSString *good_id;
@property(nonatomic,copy)NSString *card_id;
@property(nonatomic,copy)NSString *img_path;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *shopid;
@property(nonatomic,copy)NSString *sku;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,assign)NSInteger stock;//库存
@property(nonatomic,copy)NSString *sub_title;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,weak)WLZ_ShopViewModel *vm;
@property(nonatomic,assign)NSInteger type;

@end
