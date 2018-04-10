//
//  HomeHotCell.h
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHotCellDelegate <NSObject>
/**
 *  点击了畅销榜
 */
-(void)homeHotItemsDidSelectWithTag:(NSInteger)tag;

@end

@interface HomeHotCell : UITableViewCell

@property (nonatomic,weak) id<HomeHotCellDelegate>delegate;

@property (nonatomic,strong) NSArray *dataArr;


@end
