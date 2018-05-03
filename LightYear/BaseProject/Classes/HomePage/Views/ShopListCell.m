//
//  ShopListCell.m
//  BaseProject
//
//  Created by wuyb on 2018/4/8.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ShopListCell.h"

@interface ShopListCell ()

@property(nonatomic,strong) UIImageView *shopImgV;
@property(nonatomic,strong) UILabel *nameLb;
@property(nonatomic,strong) UILabel *addressLb;
@property(nonatomic,strong) UILabel *distanceLb;


@end

@implementation ShopListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBColor(241, 241, 241);
        [self creatView];
    }
    return self;
}

- (void)creatView {
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(234))];
    backV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backV];
    
    _shopImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SizeWidth(15), SizeWidth(15), SizeWidth(345), SizeWidth(150))];
    _shopImgV.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_shopImgV];
    
    _nameLb = [UILabel new];
    _nameLb.text = @"啊啊大大大店";
    _nameLb.font = BOLDSYSTEMFONT(16);
    _nameLb.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SizeWidth(25));
        make.top.equalTo(_shopImgV.mas_bottom).offset(SizeWidth(15));
    }];
    
    _distanceLb = [UILabel new];
    _distanceLb.text = @"距您3.8米";
    _distanceLb.font = NormalFont(13);
    _distanceLb.textColor = RGBColor(153, 153, 153);
    [self.contentView addSubview:_distanceLb];
    [_distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLb);
        make.right.equalTo(self.contentView).offset(-SizeWidth(25));
    }];
    
    UIImageView *imgV = [UIImageView new];
    imgV.image = [UIImage imageNamed:@"home_positioning"];
    [self.contentView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLb);
        make.right.equalTo(_distanceLb.mas_left).offset(-SizeWidth(5));
    }];
    
    _addressLb = [UILabel new];
    _addressLb.text = @"sasda按时大大所多";
    _addressLb.font = NormalFont(13);
    _addressLb.textColor = RGBColor(102, 102, 102);
    [self.contentView addSubview:_addressLb];
    [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SizeWidth(25));
        make.top.equalTo(_nameLb.mas_bottom).offset(SizeWidth(10));
        make.width.mas_offset(SizeWidth(325));
    }];

}

- (void)setUpData:(ShopModel *)shopModel {
    [_shopImgV sd_setImageWithURL:[NSURL URLWithString:shopModel.imgpath] placeholderImage:nil];
    _nameLb.text = shopModel.shopname;
    _addressLb.text = shopModel.address;
    _distanceLb.text = [NSString stringWithFormat:@"距您%@km",shopModel.distance];
}


@end
