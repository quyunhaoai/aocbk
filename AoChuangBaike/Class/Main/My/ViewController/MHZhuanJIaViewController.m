

//
//  MHZhuanJIaViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHZhuanJIaViewController.h"

@interface MHZhuanJIaViewController ()

@end

@implementation MHZhuanJIaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"专家入驻"];
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.showTableBlankView = YES;
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
