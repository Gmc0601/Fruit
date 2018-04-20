//
//  CommentCell.m
//  BaseProject
//
//  Created by wuyb on 2018/4/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()<UIScrollViewDelegate>


@property(nonatomic,strong) UILabel *nameLb;
@property(nonatomic,strong) UILabel *timeLb;
@property(nonatomic,strong) UILabel *commemtLb;
@property(nonatomic,strong) UIView *starView;

@end

@implementation CommentCell

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
    
    _nameLb = [UILabel new];
    _nameLb.text = @"难难难你";
    _nameLb.textColor = RGBColor(51, 51, 51);
    _nameLb.font = NormalFont(14);
    [self.contentView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(200));
        make.left.equalTo(self.contentView).offset(SizeWidth(14));
        make.top.equalTo(self.contentView).offset(SizeWidth(20));
    }];
    
    _timeLb = [UILabel new];
    _timeLb.text = @"2018-04-10";
    _timeLb.textColor = RGBColor(153, 153, 153);
    _timeLb.font = NormalFont(12);
    [self.contentView addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SizeWidth(16));
        make.top.equalTo(_nameLb.mas_bottom).offset(SizeWidth(8));
    }];
    
    _commemtLb = [UILabel new];
    _commemtLb.text = @"这是评论湿哒哒大所大所撒奥所多所所所所所所所所所所所所所所少时诵诗书所所所所少时诵诗书所";
    _commemtLb.numberOfLines = 0;
    _commemtLb.textColor = RGBColor(102, 102, 102);
    _commemtLb.font = NormalFont(14);
    [self.contentView addSubview:_commemtLb];
    [_commemtLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(349));
        make.left.equalTo(self.contentView).offset(SizeWidth(14));
        make.top.equalTo(_timeLb.mas_bottom).offset(SizeWidth(10));
    }];
    
    _starView = [UIView new];
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(120));
        make.height.mas_offset(SizeWidth(16));
        make.top.equalTo(self.contentView).offset(SizeWidth(27));
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
    }];
    
    for (int i = 0; i<5; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SizeWidth(105)-i*(SizeWidth(18)), 0, SizeWidth(15), SizeWidth(16))];
        imgV.tag = 10+i;
        imgV.image = [UIImage imageNamed:@"details_pentagram_gray"];
        [_starView addSubview:imgV];
    }
}

- (void)setUpData:(CommentsModel *)model {
    _nameLb.text = model.username;
    _timeLb.text = model.create_time;
    _commemtLb.text = model.content;
    for (int i = 0; i<[model.star intValue]; i++) {
        UIImageView *imgV = [_starView viewWithTag:10+i];
        imgV.image = [UIImage imageNamed:@"details_pentagram"];
    }
}

@end
