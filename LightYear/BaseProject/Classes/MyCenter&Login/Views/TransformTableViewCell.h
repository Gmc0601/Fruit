//
//  TransformTableViewCell.h
//  BaseProject
//
//  Created by cc on 2018/4/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransformModel.h"

@interface TransformTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab, *time, *moneyLab;

@property (nonatomic, strong) TransformModel *model;

@end
