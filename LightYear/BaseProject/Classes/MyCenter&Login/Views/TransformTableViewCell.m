//
//  TransformTableViewCell.m
//  BaseProject
//
//  Created by cc on 2018/4/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "TransformTableViewCell.h"

@implementation TransformTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.moneyLab];
        [self.contentView addSubview:self.time];
    }
    return self;
}

- (void)setModel:(TransformModel *)model {
    NSString *str ;
    switch ([model.otype intValue]) {
        case 0:
            str = @"在线支付";
            break;
        case 1:
            str = @"门店支付";
            break;
        case 2:
            str = @"线上充值";
            break;
        case 3:
            str = @"门店充值";
            break;
        case 4:
            str = @"充值赠送";
            break;
            
        default:
            str = @"搞错了";
            break;
    }
    
    self.titleLab.text = str;
    self.time.text = model.create_date;
    self.moneyLab.text = model.money;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:FRAME(10, 13, kScreenW, 20)];
        _titleLab.text = @"门店购物";
        _titleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _titleLab.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
    }
    return _titleLab;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:FRAME(10, self.titleLab.bottom + 5, kScreenW, 20)];
        _time.text = @"2018-01-28 13:45";
        _time.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _time.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
    }
    return _time;
}

- (UILabel *)moneyLab {
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] initWithFrame:FRAME(0, 20, kScreenW - 15, 20)];
        _moneyLab.textAlignment = NSTextAlignmentRight;
        _moneyLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _moneyLab.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
        _moneyLab.text = @"-198.50";
    }
    return _moneyLab;
}

@end
