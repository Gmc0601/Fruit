//
//  SearchVC.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "SearchVC.h"

#import "HotCollectionCell.h"
#import "ScreenView.h"
#import "GoodsDetailVC.h"

@interface SearchVC ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ScreenViewDelegate>
{
    NSInteger _searchType; //1综合排序2销量3价格4上新
    NSInteger _sort;  //1升序2降序
    NSInteger _leftPage;
    NSInteger _leftType;
}

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,strong) UIView *searchView;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *goodsArray;

@property(nonatomic,strong) NSMutableArray *historyArray;

@property(nonatomic,copy) NSString *telStr;

@property(nonatomic,assign) BOOL isSearchOver;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSearchOver = NO;
    _searchType = 1;
    _sort = 2;
    _leftPage = 1;
    _leftType = 0;
    [self creatView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;
}

- (void)creatView {
    WEAKSELF
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"搜索商品、美食";
    _searchBar.showsCancelButton = NO;
    [_searchBar setSearchResultsButtonSelected:YES];
    _searchBar.tintColor = RGBColor(51, 51, 51);
    _searchBar.backgroundImage = [UIImage imageNamed:@"gray"];
    _searchBar.delegate = self;
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = RGBColor(238, 238, 238);
    searchField.font = NormalFont(14);
    [searchField setValue:NormalFont(14) forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_searchBar];
    _searchBar.frame = CGRectMake(SizeWidth(15), 25, SizeWidth(312), SizeWidth(33));

    [self.searchBar becomeFirstResponder];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGBColor(238, 238, 238);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.searchBar.mas_bottom).offset(5);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(0.5);
    }];
    
    _backBtn = [[UIButton alloc] init];
    _backBtn.frame = CGRectMake(SizeWidth(327), 25, SizeWidth(49), SizeWidth(33));
    [_backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_backBtn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    _backBtn.titleLabel.font = NormalFont(14);
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    ScreenView *screenView = [[ScreenView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, SizeWidth(44))];
    screenView.delegate = self;
    [self.view addSubview:screenView];
    
    [self.view addSubview:self.collectionView];
    [self setUpRefresh];
//    [self creatSearchView];
    
//    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Width_px(90)+20.5, SCREEN_WIDTH, SCREEN_HEIGHT-Width_px(90)-20.5) style:UITableViewStylePlain];
//    _leftTableView.delegate = self;
//    _leftTableView.dataSource = self;
//    _leftTableView.backgroundColor = [UIColor clearColor];
//    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_leftTableView];
}

- (void)creatSearchView {
    [_searchView removeFromSuperview];
    [self.historyArray removeAllObjects];
    self.historyArray = [ConfigModel getArrforKey:@"historyArray"];
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    _searchView = searchView;
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"历史搜索";
    lb1.textColor = RGBColor(51, 51, 51);
    lb1.font = BOLDSYSTEMFONT(17);
    [searchView addSubview:lb1];
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchView).offset(SizeWidth(25));
        make.left.equalTo(searchView).offset(SizeWidth(15));
    }];
    
    UIButton *clearBtn = [[UIButton alloc] init];
    clearBtn.frame = CGRectMake(SizeWidth(327), 25, SizeWidth(49), SizeWidth(33));
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearBtn setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateNormal];
    clearBtn.titleLabel.font = NormalFont(17);
    [clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lb1);
        make.right.equalTo(searchView).offset(-SizeWidth(2));
        make.width.mas_offset(SizeWidth(59));
        make.height.mas_offset(SizeWidth(40));
    }];
    
    
    
    if (self.historyArray.count == 0) {
        UILabel *lb2 = [UILabel new];
        lb2.text = @"暂无历史搜索";
        lb2.textColor = RGBColor(153, 153, 153);
        lb2.font = NormalFont(15);
        [searchView addSubview:lb2];
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lb1.mas_bottom).offset(SizeWidth(24));
            make.left.equalTo(searchView).offset(SizeWidth(15));
        }];
    } else {
        [self creatHistoryBtn];
    }

}

- (void)creatHistoryBtn {
    //热门关键词
    //第一个 button的起点
    CGSize size = CGSizeMake(SizeWidth(15), SizeWidth(61));
    
    //间距
    CGFloat padding = SizeWidth(15);
    
    CGFloat width = kScreenW - SizeWidth(30);
    
    
    for (int i = 0; i < self.historyArray.count; i ++) {
        
        CGFloat keyWorldWidth = [self getWidthWithString:self.historyArray[i] fontSize:15 maxHeight:SizeWidth(31)]+SizeWidth(20);
        if (keyWorldWidth > width) {
            keyWorldWidth = width;
        }
        
        if (size.height > SizeWidth(400)) {
            break;
        }
        if (width - size.width < keyWorldWidth) {
            size.height +=  SizeWidth(45);
            size.width = SizeWidth(15);
        }
        
        //创建 button
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(size.width, size.height, keyWorldWidth,SizeWidth(31))];
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateNormal];
        button.layer.cornerRadius = 1.0;
        button.layer.borderWidth = 1;
        button.layer.borderColor = RGBColor(153, 153, 153).CGColor;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = NormalFont(15);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:self.historyArray[i] forState:UIControlStateNormal];
        [_searchView addSubview:button];
        button.tag = 200+i;
        [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //起点 增加
        size.width += keyWorldWidth+padding;
        
        
    }
}

//计算文字所占大小
-(CGFloat)getWidthWithString:(NSString *)string
fontSize:(CGFloat)size
maxHeight:(CGFloat)height {
    UIFont * font = [UIFont systemFontOfSize:size];
    CGSize tempSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName : font
                                                     }
                                           context:nil].size;
    //        size.width += 5;
    return tempSize.width;
}

- (void)searchOver {
    [self.historyArray addObject:_telStr];
    NSSet *set = [NSSet setWithArray:(NSArray *)self.historyArray];
    [self.historyArray removeAllObjects];
    [self.historyArray addObjectsFromArray:[set allObjects]];
    [ConfigModel saveArr:self.historyArray forKey:@"historyArray"];
    [_searchView removeFromSuperview];
    _searchBar.frame = CGRectMake(SizeWidth(49), 25, SizeWidth(312), SizeWidth(33));
    [_backBtn setTitle:@"" forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"erjiye_return"]  forState:UIControlStateNormal];
    _backBtn.frame = CGRectMake(0, 25, SizeWidth(49), SizeWidth(33));
    _searchView.hidden = YES;
}

#pragma mark 加载数据
- (void)loadGoodsIndexData {

    [ConfigModel showHud:self];
    NSString *shopId = [ConfigModel getStringforKey:ShopId];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"key"] = _telStr;
    parameters[@"search_type"] = @(_searchType);
    parameters[@"sort"] = @(_sort);
    parameters[@"shopid"] = shopId;
    parameters[@"page"] = @(_leftPage);
    parameters[@"size"] = @"20";
    [HttpRequest postPath:searchUrl params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (_leftType == 0) {
            [self.goodsArray removeAllObjects];
        }
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"];
            for (NSDictionary *dic in arr) {
                GoodsIndexModel *goodsIndexModel = [GoodsIndexModel yy_modelWithDictionary:dic];
                [self.goodsArray addObject:goodsIndexModel];
            }
            [_collectionView reloadData];
            
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];
}



#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SizeWidth(165), SizeWidth(250));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+SizeWidth(44), SizeWidth(375),kScreenH-64-SizeWidth(44)) collectionViewLayout:layout];
        //        UIImageView *imgV = [UIImageView new];
        //        imgV.image = [UIImage imageNamed:@"我的背景黑2"];
        //        _collectionView.backgroundView = imgV;
        _collectionView.showsHorizontalScrollIndicator = NO;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = SizeWidth(15);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        [_collectionView registerClass:[HotCollectionCell class] forCellWithReuseIdentifier:@"HotCollectionCell"];
        _collectionView.backgroundColor = RGBColor(255, 255, 255);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _telStr= searchBar.text;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self creatSearchView];
    [self.searchBar becomeFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    _telStr= searchBar.text;
    [self loadGoodsIndexData];
    [self searchOver];
}

#pragma mark 按钮事件
- (void)backBtnAction {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:NO completion:^{
    
//    }];
}

/**
 *  添加下拉加载
 */
-(void)setUpRefresh
{
    WEAKSELF
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        _leftPage = 1;
        _leftType = 0;

        [weakSelf loadGoodsIndexData];
    }];
    _collectionView.mj_footer  = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _leftPage ++;
        _leftType = 1;
        [weakSelf loadGoodsIndexData];
    }];
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HotCollectionCell alloc] init];
    }
    [cell setUpData:self.goodsArray[indexPath.item]];
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, SizeWidth(15),0,SizeWidth(15));
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsIndexModel *model = self.goodsArray[indexPath.row];
    GoodsDetailVC *vc = [GoodsDetailVC new];
    vc.goodsId = model.goodsId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ScreenViewDelegate
// 0、综合  1、销量  2、价格降序 3、价格升序  4、上新
-(void)screenViewDidSelectWihtIndex:(NSInteger)index {
    _leftType = 0;
    _leftPage = 1;
    switch (index) {
        case 0:
        {
            _searchType = 1;
            _sort = 2;
            NSLog(@"综合");
        }
            break;
        case 1:
        {
            _searchType = 2;
            _sort = 2;
            NSLog(@"销量");
        }
            break;
        case 2:
        {
            NSLog(@"价格降序");
            _searchType = 3;
            _sort = 2;
        }
            break;
        case 3:
        {
            NSLog(@"价格升序");
            _searchType = 3;
            _sort = 1;
        }
            break;
        case 4:
        {
            NSLog(@"上新");
            _searchType = 4;
            _sort = 2;
        }
            break;
            
        default:
            break;
    }
    
    [self loadGoodsIndexData];
}

- (void)tagButtonClick : (UIButton *)btn {
    
    [self.view endEditing:YES];
    _telStr= self.historyArray[btn.tag-200];
    _searchBar.text = _telStr;
    [self loadGoodsIndexData];
    [self searchOver];
}

- (void)clearBtnAction {
    [self.historyArray removeAllObjects];
    [ConfigModel saveArr:self.historyArray forKey:@"historyArray"];
    [self creatSearchView];
}

#pragma mark 懒加载
- (NSMutableArray *)goodsArray {
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (NSMutableArray *)historyArray {
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray new];
    }
    return _historyArray;
}

@end
