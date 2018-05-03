//
//  ReclassifyCollectionCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/23.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ReclassifyCollectionCell.h"

@interface ReclassifyCollectionCell ()

@property(nonatomic,strong) UIImageView *itemIV;
@property(nonatomic,strong) UILabel *titleLb;

@end

@implementation ReclassifyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(241, 241, 241);
        [self creatView];
    }
    return self;
}


- (void)creatView {
    WEAKSELF
    UIImageView *backView = [[UIImageView alloc] init];
    backView.backgroundColor = RGBColor(24, 110, 255);
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = SizeWidth(28);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(SizeWidth(56));
        make.top.centerX.equalTo(weakSelf.contentView);
    }];
    _itemIV = backView;
    
    UILabel *lb = [UILabel new];
    lb.text = @"龙虾螃蟹";
    lb.font = NormalFont(13);
    lb.textColor = RGBColor(102, 102, 102);
    [self.contentView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(SizeWidth(10));
        make.centerX.equalTo(backView);
    }];
    _titleLb = lb;
    
}

- (void)setUpData:(ThreeSubTypeModel *)model {
    [_itemIV sd_setImageWithURL:[NSURL URLWithString:model.img_path] placeholderImage:nil];
    _titleLb.text = model.name;
}

@end
