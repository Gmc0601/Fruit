//
//  ChoseNumberVC.m
//  BaseProject
//
//  Created by wuyb on 2018/4/26.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ChoseNumberVC.h"

@interface ChoseNumberVC ()
{
    NSInteger _selectNum;
}

@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *subtractBtn;
@property (nonatomic,strong) UILabel *numLb;
@property (nonatomic,strong) UIImageView *goodsImgV;
@property (nonatomic,strong) UILabel *residueLb;


@end

@implementation ChoseNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    _selectNum = 1;
    [self creatView];
}

- (void)creatView {
    UIView *backV = [UIView new];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kScreenW);
        make.height.mas_offset(SizeWidth(228));
        make.left.bottom.equalTo(self.view);
    }];
    NSArray *arr = _goodsDetailModel.img_path;
    UIImageView *imgV = [UIImageView new];
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = 6;
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(SizeWidth(105));
        make.left.equalTo(self.view).offset(SizeWidth(10));
        make.top.equalTo(backV.mas_top).offset(-SizeWidth(25));
    }];
    _goodsImgV = imgV;
    if (arr.count>0) {
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:nil];
    }
    
    UIButton *sureBtn = [UIButton new];
    sureBtn.backgroundColor = RGBColor(0, 187, 58);
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = NormalFont(16);
    [backV addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kScreenW);
        make.height.mas_offset(SizeWidth(50));
        make.left.bottom.equalTo(backV);
    }];
    
    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"Search_remove"] forState: 0];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(50);
        make.right.equalTo(backV);
        make.top.equalTo(backV).offset(5);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = RGBColor(241, 241, 241);
    [backV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(355));
        make.height.mas_offset(1.5);
        make.centerX.equalTo(backV);
        make.top.equalTo(imgV.mas_bottom).offset(10);
    }];
    
    UILabel *lb = [UILabel new];
    lb.text = [NSString stringWithFormat:@"购买数量(库存%@)",_goodsDetailModel.stock];
    lb.textColor = RGBColor(51, 51, 51);
    lb.font = NormalFont(14);
    [backV addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backV).offset(10);
        make.top.equalTo(line).offset(SizeWidth(28));
    }];
    _residueLb = lb;
    
    _addBtn = [UIButton new];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:0];
    [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(SizeWidth(35));
        make.centerY.equalTo(lb);
        make.right.equalTo(backV).offset(-SizeWidth(10));
    }];
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"1";
    lb1.layer.borderWidth = 1.5;
    lb1.layer.borderColor = RGBColor(222, 222, 222).CGColor;
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.textColor = RGBColor(51, 51, 51);
    lb1.font = NormalFont(16);
    [backV addSubview:lb1];
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(50));
        make.height.mas_offset(SizeWidth(35));
        make.right.equalTo(_addBtn.mas_left).offset(1.5);
        make.centerY.equalTo(_addBtn.mas_centerY);
    }];
    _numLb = lb1;
    
    _subtractBtn = [UIButton new];
    [_subtractBtn setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:0];
    [_subtractBtn addTarget:self action:@selector(subtractBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_subtractBtn];
    [_subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(SizeWidth(35));
        make.centerY.equalTo(lb);
        make.right.equalTo(lb1.mas_left).offset(1.5);
    }];
}


#pragma mark 按钮事件
- (void)sureBtnAction {
    if (self.sureBlock) {
        self.sureBlock(_selectNum);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)closeBtnAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)subtractBtnAction {
    if (_selectNum == 1) {
        return;
    }
    _selectNum --;
    _numLb.text = [NSString stringWithFormat:@"%ld",_selectNum];
}

- (void)addBtnAction {
    if (_selectNum >= [_goodsDetailModel.stock integerValue]) {
        return;
    }
    _selectNum ++;
    _numLb.text = [NSString stringWithFormat:@"%ld",_selectNum];
}

@end
