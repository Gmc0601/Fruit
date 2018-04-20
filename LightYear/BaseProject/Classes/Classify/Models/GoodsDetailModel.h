//
//  GoodsDetailModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject

@property(nonatomic,copy)NSString *goodsId;            //id
@property(nonatomic,copy)NSString *title;         //商品名
@property(nonatomic,copy)NSString *sub_title;     //副标题
@property(nonatomic,copy)NSString *info;          //
@property(nonatomic,copy)NSString *barcard;       //商品条码
@property(nonatomic,copy)NSString *status;        //
@property(nonatomic,copy)NSString *create_time;   //创建时间2018-03-29 18:36:47
@property(nonatomic,copy)NSArray *img_path;       //图片
@property(nonatomic,copy)NSString *min_price;     //
@property(nonatomic,copy)NSString *stock;         //库存
@property(nonatomic,copy)NSString *original_price;//商品价格
@property(nonatomic,copy)NSString *postage;       //

@property(nonatomic,copy)NSArray *supplier;       //
@property(nonatomic,copy)NSString *total_count;   //
@property(nonatomic,copy)NSString *goodstype;     //
@property(nonatomic,copy)NSString *goodstype2;    //
@property(nonatomic,copy)NSString *goodstype3;    //
@property(nonatomic,copy)NSString *sale;          //销量
@property(nonatomic,copy)NSString *iscmd;         //是否推荐
@property(nonatomic,copy)NSString *img_desc;      //商品详情
@property(nonatomic,copy)NSString *desc;      //商品详情

@end
