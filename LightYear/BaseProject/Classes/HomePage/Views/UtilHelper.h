//
//  UtilHelper.h
//  BooksCubeProject
//
//  Created by Faven Emperor on 16/1/14.
//  Copyright © 2016年 baimao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilHelper : NSObject

+ (CGFloat)getWidthWithString:(NSString *)string
                     fontSize:(CGFloat)size
                    maxHeight:(CGFloat)height;

+ (CGFloat)getHeightWithString:(NSString *)string
                      fontSize:(CGFloat)size
                      maxWidth:(CGFloat)width;

/*时间戳返回时间，距离现在多久**/
+ (NSString *)distanceTimeWithBeforeTime:(NSInteger )beTime;
@end
