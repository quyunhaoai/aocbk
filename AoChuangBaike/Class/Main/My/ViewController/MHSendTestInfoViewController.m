


//
//  MHSendTestInfoViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHSendTestInfoViewController.h"
#import "MHAnswerRelustView.h"
@interface MHSendTestInfoViewController ()

@end

@implementation MHSendTestInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavBarWithTitle:@"2019心理学春季真题一"];
    MHAnswerRelustView *tiKa = [[MHAnswerRelustView alloc] init];
    [self.view addSubview:tiKa];
    [tiKa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    tiKa.categoryQuestionList = @[@"",@"",@""];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
