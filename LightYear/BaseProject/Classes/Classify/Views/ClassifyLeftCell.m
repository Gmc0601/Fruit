//
//  ClassifyLeftCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/22.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ClassifyLeftCell.h"
@interface ClassifyLeftCell ()

@property(nonatomic,strong) UILabel *titleLb;
@property(nonatomic,strong) UIView *selectLine;


@end

@implementation ClassifyLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //        self.contentView.backgroundColor = DPWhiteColor;
        [self creatView];
    }
    return self;
}

- (void)creatView {
    _titleLb = [UILabel new];
    _titleLb.font = NormalFont(15);
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.contentView);
    }];
    
    _selectLine = [UIView new];
    _selectLine.hidden = YES;
    _selectLine.backgroundColor = RGBColor(52, 187, 42);
    [self.contentView addSubview:_selectLine];
    [_selectLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(7));
        make.height.mas_offset(SizeWidth(25));
        make.left.centerY.equalTo(self.contentView);
    }];
    
}

- (void)setUpTitle:(OneSubTypeModel *)model {
    _titleLb.text = [NSString stringWithFormat:@"%@",model.name];
}

- (void)changeSelectWithType:(NSDictionary *)dic {
    if ([dic[@"type"] integerValue] == 0) {
        _titleLb.textColor = RGBColor(102, 102, 102);
        _selectLine.hidden = YES;
    } else {
        _titleLb.textColor = RGBColor(52, 187, 42);
        _selectLine.hidden = NO;
    }
}

@end
