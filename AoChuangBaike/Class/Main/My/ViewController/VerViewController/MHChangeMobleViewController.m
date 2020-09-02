

//
//  MHChangeMobleViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHChangeMobleViewController.h"
#import "PushViewController.h"
@interface MHChangeMobleViewController ()

@end

@implementation MHChangeMobleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"更换手机号"];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self.getVerBtn setBackgroundColor:kMainColor];
    self.getVerBtn.layer.cornerRadius = 22.5;
    
}
- (IBAction)sendMobleVer:(UIButton *)sender {
    PushViewController *vc = [[PushViewController alloc] initWithPushViewController:@"18622226666"];
    [self.navigationController pushViewController:vc animated:YES];
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
