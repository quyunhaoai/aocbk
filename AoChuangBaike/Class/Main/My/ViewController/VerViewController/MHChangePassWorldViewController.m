
//
//  MHChangePassWorldViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHChangePassWorldViewController.h"
#import "MHChangePassView.h"
@interface MHChangePassWorldViewController ()

@property (strong, nonatomic) MHChangePassView *TextView;
@end

@implementation MHChangePassWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBarWithBlackTitle:@"修改密码"];
    [self setupUI];
}

- (void)setupUI {
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =Color_2A2A2A;
        view.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:20];
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"设置新密码";
        view ;

    });
    [self.view addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(177, 14));
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 30);
    }];
    
    [self.view addSubview:self.TextView];
    [self.TextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(Window_W, 300));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(30);
    }];
    
    
}
- (MHChangePassView *)TextView {
    if (!_TextView) {
        _TextView = [[MHChangePassView alloc] init];
    }
    return _TextView;
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
