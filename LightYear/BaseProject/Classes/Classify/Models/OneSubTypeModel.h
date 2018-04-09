//
//  OneSubTypeModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneSubTypeModel : NSObject

@property(nonatomic,copy)NSString *oneTypeId; //一级id
@property(nonatomic,copy)NSString *name; //一级标题
@property(nonatomic,copy)NSArray *two_sub_type; //二级数据

@end
