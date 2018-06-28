//
//  ViewController.m
//  CustomActionSheet
//
//  Created by 税鸽飞腾 on 2018/6/27.
//  Copyright © 2018年 LWJ. All rights reserved.
//
#define kMainWidth  [UIScreen mainScreen].bounds.size.width
#define kMainHeight [UIScreen mainScreen].bounds.size.height
#define ColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "ViewController.h"
#import "CustomNativeActionSheet.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth-20, 50)];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"我是标题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *menuArr = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5"];
    
    NSArray *menuTextColorArr = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor purpleColor],[UIColor blueColor]];
    
    
    CustomNativeActionSheet *ActionSheet = [[CustomNativeActionSheet alloc]initActionSheetWithTitleView:titleLabel menuArr:menuArr menuTitleTextColorArr:menuTextColorArr cancelTitle:@"取消" SMenuBlock:^(NSInteger index) {
        
        NSLog(@"++++++%@",menuArr[index]);
        
    } CBlock:^{
        
    }];
    
    [self.view addSubview:ActionSheet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
