//
//  ShopGoodsTypeModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopGoodsTypeModel : NSObject

@property(nonatomic,copy)NSString *name; //名字
@property(nonatomic,copy)NSString *typeId; //分类ID
@property(nonatomic,copy)NSString *level; //类目层级，目前只有2.3级类目
@property(nonatomic,copy)NSString *imgpath; //图片

@end
