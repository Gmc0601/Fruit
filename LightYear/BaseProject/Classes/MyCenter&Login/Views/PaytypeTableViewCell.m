//
//  PaytypeTableViewCell.m
//  BaseProject
//
//  Created by cc on 2018/4/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "PaytypeTableViewCell.h"

@implementation PaytypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.btn];
    }
    return self;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:FRAME(kScreenW - 20 - 25, 20, 25, 25)];
        [_btn setImage:[UIImage imageNamed:@"gouwuche_uncheck"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"gouwuche_selected"] forState:UIControlStateSelected];
        _btn.backgroundColor = [UIColor clearColor];
    }
    return _btn;
}

@end
