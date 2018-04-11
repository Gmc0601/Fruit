//
//  TwoSubTypeModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwoSubTypeModel : NSObject

@property(nonatomic,copy)NSString *twoTypeId; //二级id
@property(nonatomic,copy)NSString *name; //二级标题
@property(nonatomic,copy)NSArray *three_sub_type; //三级数据

@end
