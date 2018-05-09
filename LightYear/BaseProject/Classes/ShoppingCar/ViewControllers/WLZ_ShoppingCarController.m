//
//  WLZ_ShoppingCarController.m
//  BaseProject
//
//  Created by Keith on 2018/4/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "WLZ_ShoppingCarController.h"
#import "WLZ_ShoppingCarCell.h"
#import "WLZ_ShoppingCartEndView.h"
#import "WLZ_ShopViewModel.h"
#import "MakeOrderViewController.h"
#import "LoginViewController.h"
@interface WLZ_ShoppingCarController ()<UITableViewDelegate,UITableViewDataSource,WLZ_ShoppingCartEndViewDelegate,WLZ_ShoppingCarCellDelegate>
@property(nonatomic,assign)BOOL isEdit;
@property (nonatomic, strong) UITableView *showTbv;
@property(nonatomic,strong)UILabel *holdLab;
@property (nonatomic,strong)NSMutableArray *cartmArr;
@property(nonatomic,strong)WLZ_ShoppingCartEndView *endView;
@property(nonatomic,strong) WLZ_ShopViewModel *vm;
@property (nonatomic,assign)CGFloat price;
@property (nonatomic,copy)NSString *goodId;
@property (nonatomic,strong)NSMutableArray *ordermArr;


@end

@implementation WLZ_ShoppingCarController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![ConfigModel getBoolObjectforKey:IsLogin]) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.clickBlock = ^(NSString *str) {
            self.tabBarController.selectedIndex = 0;
        };
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:na animated:YES completion:nil];
        return;
    }else
    {
        [self getCartData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    [self contentV];
    
    [self getCartData];
    
}

-(NSMutableArray *)ordermArr
{
    if (_ordermArr==nil) {
        _ordermArr=[NSMutableArray new];
    }
    return _ordermArr;
}




-(UILabel *)holdLab
{
    if (_holdLab == nil) {
        _holdLab = [[UILabel alloc]init];
        _holdLab.text = @"暂无商品";
        _holdLab.font=[UIFont systemFontOfSize:22];
        _holdLab.textAlignment = NSTextAlignmentCenter;
        _holdLab.textColor = [UIColor grayColor];
        _holdLab.hidden=YES;
    }
    return _holdLab;
}
-(NSMutableArray *)cartmArr
{
    if (_cartmArr==nil) {
        _cartmArr=[NSMutableArray new];
    }
    return _cartmArr;
}

-(WLZ_ShoppingCartEndView *)endView
{
    if (!_endView) {
        
        if (self.type==0) {
            _endView = [[WLZ_ShoppingCartEndView alloc]initWithFrame:CGRectMake(0, kScreenH-158, kScreenW, 44)];
        }else
        {
            _endView = [[WLZ_ShoppingCartEndView alloc]initWithFrame:CGRectMake(0, kScreenH-112, kScreenW, 44)];
        }
        
        
        _endView.delegate=self;
        _endView.isEdit = _isEdit;
        
        
    }
    return _endView;
}




-(UITableView *)showTbv
{
    if (_showTbv==nil) {
        
        self.showTbv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.showTbv.backgroundColor = RGBColor(239, 240, 241);
        self.showTbv.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showTbv.delegate = self;
        self.showTbv.dataSource = self;
        self.showTbv.separatorColor = RGBColor(225, 225,225);
        self.showTbv.sectionIndexBackgroundColor = [UIColor wColorWithHexStr:@"#e1e1e1"];
        self.showTbv.bounces = NO;
        self.showTbv.rowHeight=100;
        //        self.showTbv.contentInset = UIEdgeInsetsMake(0, 0,50, 0);
        
        self.showTbv.backgroundView=self.holdLab;
        
    }
    return _showTbv;
}

-(WLZ_ShopViewModel *)vm
{
    if (_vm==nil) {
        _vm=[[WLZ_ShopViewModel alloc]init];
    }
    return _vm;
}


-(void)getCartData
{
    
    
    //获取数据
    //    _vm = [[WLZ_ShopViewModel alloc]init];
    WGetWeakSelf(weak, self);
    
    [self.vm getShopData:^(NSArray *commonArry) {
        
      
            weak.cartmArr=nil;
            [weak.cartmArr addObjectsFromArray:commonArry];
            [weak.showTbv reloadData];
            if (commonArry.count==0) {
                
                weak.holdLab.hidden=NO;
                weak.endView.hidden=YES;
                
                [weak edits:nil];
                weak.navigationItem.rightBarButtonItem.title=@"";
            }else
            {
                weak.holdLab.hidden=YES;
                
                weak.endView.hidden=NO;
                weak.navigationItem.rightBarButtonItem.title=@"编辑";
                [weak.showTbv reloadData];
                [weak numPrice];
            }
        
    } priceBlock:^{
        
        [weak numPrice];
    }];
    
    
}


- (void)numPrice
{
    NSArray *lists =   [_endView.Lab.text componentsSeparatedByString:@"￥"];
    float num = 0.00;
    self.goodId=@"";
    
    if (self.cartmArr.count!=0) {
        for (int i=0; i<self.cartmArr.count-1; i++) {
            
            
            WLZ_ShoppIngCarModel *model = [self.cartmArr objectAtIndex:i];
            NSInteger count = [model.count integerValue];
            float sale = [model.price floatValue];
            
            if (model.isSelect ) {
                num = count*sale+ num;
                self.price=num;
                
                self.goodId=[self.goodId stringByAppendingFormat:@",%@",model.card_id];
                
            }
            
        }
        if (![self.goodId isEqualToString:@""]) {
             self.goodId=[self.goodId substringFromIndex:1];
        }
       
        _endView.Lab.text = [NSString stringWithFormat:@"%@￥%.2f",lists[0],num];
    }
    
    
}

-(void)createNav
{
    [self setCustomerTitle:@"购物车"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edits:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}


- (void)clickALLEnd:(UIButton *)bt
{
    
    //全选 也可以在 VM里面 写  这次在Controller里面写了
    
    
    bt.selected = !bt.selected;
    
    BOOL btselected = bt.selected;
    
    NSString *checked = @"";
    if (btselected) {
        checked = @"YES";
    }
    else
    {
        checked = @"NO";
    }
    if (self.isEdit) {
        //取消
        
        NSMutableDictionary *dic = [self.cartmArr lastObject];
        
        [dic setObject:checked forKey:@"checked"];
        for (int j=0; j<self.cartmArr.count-1; j++) {
            WLZ_ShoppIngCarModel *model = (WLZ_ShoppIngCarModel *)[self.cartmArr objectAtIndex:j];
            if (![model.status isEqualToString:@"3"]) {
                model.isSelect=btselected;
            }
            
        }
        
    }
    else
    {
        //编辑
        
        
        NSMutableDictionary *dic = [self.cartmArr lastObject];
        
        [dic setObject:checked forKey:@"checked"];
        for (int j=0; j<self.cartmArr.count-1; j++) {
            WLZ_ShoppIngCarModel *model = (WLZ_ShoppIngCarModel *)[self.cartmArr objectAtIndex:j];
            model.isSelect=btselected;
        }
        
        
    }
    
    [self.showTbv reloadData];
    
}




- (void)clickRightBT:(UIButton *)bt
{
    if(bt.tag==19)
    {
        //删除
        NSMutableIndexSet *bigIndexSet = [[NSMutableIndexSet alloc]init];
        
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc]init];
        for (int j=0 ; j<self.cartmArr.count-1; j++) {
            WLZ_ShoppIngCarModel *model = [ self.cartmArr objectAtIndex:j];
            
            if (model.isSelect==YES) {
                
                [indexSet addIndex:j];
                
                
                //访问网络 获取数据 block回调失败或者成功 都可以在这处理
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                parameters[@"id"] = model.card_id;
                [HttpRequest postPath:deleteCrad params:parameters resultBlock:^(id responseObject, NSError *error) {
                    
                    BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
                    if (baseModel.error == 0) {
                        
                        [ConfigModel mbProgressHUD:@"删除成功" andView:nil];
                        
                    }else {
                        NSLog(@"====%@",baseModel.message);
                        [ConfigModel mbProgressHUD:baseModel.message andView:nil];
                    }
                    
                }];
                
                //访问网络 获取数据 block回调失败或者成功 都可以在这处理
                
                [HttpRequest postPath:deleteCrad params:parameters resultBlock:^(id responseObject, NSError *error) {
                    
                    BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
                    if (baseModel.error == 0) {
                        
                        [ConfigModel mbProgressHUD:@"删除成功" andView:nil];
                        [self getCartData];
                        
                    }else {
                        NSLog(@"====%@",baseModel.message);
                        [ConfigModel mbProgressHUD:baseModel.message andView:nil];
                    }
                    
                }];
                
            }
        }
        //            [self.cartmArr removeObjectsAtIndexes:indexSet];
        //            [self.cartmArr removeObjectsAtIndexes:bigIndexSet];
        //            [self.showTbv reloadData];
        
    }
    else if (bt.tag==18)
    {
        //结算
        
        
        
        [self loadOrderData];
        
        
        
        
    }
    
    
    
}



- (void)loadOrderData {
    [ConfigModel showHud:self];
    NSString *shopId = [ConfigModel getStringforKey:ShopId];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.ordermArr options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSDictionary *arr = @{@"good_id":_goodsDetailModel.goodsId,@"price":_goodsDetailModel.discount_price,@"count":@"1"};
    parameters[@"shopid"] = shopId;
    //    parameters[@"receipt_id"] = @"";
    parameters[@"amount"] = [NSString stringWithFormat:@"%.2f",self.price];
    parameters[@"auto"] = @"2";
    parameters[@"ids"] = self.goodId;
    
    
    [HttpRequest postPath:orderUrl params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSLog(@"responseObject = %@",responseObject)
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSString *orderId = responseObject[@"info"][@"id"];
            MakeOrderViewController *vc = [MakeOrderViewController new];
            vc.OrderID = orderId;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            NSLog(@"%@",baseModel.message)
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        
    }];
}

- (void)edits:(UIBarButtonItem *)item
{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        item.title = @"完成";
        
        
        
        
        
    }else
    {
        item.title = @"编辑";
    }
    
    _endView.isEdit = self.isEdit;
    //     [_endView.checkbt setSelected:self.isEdit];
    
    
}

-(void)contentV
{
    
    [self.view addSubview:self.showTbv];
    [self.showTbv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    [self.view addSubview:self.endView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.cartmArr.count-1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *shoppingCaridentis = @"WLZ_ShoppingCarCells";
    WLZ_ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingCaridentis];
    if (!cell) {
        cell = [[WLZ_ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shoppingCaridentis tableView:tableView];
        cell.delegate=self;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    WLZ_ShoppIngCarModel *model=self.cartmArr[indexPath.row];
    
    
    cell.isEdit=self.isEdit;
    cell.row = indexPath.row+1;
    cell.model=model;
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    headV.backgroundColor=[UIColor whiteColor];
    UIImageView *imageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gouwuche_store"]];
    imageV.frame=CGRectMake(10, 10, 20, 20);
    [headV addSubview:imageV];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 21)];
    label.text= [ConfigModel getStringforKey:ShopName];
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment=NSTextAlignmentLeft;
    [headV addSubview:label];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, kScreenW, 1)];
    line.backgroundColor=RGBColor(239, 240, 241);
    [headV addSubview:line];
    return headV;
    
}

- (void)singleClick:(WLZ_ShoppIngCarModel *)models row:(NSInteger)row
{
    [_endView.checkbt setSelected:[_vm pitchOn:self.cartmArr]];
    if (models.type==1) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.showTbv reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        WLZ_ShoppIngCarModel *model = [self.cartmArr objectAtIndex:indexPath.row];
        model.isSelect=NO;
        [self.cartmArr removeObjectAtIndex:indexPath.row];
        
        //访问网络 获取数据 block回调失败或者成功 都可以在这处理
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        parameters[@"id"] = model.card_id;
        [HttpRequest postPath:deleteCrad params:parameters resultBlock:^(id responseObject, NSError *error) {
            
            BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
            if (baseModel.error == 0) {
                
                [ConfigModel mbProgressHUD:@"删除成功" andView:nil];
                
            }else {
                NSLog(@"====%@",baseModel.message);
                [ConfigModel mbProgressHUD:baseModel.message andView:nil];
            }
            
        }];
        
        [self.showTbv reloadData];
        
    }
}



@end
