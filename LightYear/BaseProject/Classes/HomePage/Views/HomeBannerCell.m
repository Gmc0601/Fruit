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
    // 设置要加载的图片
//        self.scrollView.data = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];
    _scrollView.placeHolderImage = [UIImage imageNamed:@"icon_couponqx"]; // 设置占位图片
    [self.contentView addSubview:self.scrollView];
    
    _scrollView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(showAdDetailWithIndex:)]) {
            [weakSelf.delegate showAdDetailWithIndex:currentIndex];
        }
    };
}

- (void)setBannerArray:(NSArray *)bannerArray {
//    NSMutableArray *arr = [NSMutableArray new];
//    for (DPBannerModel *model in bannerArray) {
//        NSString *img = model.img;
//        [arr addObject:img];
//    }
//    self.scrollView.data = arr;
    self.scrollView.data = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521612148225&di=8204accef36dc4825e6e46e404544e8b&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D2907377406%2C709322701%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521610810403&di=c6f4381f83140433515a482ed2cdecb4&imgtype=0&src=http%3A%2F%2Ffa.topitme.com%2Fa%2F8d%2Fb5%2F1129199180b5fb58dao.jpg"];
}

@end
