//
//  CustomNativeActionSheet.m
//  my
//
//  Created by 税鸽飞腾 on 2018/6/17.
//  Copyright © 2018年 LWJ. All rights reserved.
//
#define kMainWidth  [UIScreen mainScreen].bounds.size.width
#define kMainHeight [UIScreen mainScreen].bounds.size.height
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#define SPACE 10
#import "CustomNativeActionSheet.h"

@interface CustomNativeActionSheet ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy)  NSString     *         cancelTitle;
@property (nonatomic,strong)UIView       *         tableViewHeadView;
@property (nonatomic,strong)UIView       *         maskView;
@property (nonatomic,strong)UITableView  *         tableView;
@property (nonatomic,strong)NSArray      *         menuArr;

//menuTitleTextColorArr存放的ColorRGB(r, g, b)
@property (nonatomic,strong)NSArray      *         menuTitleTextColorArr;

@end
static  NSString *const cellIdentifier = @"CELL";
@implementation CustomNativeActionSheet

- (instancetype _Nullable )initActionSheetWithTitleView:(UIView*_Nullable)titleView
                                               menuArr:(NSArray *_Nonnull)menuArr
                                 menuTitleTextColorArr:(NSArray *_Nonnull)menuTitleTextColorArr
                                          cancelTitle:(NSString *_Nonnull)cancelTitle
                                  SMenuBlock:(selectedMenuBlock _Nonnull )SMenuBlock
                                           CBlock:(cancelBlock _Nullable )CBlock{
    self = [super init];
    if (self ) {
        self.cancelTitle = cancelTitle;
        self.tableViewHeadView = titleView;
        self.menuArr = menuArr;
        self.menuTitleTextColorArr = menuTitleTextColorArr;
        self.SMenuBlock = SMenuBlock;
        self.CBlock = CBlock;
        
        [self creatMianUI];
    }
    return self;
}
- (void)creatMianUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.layer.cornerRadius = 10;
        _tableView.clipsToBounds = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight       = 55.0;
        _tableView.tableHeaderView = _tableViewHeadView;
        //改变默认 cell 距离左边的距离
        _tableView.separatorInset  = UIEdgeInsetsMake(0, -10, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return (section == 0)?_menuArr.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.section==0) {
        cell.textLabel.text = _menuArr[indexPath.row];
        UIColor *textColor = _menuTitleTextColorArr[indexPath.row];
        cell.textLabel.textColor = textColor;
        if (indexPath.row==_menuArr.count-1) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kMainWidth-(SPACE*2), tableView.rowHeight) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.path = maskPath.CGPath;
            maskLayer.frame = cell.contentView.bounds;
            cell.layer.mask = maskLayer;
        }
    }else{
        cell.textLabel.text = _cancelTitle;
        cell.layer.cornerRadius = 10;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        if (_SMenuBlock) {
            self.SMenuBlock(indexPath.row);
        }
    } else {
        if (_CBlock) {
            self.CBlock();
        }
    }
    
    [self dismiss];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SPACE;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, SPACE)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (void)layoutSubviews{
     [super layoutSubviews];
     [self reSetTableViewFramWithAnimattion];
     [self show];
}
- (void)show {
    
    UIWindow *window =[[[UIApplication sharedApplication]delegate]window];
    [window addSubview:self];
    
}
#pragma 重设tableView 的fram  和 动画
- (void)reSetTableViewFramWithAnimattion{
    
    _tableView.frame = CGRectMake(SPACE, kMainHeight, kMainWidth - (SPACE * 2), _tableView.rowHeight * (_menuArr.count + 1) + _tableViewHeadView.bounds.size.height + (SPACE * 2));
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y -= _tableView.bounds.size.height;
        _tableView.frame = rect;
    }];
    
}
- (void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        
        CGRect rect = _tableView.frame;
        rect.origin.y += _tableView.bounds.size.height;
        _tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
