//
//  MHChangeMobleInputViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHChangeMobleInputViewController.h"

@interface MHChangeMobleInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MHChangeMobleInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"更换手机号"];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self.verBtn setBackgroundColor:kMainColor];
    self.verBtn.layer.cornerRadius = 22.5;
    
}
- (IBAction)sendVerCode:(UIButton *)sender {
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
