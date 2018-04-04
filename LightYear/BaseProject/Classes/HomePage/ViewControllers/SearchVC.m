//
//  SearchVC.m
//  BaseProject
//
//  Created by wuyb on 2018/3/21.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UIButton *backBtn;

@property(nonatomic,strong) UITableView *leftTableView;

@property(nonatomic,strong) NSMutableArray *leftArray;

@property(nonatomic,copy) NSString *telStr;

@property(nonatomic,assign) BOOL isSearchOver;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSearchOver = NO;
    [self creatView];
}

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault  ;
}

-(void)viewWillDisappear:(BOOL)animated {
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
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(SizeWidth(33));
        make.width.mas_offset(SizeWidth(312));
        make.top.equalTo(weakSelf.view).offset(25);
        make.left.equalTo(weakSelf.view).offset(SizeWidth(15));
    }];
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
    [_backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_backBtn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    _backBtn.titleLabel.font = NormalFont(14);
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SizeWidth(49));
        make.height.mas_equalTo(SizeWidth(33));
        make.top.equalTo(weakSelf.view).offset(25);
        make.left.equalTo(_searchBar.mas_right);
    }];
    
//    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Width_px(90)+20.5, SCREEN_WIDTH, SCREEN_HEIGHT-Width_px(90)-20.5) style:UITableViewStylePlain];
//    _leftTableView.delegate = self;
//    _leftTableView.dataSource = self;
//    _leftTableView.backgroundColor = [UIColor clearColor];
//    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_leftTableView];
}





#pragma mark UITableViewDelegate,UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_leftArray.count == 0) {
//        return 1;
//    } else {
//        return _leftArray.count;
//    }
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_leftArray.count == 0 ) {
//        static NSString*cellIdentifier = @"DPNoDataCell";
//        DPNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
//            cell = [[DPNoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//        return cell;
//    } else {
//        static NSString*cellIdentifier = @"DPFansListCell";
//        DPFansListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
//            cell = [[DPFansListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//        cell.type = 6;
//        cell.indexPath = indexPath;
//        cell.delegate  = self;
//        if (self.leftArray.count > 0) {
//            [cell setUpData:self.leftArray[indexPath.row]];
//
//        }
//        return cell;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.leftArray.count == 0) {
//        return Width_px(500);
//    }else{
//        return SCREEN_WIDTH*0.187;
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.leftArray.count == 0) {
//        return;
//    }
//
//    DPFansModel *model = self.leftArray[indexPath.row];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(searchVCCellSelectWithModel:)]) {
//        [self.delegate searchVCCellSelectWithModel:model];
//    }
//    [self dismissViewControllerAnimated:NO completion:^{
//
//    }];
//
//}

#pragma mark
//- (void)focusBtnActionWithType:(NSInteger)type row:(NSInteger)row {
//    [self loadUserFocusDataWithRow:row];
//}

#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _telStr= searchBar.text;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar becomeFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    _telStr= searchBar.text;
//    [self loadSearchData];
}

#pragma mark 按钮事件
- (void)backBtnAction {
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

#pragma mark 懒加载
- (NSMutableArray *)leftArray {
    if (!_leftArray) {
        _leftArray = [NSMutableArray new];
    }
    return _leftArray;
}

@end
