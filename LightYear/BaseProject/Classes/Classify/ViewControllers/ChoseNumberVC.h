//
//  ChoseNumberVC.h
//  BaseProject
//
//  Created by wuyb on 2018/4/26.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureBlock)(NSInteger choseNum);

@interface ChoseNumberVC : UIViewController

@property(nonatomic,copy) SureBlock sureBlock;
@property (nonatomic,strong) GoodsDetailModel *goodsDetailModel;

@end
