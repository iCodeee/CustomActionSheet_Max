//
//  CustomNativeActionSheet.h
//  my
//
//  Created by 税鸽飞腾 on 2018/6/17.
//  Copyright © 2018年 LWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectedMenuBlock) (NSInteger index);
typedef void(^cancelBlock)(void);
@interface CustomNativeActionSheet : UIView

@property (nonatomic,copy)selectedMenuBlock _Nonnull               SMenuBlock;
@property (nonatomic,copy)cancelBlock       _Nullable              CBlock;
@property (nonatomic,strong,nullable)UIView *titleView;

/*
 *titleView               自定义标题 可以为nil
 *menuArr                 需要显示的按钮的数组
 *menuTitleTextColorArr   需要显示的按钮字体不同颜色的数组
 *cancelTitle             取消的标题
 *
 */
- (instancetype _Nullable )initActionSheetWithTitleView:(UIView*_Nullable)titleView
                                menuArr:(NSArray *_Nonnull)menuArr
                                menuTitleTextColorArr:(NSArray *_Nonnull)menuTitleTextColorArr
                                cancelTitle:(NSString *_Nonnull)cancelTitle
                                SMenuBlock:(selectedMenuBlock _Nonnull )SMenuBlock CBlock:(cancelBlock _Nullable )CBlock;


@end
