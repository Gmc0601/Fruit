//
//  GoodsDetailCell.m
//  BaseProject
//
//  Created by wuyb on 2018/4/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "GoodsDetailCell.h"

@interface GoodsDetailCell ()<UIWebViewDelegate>
{
    NSInteger _tempH;
}

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation GoodsDetailCell

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
    
    [self.contentView addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 0, kScreenW, kScreenH-64);
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [WProgressHudTool dissmiss];
    
    CGRect frame = webView.frame;
    frame.size.width = kScreenW;
    frame.size.height = 1;
    
    //    wb.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height;
    NSString *height = [NSString stringWithFormat:@"%f",frame.size.height];
    
//    NSLog(@"frame = %@", [NSValue valueWithCGRect:frame]);
    webView.frame = frame;
    NSDictionary *dic = @{@"height":height};
    
    if (_tempH != [height integerValue]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goodsDetailHeight" object:nil userInfo:dic];
    }
    _tempH = [height integerValue];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error) {
//        [WProgressHudTool dissmiss];
//        [WProgressHudTool wShowAutoDismissWithStatus:NO Title:@"网络错误"];
        
    }
}

- (void)setUpData:(NSString *)urlStr {
    if (urlStr && ![urlStr isEqualToString:@""]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [self.webView loadRequest:request];
    }
}

#pragma mark - Set & Get

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        
    }
    return _webView;
}

@end
