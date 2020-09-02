//
//  CCTabbarViewController.m
//  CunCunTong
//
//  Created by    on 2020/3/14.
//  Copyright © 2020   . All rights reserved.
//

#import "CCTabbarViewController.h"
#import "CCBaseNavController.h"
#import "CCBaseViewController.h"
#import "MHMyViewController.h"
#import "MHHomeViewController.h"
@interface CCTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation CCTabbarViewController

+ (instancetype)getTabBarController {
    static CCTabbarViewController *tabbar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tabbar == nil) {
            tabbar = [[CCTabbarViewController alloc] init];
        }
    });
    return tabbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self builderTabbarView];

    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] size:CGSizeMake(Window_W,0.7)]];
}


- (void)builderTabbarView {
    self.delegate = self;
    self.tabBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.tabBar.backgroundImage = [UIImage imageWithColor:kWhiteColor];
    self.tabBar.layer.shadowColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:0.36].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0,1);
    self.tabBar.layer.shadowOpacity = 1;
    self.tabBar.layer.shadowRadius = 11;
    self.tabBar.layer.borderWidth = 0.5;
    self.tabBar.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    CCBaseNavController *home = [[CCBaseNavController alloc] initWithRootViewController:[MHHomeViewController new]];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:IMAGE_NAME(@"") selectedImage:IMAGE_NAME(@"")];
    
    CCBaseNavController *my = [[CCBaseNavController alloc] initWithRootViewController:[[MHMyViewController alloc] initWithStyle:UITableViewStyleGrouped]];
    my.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:IMAGE_NAME(@"") selectedImage:IMAGE_NAME(@"")];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = COLOR_666666;
 
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = UIColorHex(0x0072FF);
    
    
    NSArray *viewCtrlArray = @[home,my];
    // 创建可变数组，存放导航控制器
    NSMutableArray *navCtrls = [NSMutableArray array];
    // 遍历视图控制器数组
    @autoreleasepool {
        for (UIViewController *viewCtrl in viewCtrlArray) {
            // 为视图控制器添加导航栏
            [viewCtrl.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            [viewCtrl.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            [navCtrls addObject:viewCtrl];
        }
    }
    self.viewControllers = navCtrls;
    self.tabBar.tintColor = kWhiteColor;
}


@end
