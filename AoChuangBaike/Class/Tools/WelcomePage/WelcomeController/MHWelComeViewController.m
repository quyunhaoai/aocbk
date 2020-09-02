

//
//  MHWelComeViewController.m
//  MentalHorizonProject
//
//  Created by    on 2020/5/6.
//  Copyright © 2020   . All rights reserved.
//

#import "MHWelComeViewController.h"
#import "LBPGuideView.h"
#import "AppDelegate.h"
#import "CCTabbarViewController.h"
@interface MHWelComeViewController ()

@end

@implementation MHWelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LBPGuideView *view = [LBPGuideView showGuideViewWithImages:@[@"引导页1",@"引导页2",@"引导页3"]];
    view.pageControlHidden = YES;
    view.enterButtonHidden = YES;
    [self.view addSubview:view];
    view.frame = self.view.frame;
    view.loadOver = ^{
        [AppDelegate sharedAppDelegate].window.rootViewController = [CCTabbarViewController getTabBarController];
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
