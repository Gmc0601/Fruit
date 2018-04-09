//
//  ClassifyViewController.m
//  BaseProject
//
//  Created by cc on 2018/3/20.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ClassifyViewController.h"

#import "ClassifyLeftCell.h"
#import "ReclassifyCollectionCell.h"

@interface ClassifyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *titleArr;
@property(nonatomic,strong) NSMutableArray *selectArr;


@end

@implementation ClassifyViewController

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"分类"];
    
    for (NSInteger i = 0; i<self.titleArr.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        
        if (i == 0) {
            dic[@"type"]= @"1";
            [self.selectArr addObject:dic];
        }else {
            dic[@"type"]= @"0";
            [self.selectArr addObject:dic];
        }
    }
    
    [self creatView];
}

- (void)creatView {
    //    WEAKSELF
    //    self.edgesForExtendedLayout = UIRectEdgeTop;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(99), kScreenH-64-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//        _tableView.backgroundColor = 【uic;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self.view addSubview:self.collectionView];
        
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SizeWidth(85), SizeWidth(90));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SizeWidth(99), 0, SizeWidth(276),kScreenH-64-50) collectionViewLayout:layout];
        //        UIImageView *imgV = [UIImageView new];
        //        imgV.image = [UIImage imageNamed:@"我的背景黑2"];
        //        _collectionView.backgroundView = imgV;
        _collectionView.showsHorizontalScrollIndicator = NO;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(SizeWidth(276), SizeWidth(50));  //设置headerView大小
        [_collectionView registerClass:[ReclassifyCollectionCell class] forCellWithReuseIdentifier:@"ReclassifyCollectionCell"];
        
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];  //  一定要设置
        _collectionView.backgroundColor = RGBColor(241, 241, 241);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

#pragma mark 加载数据
- (void)loadData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"id"] = @"1";
    parameters[@"page"] = @"1";
    parameters[@"size"] = @"10";
    [HttpRequest postPath:GoodsTypeList params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSLog(@"====%@",responseObject);
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            
            
        }else {
            NSLog(@"====%@",baseModel.message);
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*cellIdentifier = @"ClassifyLeftCell";
    ClassifyLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ClassifyLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setUpTitle:self.titleArr[indexPath.row]];
    [cell changeSelectWithType:self.selectArr[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SizeWidth(42);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i<self.selectArr.count; i++) {
        if (i == indexPath.row) {
            self.selectArr[i][@"type"] = @"1";
        } else {
            self.selectArr[i][@"type"] = @"0";
        }
    }
    [_tableView reloadData];
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReclassifyCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReclassifyCollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ReclassifyCollectionCell alloc] init];
    }
    
    return cell;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"二级标题";
    lb.textColor = RGBColor(51, 51, 51);
    lb.font = NormalFont(14);
    [headerView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(SizeWidth(27));
        make.centerY.equalTo(headerView);
    }];
    
    return headerView;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, SizeWidth(10),0,SizeWidth(10));
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(homeItemsDidSelectWithTag:)]) {
    //        [self.delegate homeItemsDidSelectWithTag:indexPath.row];
    //    }
}


#pragma mark 懒加载
- (NSMutableArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = [[NSMutableArray alloc] initWithObjects:@"脑说得对",@"别别别吧",@"呜呜呜呜",@"啛啛喳喳",@"柔柔弱弱", nil];
    }
    return _titleArr;
}

- (NSMutableArray *)selectArr {
    if (_selectArr == nil) {
        _selectArr = [NSMutableArray new] ;
    }
    return _selectArr;
}

@end
