//
//  HomeBannerCell.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "HomeBannerCell.h"

#import "HW3DBannerView.h"

@interface HomeBannerCell ()

@property (nonatomic,strong) HW3DBannerView *scrollView;

@end

@implementation HomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupView {
    WEAKSELF
    _scrollView = [HW3DBannerView initWithFrame:CGRectMake(SizeWidth(15), SizeWidth(15), SizeWidth(345), SizeWidth(150)) imageSpacing:SizeWidth(15) imageWidth:SizeWidth(345)];
    _scrollView.initAlpha = 0.5; // 设置两边卡片的透明度
    _scrollView.imageRadius = 2; // 设置卡片圆角
    _scrollView.imageHeightPoor = 0; // 设置中间卡片与两边卡片的高度差
    _scrollView.placeHolderImage = [UIImage imageNamed:@"icon_couponqx"]; // 设置占位图片
    [self.contentView addSubview:self.scrollView];
    
    _scrollView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(showAdDetailWithIndex:)]) {
            [weakSelf.delegate showAdDetailWithIndex:currentIndex];
        }
    };
}

- (void)setBannerArray:(NSArray *)bannerArray {
    NSMutableArray *arr = [NSMutableArray new];
    for (BannerModel *model in bannerArray) {
        NSString *img = model.img_url;
        [arr addObject:img];
    }
    self.scrollView.data = arr;
}

@end
