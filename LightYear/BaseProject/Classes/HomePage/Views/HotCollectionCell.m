//
//  HotCollectionCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "HotCollectionCell.h"

@interface HotCollectionCell ()

@property(nonatomic,strong) UIImageView *itemIV;
@property(nonatomic,strong) UILabel *titleLb;
@property(nonatomic,strong) UILabel *moneyLb;

@end

@implementation HotCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}


- (void)creatView {
    WEAKSELF
    UIImageView *backView = [[UIImageView alloc] init];
//    backView.backgroundColor = RGBColor(24, 110, 255);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(SizeWidth(165));
        make.top.centerX.equalTo(weakSelf.contentView);
    }];
    _itemIV = backView;
    
    UILabel *lb = [UILabel new];
    lb.numberOfLines = 2;
//    lb.text = @"龙虾螃蟹龙虾螃蟹龙虾螃蟹龙虾螃蟹龙虾螃蟹";
    lb.font = NormalFont(15);
    lb.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(SizeWidth(10));
        make.centerX.equalTo(backView);
        make.width.mas_offset(149);
    }];
    _titleLb = lb;
    
    _moneyLb = [UILabel new];
//    _moneyLb.text = @"￥158.00";
    _moneyLb.font = NormalFont(18);
    _moneyLb.textColor = RGBColor(255, 76, 68);
    [self.contentView addSubview:_moneyLb];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-SizeWidth(6));
        make.centerX.equalTo(backView);
        make.width.mas_offset(149);
    }];
}

- (void)setUpData:(GoodsIndexModel *)model {
    [_itemIV sd_setImageWithURL:[NSURL URLWithString:model.img_path] placeholderImage:nil];
    _titleLb.text = model.title;
    _moneyLb.text = [NSString stringWithFormat:@"￥%@",model.discount_price];
}

@end
