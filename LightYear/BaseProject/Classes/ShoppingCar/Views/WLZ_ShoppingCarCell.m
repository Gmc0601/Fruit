//
//  WLZ_ShoppingCarCell.m
//  WLZ_ShoppingCart
//
//  Created by lijiarui on 15/12/14.
//  Copyright © 2015年 lijiarui. All rights reserved.
//

#import "WLZ_ShoppingCarCell.h"
#import "UIImageView+WebCache.h"
#import "WLZ_ShoppingCarController.h"
#import "UIColor+WLZ_HexRGB.h"
static CGFloat CELL_HEIGHT = 100;


@interface WLZ_ShoppingCarCell () <UITextFieldDelegate>


@property(nonatomic,strong)UIButton *selectBt;
@property(nonatomic,strong)UIImageView *shoppingImgView;
@property(nonatomic,strong)UIImageView *spuImgView;
@property(nonatomic,strong)UILabel *title ;
@property(nonatomic,strong)WLZ_ChangeCountView *changeView;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *sizeLab;

@property(nonatomic,assign)CGRect tableVieFrame;



@end

@implementation WLZ_ShoppingCarCell


- (void)prepareForReuse
{
    [super prepareForReuse];

    [_shoppingImgView sd_setImageWithURL:nil];
    [_changeView removeFromSuperview];
    _spuImgView.image = nil;
    _changeView = nil;
    _sizeLab.text = nil;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
       _tableView = tableView;
        [self initCellView];
    }
    return self;
}
- (void)initCellView
{
    
    
    UIImage *btimg = [UIImage imageNamed:@"ic_cb_normal.png"];
    UIImage *selectImg = [UIImage imageNamed:@"gouwuche_selected"];
    
    _selectBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btimg.size.width+20, CELL_HEIGHT)];
    [_selectBt addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBt setImage:btimg forState:UIControlStateNormal];
    [_selectBt setImage:selectImg forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBt];
    
    
    
    _shoppingImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_selectBt.frame)+7, 12, 70, 70)];
    [self.contentView addSubview:_shoppingImgView];
    
    _spuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [_shoppingImgView addSubview:_spuImgView];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_shoppingImgView.frame)+10, 10, kScreenW-CGRectGetMaxX(_shoppingImgView.frame)-15, 21)];
    _title.font=[UIFont systemFontOfSize:15];
    _title.textColor=[UIColor colorFromHexRGB:@"666666"];
    
    [self.contentView addSubview:_title];
    
    
    _sizeLab = [[UILabel alloc] initWithFrame:CGRectMake(_title.frame.origin.x, CGRectGetMaxY(_title.frame), 200, 17)];
    _sizeLab.font=[UIFont systemFontOfSize:12];
    _sizeLab.textColor=[UIColor colorFromHexRGB:@"666666"];
    [self.contentView addSubview:_sizeLab];
    
    
    
   
    
    
    _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(_title.frame.origin.x, CGRectGetMaxY(_sizeLab.frame)+5+5, 100, 17)];
    _priceLab.textAlignment=NSTextAlignmentLeft;
    _priceLab.textColor=[UIColor colorFromHexRGB:@"FF4C44"];
    _priceLab.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_priceLab];
    
    
   
    
    
    
}





- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _changeView.numberFD = textField;
    if ([self isPureInt:_changeView.numberFD.text]) {
        if ([_changeView.numberFD.text integerValue]<0) {
            _changeView.numberFD.text=@"1";
        
       
        }
        
    }
    else
    {
        _changeView.numberFD.text=@"1";
        [self addCardeleteCar];
    }
    
    
    if ([_changeView.numberFD.text isEqualToString:@""] || [_changeView.numberFD.text isEqualToString:@"0"]) {
        self.choosedCount = 1;
        _changeView.numberFD.text=@"1";
       
        
    }
    NSString *numText = _changeView.numberFD.text;
   
    
    if ([numText intValue] >_model.stock) {
      //  [SVProgressHUD showErrorWithStatus:@"最多支持购买99个"];
        _changeView.numberFD.text = [NSString stringWithFormat:@"%zi",_model.stock];
   
    }
    
    if ([numText intValue] >99) {
        //  [SVProgressHUD showErrorWithStatus:@"最多支持购买99个"];
        _changeView.numberFD.text = @"99";
        
       
    }
    
    _changeView.addButton.enabled=YES;
    _changeView.subButton.enabled=YES;
    self.choosedCount = [_changeView.numberFD.text integerValue];
    _model.count = _changeView.numberFD.text;
    _model.isSelect = _selectBt.selected;
    [self addCardeleteCar];
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}




- (void)setModel:(WLZ_ShoppIngCarModel *)model
{
    _model = model;
    _selectBt.selected=model.isSelect;
    if (_changeView.numberFD.text) {
        self.choosedCount = [_changeView.numberFD.text integerValue];
    }
    else{
        self.choosedCount =[model.count integerValue] ;
    }
    [self.shoppingImgView sd_setImageWithURL:[NSURL URLWithString:model.img_path] placeholderImage:[UIImage imageNamed:@"default"]];
    _shoppingImgView.layer.cornerRadius = 2;
    _shoppingImgView.layer.borderWidth = 1;
    _shoppingImgView.layer.borderColor = [UIColor colorFromHexRGB:@"e2e2e2"].CGColor;
   
    self.title.text=model.title;
    self.sizeLab.text=model.sub_title;
    self.priceLab.text=model.price;
    
    _selectBt.enabled=YES;
   
    _changeView = [[WLZ_ChangeCountView alloc] initWithFrame:CGRectMake(kScreenW-120, CGRectGetMaxY(_sizeLab.frame)+5, 160, 35) chooseCount:self.choosedCount totalCount: 99];
    
    [_changeView.subButton addTarget:self action:@selector(subButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _changeView.numberFD.delegate = self;
    
    [_changeView.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _changeView.numberFD.text=model.count;
    [self.contentView addSubview:_changeView];
    
 
    
}
//加
- (void)addButtonPressed:(id)sender
{
    
    if (self.choosedCount<99) {
        ++self.choosedCount ;
        [self addCardeleteCar];
    }else
    {
         ++self.choosedCount ;
    }
    
   
    if (self.choosedCount>0) {
        _changeView.subButton.enabled=YES;
    }
    
//    if (_model.stock <self.choosedCount) {
//        self.choosedCount  = _model.stock;
//        _changeView.addButton.enabled = NO;
//    }
//    else
//    {
//        _changeView.subButton.enabled = YES;
//    }
//   
    
    if(self.choosedCount>=99)
    {
        self.choosedCount  = 99;
        _changeView.addButton.enabled = NO;
    }
    
    _changeView.numberFD.text=[NSString stringWithFormat:@"%zi",self.choosedCount];
    
    _model.count = _changeView.numberFD.text;
    _model.isSelect=_selectBt.selected;
    
    
    
    
    
    
}

-(void)addCardeleteCar
{
    
   
    if (self.AddBlock) {
        self.AddBlock(self.choosedCount);
    }

  
}


-(void)clickSelect:(UIButton *)bt
{
    
 
    _selectBt.selected = !_selectBt.selected;
    _model.isSelect = _selectBt.selected;
    
    if (_changeView.numberFD.text!=nil) {
        _model.count = _changeView.numberFD.text;
    }
    
    [self.delegate singleClick:_model row:self.row];
  
    
  
}

//减
- (void)subButtonPressed:(id)sender
{
    
    if (self.choosedCount >1) {
         -- self.choosedCount ;
         [self addCardeleteCar];
    }else
    {
        -- self.choosedCount ;
    }
    
  
    
    if (self.choosedCount==0) {
        self.choosedCount= 1;
        _changeView.subButton.enabled=NO;
    }
    else
    {
        _changeView.addButton.enabled=YES;
        
    }
    _changeView.numberFD.text=[NSString stringWithFormat:@"%zi",self.choosedCount];
    
    _model.count = _changeView.numberFD.text;
    
    _model.isSelect=_selectBt.selected;
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)deleteCar
{
    
    
}

+(CGFloat)getHeight
{
    return CELL_HEIGHT;
}

@end
