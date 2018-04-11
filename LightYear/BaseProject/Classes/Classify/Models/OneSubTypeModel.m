//
//  OneSubTypeModel.m
//  BaseProject
//
//  Created by wuyb on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "OneSubTypeModel.h"

@implementation OneSubTypeModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"twoTypeId":@"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"two_sub_type" : [TwoSubTypeModel class] };
}

@end
