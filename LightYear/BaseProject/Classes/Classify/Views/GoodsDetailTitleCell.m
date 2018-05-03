//
//  GoodsDetailTitleCell.m
//  BaseProject
//
//  Created by wuyb on 2018/4/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "GoodsDetailTitleCell.h"

@interface GoodsDetailTitleCell ()<UIScrollViewDelegate>


@property(nonatomic,strong) UILabel *titleLb;
@property(nonatomic,strong) UILabel *subLb;
@property(nonatomic,strong) UILabel *priceLb;

@end

@implementation GoodsDetailTitleCell

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
    _titleLb.textColor = RGBColor(0, 0, 0);
    _titleLb.font = BOLDSYSTEMFONT(20);
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(318));
        make.left.equalTo(self.contentView).offset(SizeWidth(16));
        make.top.equalTo(self.contentView).offset(SizeWidth(25));
    }];
    
    _subLb = [UILabel new];
    _subLb.textColor = RGBColor(153, 153, 153);
    _subLb.font = NormalFont(14);
    [self.contentView addSubview:_subLb];
    [_subLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(318));
        make.left.equalTo(self.contentView).offset(SizeWidth(16));
        make.top.equalTo(_titleLb.mas_bottom).offset(SizeWidth(10));
    }];
    
    _priceLb = [UILabel new];
    _priceLb.textColor = RGBColor(255, 76, 68);
    _priceLb.font = BOLDSYSTEMFONT(24);
    [self.contentView addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(318));
        make.left.equalTo(self.contentView).offset(SizeWidth(16));
        make.top.equalTo(_subLb.mas_bottom).offset(SizeWidth(10));
    }];
}

- (void)setUpData:(GoodsDetailModel *)model {
    _titleLb.text = model.title;
    _subLb.text = model.sub_title;
    _priceLb.text = [NSString stringWithFormat:@"￥%@",model.discount_price];
}

@end
