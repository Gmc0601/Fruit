//
//  BaseCell.h
//  MrOfficesPro
//
//  Created by haungfu on 16/2/19.
//  Copyright © 2016年 linjw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>

@protocol BaseCellProtocol <NSObject>

//显示内容到cell上
-(void)wShowWithModel:(id)modelTemp IndexPath:(NSIndexPath *)indexPath TableView:(UITableView *)tableView;

//获取高度
+(CGFloat)wHeightWithModel:(id)modelTemp IndexPath:(NSIndexPath *)indexPath TableView:(UITableView *)tableView;



@end


@interface BaseCell : UITableViewCell <BaseCellProtocol>



-(UIViewController *)getThisViewController;


@end
