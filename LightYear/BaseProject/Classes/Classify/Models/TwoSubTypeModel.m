//
//  TwoSubTypeModel.m
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "TwoSubTypeModel.h"

@implementation TwoSubTypeModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"twoTypeId":@"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"three_sub_type" : [ThreeSubTypeModel class] };
}

@end
