//
//  TopUpViewController.h
//  BaseProject
//
//  Created by cc on 2018/4/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"

typedef enum TopUpType {
    Topup_wallet,   //   钱包充值
    Topup_order     //   订单充值
}TopUpType;

@interface TopUpViewController : CCBaseViewController

@property (nonatomic, assign) TopUpType type;

@end
