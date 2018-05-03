//
//  WLZ_ShopViewModel.m
//  WLZ_ShoppingCart
//
//  Created by lijiarui on 15/12/14.
//  Copyright © 2015年 lijiarui. All rights reserved.
//

#import "WLZ_ShopViewModel.h"
#import "WLZ_ShoppIngCarModel.h"
#import "MJExtension.h"
@implementation WLZ_ShopViewModel

//


- (void)getNumPrices:(void (^)()) priceBlock
{
    _priceBlock = priceBlock;
}


- (void)getShopData:(void (^)(NSArray * commonArry))shopDataBlock  priceBlock:(void (^)()) priceBlock
{
    //访问网络 获取数据 block回调失败或者成功 都可以在这处理
     NSMutableArray *commonMuList = [NSMutableArray array];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"shopid"] = @"3";
    [HttpRequest postPath:cardList params:parameters resultBlock:^(id responseObject, NSError *error) {
        
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"];
            for (NSDictionary *dic in arr) {
                WLZ_ShoppIngCarModel *shopModel = [WLZ_ShoppIngCarModel yy_modelWithDictionary:dic];
                
                shopModel.vm =self;
                shopModel.type=1;
                shopModel.isSelect=YES;
                [commonMuList addObject:shopModel];
            }
            
            if (commonMuList.count>0) {
                
                [commonMuList addObject:[self verificationSelect:commonMuList type:@"1"]];
                
            }
            _priceBlock = priceBlock;
            shopDataBlock(commonMuList);
            
        }else {
            NSLog(@"====%@",baseModel.message);
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        
    }];
    
    
   
    
    
}
- (NSDictionary *)verificationSelect:(NSMutableArray *)arr type:(NSString *)type
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"YES" forKey:@"checked"];
    [dic setObject:type forKey:@"type"];
    for (int i =0; i<arr.count; i++) {
        WLZ_ShoppIngCarModel *model = (WLZ_ShoppIngCarModel *)[arr objectAtIndex:i];
        if (!model.isSelect) {
            [dic setObject:@"NO" forKey:@"checked"];
            break;
        }
    }
    
    return dic;
}


//点击单个按钮
- (BOOL)pitchOn:(NSMutableArray *)carDataArrList
{
    
    BOOL isCheck =YES;
  
      
        NSMutableDictionary *dic = [carDataArrList lastObject];
         [dic setObject:@"YES" forKey:@"checked"];
    
        
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            isCheck = NO;
        }
    
    return isCheck;
}


//点击item上的全选
-(BOOL)clickAllBT:(NSMutableArray *)carDataArrList bt:(UIButton *)bt
{
    bt.selected = !bt.selected;
    
    
    BOOL isCheck =YES;
    
  
        NSMutableDictionary *dic = [carDataArrList lastObject];
        for (int j=0; j<carDataArrList.count-1; j++) {
            WLZ_ShoppIngCarModel *model = (WLZ_ShoppIngCarModel *)[carDataArrList objectAtIndex:j];
            if (model.type==1 && bt.tag==100) {
                if (bt.selected) {
                    [dic setObject:@"YES" forKey:@"checked"];
                }
                else
                {
                    [dic setObject:@"NO" forKey:@"checked"];
                }
                
              
                model.isSelect=bt.selected;
             
               }
            }
          
    
        
        
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            isCheck = NO;
        }

    
    return isCheck;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"开始计算价钱");
    if ([keyPath isEqualToString:@"isSelect"]) {
        if (_priceBlock!=nil) {
             _priceBlock();
        }
       
    }
}



@end
