//
//  MessageTableViewCell.h
//  BaseProject
//
//  Created by cc on 2018/4/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titlelab, *subtitle, *moreLab, *line;

@property (nonatomic, strong) UIImageView *morelogo;

@end
