//
//  WLZ_CommodityModel.h
//  WLZ_ShoppingCart
//
//  Created by lijiarui on 15/12/14.
//  Copyright © 2015年 lijiarui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLZ_CommodityModel : NSObject
@property(nonatomic,copy)NSString *commission;
@property(nonatomic,copy)NSString *discount_rate;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *item_id;
@property(nonatomic,copy)NSString *item_state;
@property(nonatomic,copy)NSString *market_price;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *name_add;
@property(nonatomic,copy)NSString *resell_item_sale_state;
@property(nonatomic,copy)NSString *resell_item_state;
@property(nonatomic,copy)NSString *sale_price;
@property(nonatomic,copy)NSString *sale_state;
@property(nonatomic,copy)NSString *shop_item_state;
@property(nonatomic,copy)NSString *shop_item_sale_state;
@property(nonatomic,copy)NSString *full_name;
@property(nonatomic,copy)NSString *miya_point;
@property(nonatomic,copy)NSString *relate_flag;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,copy)NSString *origin;
@property(nonatomic,copy)NSString *desc_text;
@property(nonatomic,copy)NSString *brand_name;
@property(nonatomic,copy)NSString *cate_name;
@property(nonatomic,copy)NSArray *pic;
@property(nonatomic,copy)NSString *share_url;
@property(nonatomic,copy)NSArray *normal;
@property (nonatomic,copy) NSMutableArray *relation_items;
@property (nonatomic, copy) NSArray *spu_list;
@property (nonatomic, copy) NSArray *spu_items;

@property(nonatomic,strong)NSArray *detail;

@property (nonatomic, strong) NSString *isSelect;


@property(nonatomic,copy) NSString *rec_state;

@property(nonatomic,copy)NSString *stock_quantity;
@property(nonatomic,assign)NSInteger type;



@property(nonatomic,assign)NSInteger auth_level;

@property(nonatomic,copy)NSString *is_spu;
@property(nonatomic,copy)NSString *is_single_sale;


@property(nonatomic,strong)NSArray *topicArry;



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
@property(nonatomic,copy)NSString *stock;
@property(nonatomic,copy)NSString *sub_title;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *user_id;


@end
