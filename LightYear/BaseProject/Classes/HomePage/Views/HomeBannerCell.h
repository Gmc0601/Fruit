//
//  HomeBannerCell.h
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeBannerCellDelegate <NSObject>

/**
 *  点击了广告
 */
-(void)showAdDetailWithIndex:(NSInteger)index;

@end

@interface HomeBannerCell : UITableViewCell

@property (nonatomic,weak) id<HomeBannerCellDelegate>delegate;
@property (nonatomic,strong) NSArray *bannerArray;


@end
