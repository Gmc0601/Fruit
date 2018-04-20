//
//  GoodsDetailImgCell.m
//  BaseProject
//
//  Created by wuyb on 2018/4/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "GoodsDetailImgCell.h"

@interface GoodsDetailImgCell ()<UIScrollViewDelegate>
{
    NSInteger _pageCount;
}

@property(nonatomic,strong) UILabel *pageLabel;
@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation GoodsDetailImgCell

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
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW)];
    [self.contentView addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _pageLabel = [UILabel new];
    _pageLabel.backgroundColor = RGBColorAlpha(197, 197, 197, 0.7);
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.font = NormalFont(13);
    _pageLabel.layer.masksToBounds = YES;
    _pageLabel.layer.cornerRadius = SizeWidth(9);
    _pageLabel.textAlignment = 1;
    [self.contentView addSubview:_pageLabel];
    [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SizeWidth(43));
        make.height.mas_offset(SizeWidth(18));
        make.bottom.right.equalTo(self.contentView).offset(-SizeWidth(15));
    }];
}

- (void)setImgArray:(NSArray *)imgArray {
    [_scrollView removeAllSubviews];
    _pageCount = imgArray.count;
    
    _scrollView.contentSize = CGSizeMake(kScreenW*imgArray.count, 0);
    for (int i = 0; i<imgArray.count; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW*i, 8, kScreenW, kScreenW)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:imgArray[i]] placeholderImage:nil];
        [_scrollView addSubview:imgV];
        
    }
    NSInteger index = _scrollView.contentOffset.x/kScreenW+1;
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,imgArray.count];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenW+1;
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,_pageCount];
}

@end
