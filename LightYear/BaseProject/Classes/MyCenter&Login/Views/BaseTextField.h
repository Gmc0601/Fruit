//
//  BaseTextField.h
//  BaseProject
//
//  Created by WeiYuLong on 2017/7/16.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTextFieldDelegate <NSObject>

@optional

-(void)textFieldTextChange:(UITextField *)textField Text:(NSString *)text;

@end

@interface BaseTextField : UITextField

@property (nonatomic, assign) BOOL isChangeKeyBoard;

@property (nonatomic, weak) id<BaseTextFieldDelegate> textDelegate;

- (id)initWithFrame:(CGRect)frame PlaceholderStr:(NSString *)placeholderStr isBorder:(BOOL)isBorder;

@end
