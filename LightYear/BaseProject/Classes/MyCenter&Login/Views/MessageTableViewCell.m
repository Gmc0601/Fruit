//
//  MessageTableViewCell.m
//  BaseProject
//
//  Created by cc on 2018/4/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "UIView+Frame.h"

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titlelab];
        [self.contentView addSubview:self.subtitle];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.moreLab];
        [self.contentView addSubview:self.morelogo];
    }
    return self;
}

- (UILabel *)titlelab {
    if (!_titlelab) {
        _titlelab = [[UILabel alloc] initWithFrame:FRAME(10, 10, kScreenW - 20, 20)];
        _titlelab.font = [UIFont systemFontOfSize:16];
        _titlelab.text = @"ssssss";
    }
    return _titlelab;
}

- (UILabel *)subtitle {
    if (!_subtitle) {
        _subtitle = [[UILabel alloc]initWithFrame:FRAME(10, self.titlelab.bottom + 10, kScreenW - 20, 40)];
        _subtitle.font = [UIFont systemFontOfSize:13];
        _subtitle.numberOfLines = 2;
        _subtitle.text = @"susssssssssssssssssssssssss";
    }
    return _subtitle;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] initWithFrame:FRAME(15, self.subtitle.bottom + 5, kScreenW - 30, 1)];
        _line.backgroundColor = RGBColor(239, 240, 241);
    }
    return _line;
}

- (UILabel *)moreLab {
    if (!_moreLab) {
        _moreLab = [[UILabel alloc] initWithFrame:FRAME(10, self.line.bottom + 10, kScreenW/2, 20)];
        _moreLab.text = @"查看详情";
        _moreLab.font = [UIFont systemFontOfSize:13];
    }
    return _moreLab;
}

- (UIImageView *)morelogo {
    if (!_morelogo) {
        UIImage *image = [UIImage imageNamed:@"wode_forward"];
        _morelogo = [[UIImageView alloc] initWithFrame:FRAME(kScreenW - 10 - image.size.width, self.line.bottom + 12, image.size.width, image.size.height)];
        _morelogo.backgroundColor = [UIColor clearColor];
        _morelogo.image = image;
    }
    return _morelogo;
}

@end
