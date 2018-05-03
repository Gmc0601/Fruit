//
//  ScreenView.m
//  BaseProject
//
//  Created by wuyb on 2018/3/22.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ScreenView.h"

@interface ScreenView ()
{
    NSInteger _index;
}

@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;
@property (nonatomic, strong) UIButton *threeBtn;
@property (nonatomic, strong) UIButton *fourBtn;

@end

@implementation ScreenView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _index = 0;
    WEAKSELF
    UIView *backV = [UIView new];
    backV.layer.borderWidth = 0.5;
    backV.layer.borderColor = RGBColor(238, 238, 238).CGColor;
    [self addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    _oneBtn = [UIButton new];
    [_oneBtn setTitle:@"综合" forState:UIControlStateNormal];
    [_oneBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_oneBtn setTitleColor:RGBColor(0, 0, 0) forState:UIControlStateSelected];
    _oneBtn.titleLabel.font = NormalFont(15);
    _oneBtn.selected = YES;
    [_oneBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_oneBtn];
    [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(375)/4.0);
        make.height.mas_offset(SizeWidth(44));
        make.left.centerY.equalTo(backV);
    }];
    
    _twoBtn = [UIButton new];
    _twoBtn.titleLabel.font = NormalFont(15);
    [_twoBtn setTitle:@"销量" forState:UIControlStateNormal];
    [_twoBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_twoBtn setTitleColor:RGBColor(0, 0, 0) forState:UIControlStateSelected];
    [_twoBtn addTarget:self action:@selector(twoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_twoBtn];
    [_twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(375)/4.0);
        make.height.mas_offset(SizeWidth(44));
        make.left.equalTo(_oneBtn.mas_right);
        make.centerY.equalTo(backV);
    }];
    
    _threeBtn = [UIButton new];
    _threeBtn.titleLabel.font = NormalFont(15);
    [_threeBtn setTitle:@"价格" forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"全灰"] forState:UIControlStateNormal];
    [_threeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, -40)];
    [_threeBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_threeBtn setTitleColor:RGBColor(0, 0, 0) forState:UIControlStateSelected];
    [_threeBtn addTarget:self action:@selector(threeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_threeBtn];
    [_threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(375)/4.0);
        make.height.mas_offset(SizeWidth(44));
        make.left.equalTo(_twoBtn.mas_right);
        make.centerY.equalTo(backV);
    }];
    
    _fourBtn = [UIButton new];
    _fourBtn.titleLabel.font = NormalFont(15);
    [_fourBtn setTitle:@"上新" forState:UIControlStateNormal];
    [_fourBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_fourBtn setTitleColor:RGBColor(0, 0, 0) forState:UIControlStateSelected];
    [_fourBtn addTarget:self action:@selector(fourBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_fourBtn];
    [_fourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(375)/4.0);
        make.height.mas_offset(SizeWidth(44));
        make.left.equalTo(_threeBtn.mas_right);
        make.centerY.equalTo(backV);
    }];
    
}


#pragma mark 按钮事件
- (void)oneBtnAction:(UIButton *)btn {
    _index = 0;
    _oneBtn.selected = YES;
    _twoBtn.selected = NO;
    _threeBtn.selected = NO;
    _fourBtn.selected = NO;
    [_threeBtn setImage:[UIImage imageNamed:@"全灰"] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenViewDidSelectWihtIndex:)]) {
        [self.delegate screenViewDidSelectWihtIndex:0];
    }
}

- (void)twoBtnAction:(UIButton *)btn {
    _index = 0;
    _oneBtn.selected = NO;
    _twoBtn.selected = YES;
    _threeBtn.selected = NO;
    _fourBtn.selected = NO;
    [_threeBtn setImage:[UIImage imageNamed:@"全灰"] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenViewDidSelectWihtIndex:)]) {
        [self.delegate screenViewDidSelectWihtIndex:1];
    }
}

- (void)threeBtnAction:(UIButton *)btn {
    _oneBtn.selected = NO;
    _twoBtn.selected = NO;
    _threeBtn.selected = YES;
    _fourBtn.selected = NO;
    _index ++;
    if (_index%2 == 0) {
        
        [_threeBtn setImage:[UIImage imageNamed:@"下灰"] forState:UIControlStateNormal];
        if (self.delegate && [self.delegate respondsToSelector:@selector(screenViewDidSelectWihtIndex:)]) {
            [self.delegate screenViewDidSelectWihtIndex:3];
        }
    } else {
        [_threeBtn setImage:[UIImage imageNamed:@"上灰"] forState:UIControlStateNormal];
        if (self.delegate && [self.delegate respondsToSelector:@selector(screenViewDidSelectWihtIndex:)]) {
            [self.delegate screenViewDidSelectWihtIndex:2];
        }
    }
}

- (void)fourBtnAction:(UIButton *)btn {
    _index = 0;
    _oneBtn.selected = NO;
    _twoBtn.selected = NO;
    _threeBtn.selected = NO;
    _fourBtn.selected = YES;
    [_threeBtn setImage:[UIImage imageNamed:@"全灰"] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenViewDidSelectWihtIndex:)]) {
        [self.delegate screenViewDidSelectWihtIndex:4];
    }
}


#pragma mark set





@end
