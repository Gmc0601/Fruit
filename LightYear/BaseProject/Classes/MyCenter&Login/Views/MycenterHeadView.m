//
//  MycenterHeadView.m
//  BaseProject
//
//  Created by WeiYuLong on 2017/9/13.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "MycenterHeadView.h"

@implementation MycenterHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = ThemeGreen;
        [self configUI];
    }
    
    return self;
}
- (void)configUI{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = ThemeGreen;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(200);
    }];
    
    self.logoimage = [[UIImageView alloc] init];
    self.logoimage.backgroundColor = [UIColor clearColor];
    self.logoimage.image = [UIImage imageNamed:@"icon_bg"];
    [self addSubview:self.logoimage];
    
    [self.logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(150);
    }];
    
    UIButton * headButton = [UIButton new];
    headButton.tag = 10;
    [headButton addTarget:self action:@selector(headViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    headButton.layer.cornerRadius = 40.0f;
    headButton.layer.masksToBounds = YES;
    [self addSubview:headButton];
    [headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(40);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    self.headImage = [UIImageView new];
    [headButton addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_offset(0);
        make.top.left.mas_offset(0);
    }];
    
    self.nickLab = [[UILabel alloc] init];
    self.nickLab.backgroundColor = [UIColor clearColor];
    self.nickLab.textColor = [UIColor whiteColor];
    self.nickLab.text = @"我就是个名字";
    self.nickLab.font = [UIFont systemFontOfSize:14];
    self.nickLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nickLab];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImage.mas_bottom).offset(10);
        make.centerX.mas_offset(0);
        make.height.mas_offset(20);
        make.width.mas_offset(kScreenW);
    }];
    
    UIImageView * titltImage = [UIImageView new];
    titltImage.image = [UIImage imageNamed:@"img_tx_bj"];
    [headButton addSubview:titltImage];
    [titltImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(20);
    }];
    
    UILabel * headEditLabel = [UILabel new];
    headEditLabel.text = @"编辑";
    headEditLabel.textAlignment = NSTextAlignmentCenter;
    headEditLabel.font = [UIFont systemFontOfSize:13];
    headEditLabel.textColor = [UIColor whiteColor];
    [headButton addSubview:headEditLabel];
    [headEditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(20);
    }];
    //    余额  优惠券等
    UIView *halfView = [[UIView alloc] init];
    halfView.backgroundColor = RGBColorAlpha(21, 172, 21, 1);
    [self addSubview:halfView];
    [halfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_offset(0);
        make.top.mas_equalTo(self.nickLab.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGBColor(92, 208, 83);
    [halfView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(0);
        make.centerY.equalTo(halfView.mas_centerY).offset(0);
        make.width.offset(1);
        make.height.offset(30);
    }];
    
    UILabel *balanceLab = [[UILabel alloc] init];
    balanceLab.backgroundColor = [UIColor clearColor];
    balanceLab.textColor= [UIColor whiteColor];
    balanceLab.text = @"0.00";
    self.blanceLab = balanceLab;
    balanceLab.font = [UIFont fontWithName:@"DINAlternate-Bold" size:19];
    [halfView addSubview:balanceLab];
    [balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(-kScreenW/4);
        make.top.mas_equalTo(halfView.top).offset(10);
        make.height.mas_offset(15);
    }];
    
    UILabel *title1 = [[UILabel alloc] init];
    title1.backgroundColor = [UIColor clearColor];
    title1.textColor = [UIColor whiteColor];
    title1.font =[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    title1.text = @"余额(元)";
    [halfView addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(-kScreenW/4);
        make.top.mas_equalTo(balanceLab.mas_bottom).offset(5);
        make.height.mas_offset(15);
    }];
    
    UIButton *balanBtn = [[UIButton alloc] init];
    balanBtn.backgroundColor = [UIColor clearColor];
    balanBtn.tag = 25;
    [balanBtn addTarget:self action:@selector(headViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [halfView addSubview:balanBtn];
    [balanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(-kScreenW/4);
        make.top.mas_equalTo(halfView.top).offset(5);
        make.height.mas_offset(50);
        make.width.mas_offset(kScreenW/2);
    }];
    
    
    UILabel *coupon = [[UILabel alloc] init];
    coupon.backgroundColor = [UIColor clearColor];
    coupon.textColor= [UIColor whiteColor];
    coupon.text = @"0";
    self.couponLab = coupon;
    coupon.font = [UIFont fontWithName:@"DINAlternate-Bold" size:19];
    [halfView addSubview:coupon];
    [coupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(kScreenW/4);
        make.top.mas_equalTo(halfView.top).offset(10);
        make.height.mas_offset(15);
    }];
    
    UILabel *title2 = [[UILabel alloc] init];
    title2.backgroundColor = [UIColor clearColor];
    title2.textColor = [UIColor whiteColor];
    title2.font =[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    title2.text = @"优惠券";
    [halfView addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(kScreenW/4);
        make.top.mas_equalTo(coupon.mas_bottom).offset(5);
        make.height.mas_offset(15);
    }];
    
    UIButton *couponBtn = [[UIButton alloc] init];
    couponBtn.backgroundColor = [UIColor clearColor];
    couponBtn.tag = 26;
    [couponBtn addTarget:self action:@selector(headViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [halfView addSubview:couponBtn];
    [couponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(halfView.mas_centerX).offset(kScreenW/4);
        make.top.mas_equalTo(halfView.top).offset(5);
        make.height.mas_offset(50);
        make.width.mas_offset(kScreenW/2);
    }];
    
    NSArray * imageArr = @[@"wode_dingdan",@"wode_daipeisong",@"wode_daiziqu",@"wode_peisongzhong",@"wode_daizhifu"];
    NSArray * titleArr = @[@"全部订单",@"待配送",@"待自取",@"配送中",@"待支付"];
    CGFloat buttonWidth = kScreenW/7;
    CGFloat buttonLeft= (kScreenW-kScreenW/7*5-15*4)/2;
    UIButton * baseButton;
    for (int i = 0; i < 5; i++) {
        UIButton * button = [UIButton new];
        button.tag = 20+i;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(headViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-20);
            make.size.mas_offset(CGSizeMake(buttonWidth, 50));
            if (i == 0) {
                make.left.mas_offset(buttonLeft);
            }else{
                make.left.mas_equalTo(baseButton.mas_right).offset(15);
            }
        }];
        baseButton = button;
        
        UIImageView * imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_offset(0);
        }];
        
        UILabel * titleLabel = [UILabel new];
        titleLabel.text = titleArr[i];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [button addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.centerX.mas_offset(0);
        }];
    }
}
- (void)headViewButtonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didMycenterHeadViewButton:)]) {
        [self.delegate didMycenterHeadViewButton:button];
    }
}
@end
