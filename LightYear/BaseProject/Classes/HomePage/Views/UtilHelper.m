//
//  UtilHelper.m
//  BooksCubeProject
//
//  Created by Faven Emperor on 16/1/14.
//  Copyright © 2016年 baimao. All rights reserved.
//

#import "UtilHelper.h"
#define IOS_VERSION ([[UIDevice currentDevice].systemVersion floatValue])

@implementation UtilHelper

+ (CGFloat)getWidthWithString:(NSString *)string
                     fontSize:(CGFloat)size
                    maxHeight:(CGFloat)height {
    UIFont * font = [UIFont systemFontOfSize:size];
    CGSize tempSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{
                                                 NSFontAttributeName : font
                                                 }
                                       context:nil].size;
    //        size.width += 5;
    return tempSize.width;
}

+ (CGFloat)getHeightWithString:(NSString *)string
                      fontSize:(CGFloat)size
                      maxWidth:(CGFloat)width {
    UIFont * font = NormalFont(size);
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName : font
                                          }
                                context:nil].size.height;
}


/*时间戳返回时间，距离现在多久**/
+ (NSString *)distanceTimeWithBeforeTime:(NSInteger )beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

@end
