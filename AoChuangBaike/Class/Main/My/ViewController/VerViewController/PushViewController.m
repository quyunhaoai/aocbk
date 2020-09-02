//
//  PushViewController.m
//  GhuiDemo
//
//  Created by Ghui on 2020/3/23.
//  Copyright © 2020 Ghui. All rights reserved.
//
#define GH_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define GH_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define Width_Space      ([[UIScreen mainScreen] bounds].size.width-280)/5

#import "PushViewController.h"
#import "GHValidationCodeView.h"
#import "MHChangePassWorldViewController.h"
@interface PushViewController ()<UITextFieldDelegate>
@property (nonatomic, copy  ) NSString *phoneStr;
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;
@property (nonatomic, strong) UITextField *textField4;
@property (nonatomic, strong) GHValidationCodeView *codeView;
@property (nonatomic, strong) UIButton *receiveCheckNumBtn;
@property (nonatomic, strong) UILabel *receiveCheckNumLab;
@end

@implementation PushViewController
- (id)initWithPushViewController:(NSString *)phone{
    self = [super init];
    if (self) {
        self.phoneStr = phone;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBarWithBlackTitle:@"修改密码"];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self setupViews];
    
    //初次进入的时候直接开始验证码倒计时（需要调用获取验证码接口） 倒计时结束后重新获取也是调这个方法
    [self receiveCheckNumButton];
    
    
    //strat 4位验证码View 可以提取出来放到其他页面上
    //labelCount n位验证码   labelDistance 间距
    self.codeView = [[GHValidationCodeView alloc] initWithFrame:CGRectMake(0, 250, GH_WIDTH, 50) andLabelCount:4 andLabelDistance:Width_Space];
    self.codeView.changedColor = [UIColor orangeColor];
    [self.view addSubview:self.codeView];
    
    __weak typeof(self) weakSelf = self;
    self.codeView.codeBlock = ^(NSString *codeString) {
        NSLog(@"输入的验证码:%@", codeString);
        
        //假设后台验证码是1111
        NSString *str = @"1111";
        if (codeString.length == 4) {
            if ([codeString isEqualToString:str]) {
                //验证通过
                NSLog(@"验证通过");
                MHChangePassWorldViewController *vc = [MHChangePassWorldViewController new];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                //如果验证码错误 直接清空
                [weakSelf.codeView clearCoed];
                NSLog(@"验证码错误");
            }
        }

    };
    //end 4位验证码View 可以提取出来放到其他页面上
}

//初次进入的时候直接开始验证码倒计时（需要调用获取验证码接口） 倒计时结束后重新获取也是调这个方法
- (void)receiveCheckNumButton{

    __block int timeout=60; //倒计时时间
    __weak typeof(self) weakSelf = self;

      dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

       dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);

      dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

      dispatch_source_set_event_handler(_timer, ^{

          if(timeout<=0){ //倒计时结束，关闭

              dispatch_source_cancel(_timer);

             dispatch_async(dispatch_get_main_queue(), ^{

                 //设置界面的按钮显示 根据自己需求设置
                 weakSelf.receiveCheckNumLab.text = @"重新获取";

                 weakSelf.receiveCheckNumBtn.userInteractionEnabled = YES;

                 weakSelf.receiveCheckNumBtn.backgroundColor = [UIColor clearColor];

              });

          }else{

              int seconds = timeout;
              __weak typeof(self) weakSelf = self;

              NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];

             dispatch_async(dispatch_get_main_queue(), ^{

                 //让按钮变为不可点击的灰色

                 weakSelf.receiveCheckNumBtn.backgroundColor = [UIColor clearColor];

                 weakSelf.receiveCheckNumBtn.userInteractionEnabled = NO;

                 //设置界面的按钮显示 根据自己需求设置

                 [UIView beginAnimations:nil context:nil];

                 [UIView setAnimationDuration:1];

                 NSString *string = [NSString stringWithFormat:@"重新发送验证码%@s",strTime];
                 NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
                 [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(7,string.length-7)];
                 weakSelf.receiveCheckNumLab.attributedText = str;


                 [UIView commitAnimations];

              });

              timeout--;

           }

       });

       dispatch_resume(_timer);

}

- (void)setupViews{
    UILabel *topLab = [[UILabel alloc]init];
    topLab.text = @"请输入验证码";
    [topLab setFont:[UIFont fontWithName:@"Helvetica-Bold"size:20]];
    topLab.textColor = [UIColor blackColor];
    topLab.frame = CGRectMake(0, 120, Window_W, 50);
    topLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:topLab];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = [NSString stringWithFormat:@"已发送至手机：+86 %@",self.phoneStr];
    phoneLab.textColor = [UIColor grayColor];
    phoneLab.font = [UIFont systemFontOfSize:14.f];
    phoneLab.textAlignment = NSTextAlignmentCenter;
    phoneLab.frame = CGRectMake(0, 180, Window_W, 30);
    [self.view addSubview:phoneLab];
    
    UILabel *line1 = [[UILabel alloc]init];
    line1.text = @"";
    line1.backgroundColor = [UIColor grayColor];
    line1.frame = CGRectMake(Width_Space, 300, 70, 1);
    [self.view addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc]init];
    line2.text = @"";
    line2.backgroundColor = [UIColor grayColor];
    line2.frame = CGRectMake(Width_Space*2+70, 300, 70, 1);
    [self.view addSubview:line2];
    
    UILabel *line3 = [[UILabel alloc]init];
    line3.text = @"";
    line3.backgroundColor = [UIColor grayColor];
    line3.frame = CGRectMake(Width_Space*3+140, 300, 70, 1);
    [self.view addSubview:line3];
    
    UILabel *line4 = [[UILabel alloc]init];
    line4.text = @"";
    line4.backgroundColor = [UIColor grayColor];
    line4.frame = CGRectMake(Width_Space*4+210, 300, 70, 1);
    [self.view addSubview:line4];
    
    _receiveCheckNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 320, 150, 40 )];
    _receiveCheckNumBtn.backgroundColor = [UIColor clearColor];
    [_receiveCheckNumBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _receiveCheckNumBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _receiveCheckNumBtn.layer.cornerRadius = 5;
    _receiveCheckNumBtn.layer.masksToBounds = YES;
    [_receiveCheckNumBtn addTarget:self action:@selector(receiveCheckNumButton)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_receiveCheckNumBtn];
    
    _receiveCheckNumLab = [[UILabel alloc]init];
    _receiveCheckNumLab.text = @"";
    _receiveCheckNumLab.textColor = [UIColor grayColor];
    _receiveCheckNumLab.font = [UIFont systemFontOfSize:14.f];
    _receiveCheckNumLab.frame = CGRectMake(50, 320, 150, 40);
    _receiveCheckNumLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_receiveCheckNumLab];
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
