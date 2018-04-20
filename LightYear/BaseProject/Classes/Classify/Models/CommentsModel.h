//
//  CommentsModel.h
//  BaseProject
//
//  Created by wuyb on 2018/4/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject

@property(nonatomic,copy)NSString *id;             //id
@property(nonatomic,copy)NSString *user_id;        //
@property(nonatomic,copy)NSString *invest_id;      //订单ID
@property(nonatomic,copy)NSString *content;        //内容
@property(nonatomic,copy)NSString *parent_id;      //
@property(nonatomic,copy)NSString *agree;          //
//@property(nonatomic,copy)NSString *count;          //
@property(nonatomic,copy)NSString *create_time;    //
@property(nonatomic,copy)NSString *update_time;    //
@property(nonatomic,copy)NSString *status;         //
@property(nonatomic,copy)NSString *star;           //
@property(nonatomic,copy)NSString *shop_star;      //
@property(nonatomic,copy)NSString *postage_star;   //
@property(nonatomic,copy)NSString *good_id;        //
@property(nonatomic,copy)NSString *supplier;       //
@property(nonatomic,copy)NSString *username;       //

@end
