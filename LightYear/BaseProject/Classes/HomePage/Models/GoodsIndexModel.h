//
//  GoodsIndexModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsIndexModel : NSObject

@property(nonatomic,copy)NSString *goodsId; //id
@property(nonatomic,copy)NSString *title; //商品名称
@property(nonatomic,copy)NSString *sub_title; //副标题
@property(nonatomic,copy)NSString *img_path; //图片
@property(nonatomic,copy)NSString *discount_price; //价格

@end
