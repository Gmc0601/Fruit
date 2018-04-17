//
//  ABButton.m
//  StatePay
//
//  Created by Jellyfish on 16/7/6.
//  Copyright © 2016年 keping. All rights reserved.
//

#import "ABButton.h"
#import "UIView+Extension.h"


#define ABColor(R, G, B, Alpha) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(Alpha)]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)


@interface ABButton()

@end

@implementation ABButton

- (ABButton *)buttonWithAboveLabelTitle:(NSString *)aStr belowLabelTitle:(NSString *)bStr {
    
    UILabel *aboveL = [[UILabel alloc] init];
    aboveL.text = aStr;
    aboveL.font = [UIFont systemFontOfSize:18.0];
    aboveL.textColor = ThemeGreen;
    aboveL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:aboveL];
    self.aboveL = aboveL;
    
    UILabel *belowL = [[UILabel alloc] init];
    belowL.text = bStr;
    belowL.font = [UIFont systemFontOfSize:14.0];
    belowL.textColor = [UIColor blackColor];
    belowL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:belowL];
    self.belowL = belowL;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.size = CGSizeMake((SCREEN_WIDTH-60)/3, 60);
        self.layer.borderColor = ThemeGreen.CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5.0f;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.aboveL.frame = CGRectMake(0, 15, self.width, 20);
    self.belowL.frame = CGRectMake(0, CGRectGetMaxY(self.aboveL.frame), self.width, 20);
}

//- (void)setHighlighted:(BOOL)highlighted {
//    [super setHighlighted:highlighted];
//    self.backgroundColor = highlighted ? ThemeGreen : [UIColor whiteColor];
//    self.aboveL.textColor = highlighted ? [UIColor whiteColor] : ThemeGreen;
//    self.belowL.textColor = highlighted ? [UIColor whiteColor] : ThemeGreen;
//}
//
//- (void)setSelected:(BOOL)selected {
//    [super setHighlighted:selected];
//    self.backgroundColor = selected ? ThemeGreen : [UIColor whiteColor];
//    self.aboveL.textColor = selected ? [UIColor whiteColor] : ThemeGreen;
//    self.belowL.textColor = selected ? [UIColor whiteColor] : ThemeGreen;
//}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (!enabled) {
        self.aboveL.textColor = [UIColor lightGrayColor];
        self.belowL.textColor = [UIColor lightGrayColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = 5.0f;
    }
}
@end
