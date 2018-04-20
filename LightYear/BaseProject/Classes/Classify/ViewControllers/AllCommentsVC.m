//
//  AllCommentsVC.m
//  BaseProject
//
//  Created by wuyb on 2018/4/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "AllCommentsVC.h"

#import "CommentCell.h"

@interface AllCommentsVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *commentArray;

@end

@implementation AllCommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"全部评论";
    [self creatView];
    [self loadCommentsData];
}

- (void)creatView {
    //    WEAKSELF
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.backgroundColor = DPBGGrayColor;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)loadCommentsData {
    [ConfigModel showHud:self];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"good_id"] = _goodsId;
    parameters[@"page"] = @"1";
    parameters[@"size"] = @"20";
    
    [HttpRequest postPath:commentUrl params:parameters resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        [self.commentArray removeAllObjects];
        BaseModel * baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.error == 0) {
            NSArray *arr = responseObject[@"info"][@"data"];
            for (NSDictionary *dic in arr) {
                CommentsModel *commentsModel = [CommentsModel yy_modelWithDictionary:dic];
                [self.commentArray addObject:commentsModel];
            }
            [_tableView reloadData];
        }else {
            [ConfigModel mbProgressHUD:baseModel.message andView:nil];
        }
        
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.commentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = RGBColor(241, 241, 241);
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SizeWidth(10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*cellIdentifier = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setUpData:self.commentArray[indexPath.section]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentsModel *model = self.commentArray[indexPath.section];
    CGFloat textH = [UtilHelper getHeightWithString:model.content fontSize:14 maxWidth:SizeWidth(349)];
    CGFloat h = textH+SizeWidth(90);
    return h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark 懒加载
- (NSMutableArray *)commentArray {
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray  new];
        
    }
    return _commentArray;
}


@end
