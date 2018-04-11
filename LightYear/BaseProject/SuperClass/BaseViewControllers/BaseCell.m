//
//  BaseCell.m
//  MrOfficesPro
//
//  Created by huangfu on 16/2/19.
//  Copyright © 2016年 linjw. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

-(void)wShowWithModel:(id)model IndexPath:(NSIndexPath *)indexPath TableView:(UITableView *)tableView
{
    
}

+(CGFloat)wHeightWithModel:(id)model IndexPath:(NSIndexPath *)indexPath TableView:(UITableView *)tableView
{
    return 0;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UIViewController *)getThisViewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
