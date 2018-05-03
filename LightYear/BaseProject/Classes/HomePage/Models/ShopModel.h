//
//  ShopModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

@property(nonatomic,copy)NSString *shopId; //门店id
@property(nonatomic,copy)NSString *shopname; //店名
@property(nonatomic,copy)NSString *address; //地址
@property(nonatomic,copy)NSString *imgpath; //图片
@property(nonatomic,copy)NSString *distance; //距离km
@property(nonatomic,assign)float lat;//纬度
@property(nonatomic,assign)float lng; //经度

@end
