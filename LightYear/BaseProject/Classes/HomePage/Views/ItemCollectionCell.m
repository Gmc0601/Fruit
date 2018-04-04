//
//  ItemCollectionCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ItemCollectionCell.h"

@interface ItemCollectionCell ()

@property(nonatomic,strong) UIImageView *itemIV;
@property(nonatomic,strong) UILabel *titleLb;

@end

@implementation ItemCollectionCell

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
    backView.backgroundColor = RGBColor(24, 110, 255);
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = SizeWidth(22.5);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(SizeWidth(45));
        make.top.centerX.equalTo(weakSelf.contentView);
    }];
    _itemIV = backView;
    
    UILabel *lb = [UILabel new];
    lb.text = @"龙虾螃蟹";
    lb.font = NormalFont(12);
    lb.textColor = RGBColor(44, 46, 44);
    [self.contentView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(SizeWidth(10));
        make.centerX.equalTo(backView);
    }];
    _titleLb = lb;
   
}



@end
