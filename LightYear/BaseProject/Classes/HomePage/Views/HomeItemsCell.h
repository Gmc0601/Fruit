//
//  HomeItemsCell.h
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeItemsCellDelegate <NSObject>

@optional
/**
 *  点击了按钮
 */
- (void)homeItemsDidSelectWithTag:(NSInteger )tag;

@end

@interface HomeItemsCell : UITableViewCell

@property(nonatomic,weak) id<HomeItemsCellDelegate>delegate;

@end
