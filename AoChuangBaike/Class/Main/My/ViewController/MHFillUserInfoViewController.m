//
//  MHFillUserInfoViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHFillUserInfoViewController.h"
#import <Photos/Photos.h>
#import "UIImagePickerController+ST.h"
#import "STPhotoKitController.h"
#import "MHFillTextContentView.h"
#import "NKAlertView.h"
#import "BRDatePickerView.h"
#import "BottomAlert3ContentView.h"
#import "MHMyUserInfoModel.h"
@interface MHFillUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,STPhotoKitDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *titleArray1;
@property (nonatomic,strong) UIButton *goPayBtn;
@property (nonatomic,copy) NSString *headUrl;
@property (strong, nonatomic) UIImageView *headImage;
@property (nonatomic,copy) NSString *qianming;
@property (nonatomic,copy) NSString *nianString;
@property (strong, nonatomic) UITextField *fieldTextView;
@property (nonatomic,copy) NSString *sexStr;
@property (nonatomic,copy) NSString *school;
@property (nonatomic,copy) NSString *profession;
@property (nonatomic,copy) NSString *work;
@property (nonatomic,copy) NSString *nick;
@property (strong, nonatomic) NSDictionary * userInfoDic;
@property (strong, nonatomic) MHMyUserInfoModel *model;
@end

@implementation MHFillUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"完善信息"];
    [self initData];
    [self setupUI];
    
}
- (void)initData {
    NSData *data = [kUserDefaults objectForKey:userInfo];
    self.userInfoDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (self.userInfoDic!=nil) {
        self.model = [MHMyUserInfoModel mj_objectWithKeyValues:self.userInfoDic];
        self.nick = self.model.nickname;
        self.qianming = self.model.person_sign;
        self.school = self.model.school;
        self.profession = self.model.school;
        self.work = self.model.work;
    }
}
- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    UIView *headView = [UIView new];
    headView.userInteractionEnabled = YES;
    headView.frame = CGRectMake(0, 0, Window_W, 120);
    self.tableView.tableHeaderView = headView;
    UIImageView *imageBgView = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES ;
          view.layer.cornerRadius = 40;
          [view setImage:IMAGE_NAME(@"人头像 拷贝")];
          view;
      });
    if ([self.model.avatar isNotBlank]) {
        [imageBgView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar]];
        self.headUrl = self.model.avatar;
    }
    self.headImage = imageBgView;
    [headView addSubview:imageBgView];
    [imageBgView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(headView).mas_offset(15);
         make.size.mas_equalTo(CGSizeMake(80, 80));
         make.centerX.mas_equalTo(headView.mas_centerX);
      }];
      UIImageView *areaIcon = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES ;
          [view setImage:IMAGE_NAME(@"相机")];
          view;
      });
      
    [headView addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(imageBgView).mas_offset(-4);
          make.size.mas_equalTo(CGSizeMake(24, 24));
          make.bottom.mas_equalTo(imageBgView.mas_bottom);
      }];
    XYWeakSelf;
    [headView addTapGestureWithBlock:^(UIView *gestureView) {
        [weakSelf openCamcon];
    }];
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, Window_W, 110);
    self.tableView.tableFooterView = footerView;
    [footerView addSubview:self.goPayBtn];
    [self.goPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(footerView).mas_offset(-12);
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(footerView).mas_offset(17);
        make.height.mas_equalTo(50);
    }];
}

- (void)openTimeSelectVie:(UIView *)view{
    [self.fieldTextView resignFirstResponder];
    XYWeakSelf;
    UILabel *label = (UILabel *)view;
    NSString *str = [NSString getCurrentTime:@"yyyy"];
    [BRDatePickerView showDatePickerWithTitle:@"请选择" dateType:BRDatePickerModeY defaultSelValue:str resultBlock:^(NSString *selectValue) {
        label.text = selectValue;
        weakSelf.nianString = selectValue;
    }];
}

- (void)openSeletmenuView:(UIView *)view andNumber:(NSInteger )number {
    [self.fieldTextView resignFirstResponder];
    NKAlertView *alert = [[NKAlertView alloc] init];
    UILabel *lable = (UILabel *)view;
    BottomAlert3ContentView *textView = [[BottomAlert3ContentView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 302)];
    textView.btnClick = ^(NSString * _Nonnull str) {
        lable.text = str;
        if (number == 0) {
            self.school = lable.text;
        } else if (number == 1){
            self.work = lable.text;
        } else {
            self.profession = lable.text;
        }
    };
    textView.selectStr = lable.text;
    alert.contentView = textView;
    if (number == 0) {
        textView.dataArray= @[@"高中以下",@"专科",@"本科",@"硕士",@"博士及以上"].mutableCopy;
        self.school = lable.text;
    } else if (number == 1){
        textView.dataArray= @[@"学生",@"创业者",@"程序员",@"工程师",@"销售",@"运营",@"企业老板",@"中高层管理者",@"普通白领",@"公务员",@"事业单位员工",@"我自己填"].mutableCopy;
        self.work = lable.text;
    } else {
        textView.dataArray= @[@"未毕业",@"互联网",@"IT",@"制造业",@"金融",@"教育",@"医学医疗",@"建筑房地产",@"传媒",@"政府机关",@"我自己填"].mutableCopy;
        self.profession = lable.text;
    }
    alert.hiddenWhenTapBG = YES;
    alert.type = NKAlertViewTypeBottomNoCorner;
    [alert show];
}

- (void)openFillTextView:(UIView *)view {
    [self.fieldTextView resignFirstResponder];
    UILabel *lable = (UILabel *)view;
    NKAlertView *alert = [[NKAlertView alloc] init];
    MHFillTextContentView *textView = [[MHFillTextContentView alloc] initWithFrame:CGRectMake(0, 0, 300, 180)];
    alert.contentView = textView;
    XYWeakSelf;
    textView.callBack = ^(NSString * _Nonnull qianming) {
        weakSelf.qianming = qianming;
        lable.text = qianming;
    };
    alert.type = NKAlertViewTypeDef;
    [alert show];
}

- (void)openCamcon{
    XYWeakSelf;
   LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"" cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
       NSLog(@"%ld",buttonIndex);
       switch (buttonIndex) {
           case 0:
               
               break;
           case 1:
                [weakSelf presentImageView:1];
               break;
           case 2:
                [weakSelf presentImageView:2];
               break;
           default:
               break;
       }
   } otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    actionSheet.titleLabel.textAlignment = NSTextAlignmentLeft;
    actionSheet.buttonFont = FONT_14;
    actionSheet.buttonColor = Color_2A2A2A;
    actionSheet.cancelButtonColor = kBlackColor;
    actionSheet.cancelButtonFont = 16;
   [actionSheet show];
}
#pragma mark  - Get
- (UIButton *)goPayBtn {
    if (!_goPayBtn) {
        _goPayBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 25;
            view.backgroundColor = kTipBlueColor;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"提交" forState:UIControlStateNormal];
            [view.titleLabel setFont:STFont(17)];
            view.tag = 13;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _goPayBtn;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"昵称：",@"个性签名：",@"性别：",@"出生年份："];
    }
    return _titleArray;
}

- (NSArray *)titleArray1 {
    if (!_titleArray1) {
        _titleArray1 = @[@"学历：",@"行业：",@"职业："];
    }
    return _titleArray1;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self addChildViewController:tvc];
        _tableView = tvc.tableView;
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.titleArray1.count;;
    } else {
        return self.titleArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = Color_2A2A2A;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section==0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.titleArray[indexPath.row]];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.titleArray1[indexPath.row]];
    }
    if (indexPath.row == 0 && indexPath.section == 0) {
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 100+indexPath.row) {
                [view removeFromSuperview];
            }
        }
        UITextField *titleTextField = [UITextField new];
        titleTextField.font = FONT_14;
        titleTextField.textAlignment = NSTextAlignmentLeft;
        titleTextField.textColor = COLOR_999999;
        [titleTextField setValue:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        titleTextField.userInteractionEnabled = YES;
        [cell.contentView addSubview:titleTextField];
        titleTextField.frame = CGRectMake(101, 10, 194, 30);
        titleTextField.tag = 100+indexPath.row;
        [titleTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        NSString *placeString = [self.model.nickname isNotBlank] ? self.model.nickname :@"请输入昵称";
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:placeString];
        [textColor addAttribute:NSForegroundColorAttributeName
                          value:COLOR_999999
                          range:[placeString rangeOfString:placeString]];
        titleTextField.attributedPlaceholder = textColor;
        self.fieldTextView = titleTextField;
    } else if (indexPath.row == 1 && indexPath.section == 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101, 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_14;
        label.text = [self.model.person_sign isNotBlank]?self.model.person_sign:@"点击设置";
        label.textAlignment = NSTextAlignmentLeft;
        label.userInteractionEnabled = YES;
        [cell.contentView addSubview:label];
        XYWeakSelf;
        [label addTapGestureWithBlock:^(UIView *gestureView) {
            [weakSelf openFillTextView:gestureView];
        }];
        label.tag = 110+indexPath.row;
    } else if (indexPath.row == 2 && indexPath.section == 0) {
        UIButton *chongzhiBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setImage:IMAGE_NAME(@"未选中") forState:UIControlStateNormal];
            [view setImage:IMAGE_NAME(@"选中") forState:UIControlStateSelected];
            view.tag = 3;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
        [cell.contentView addSubview:chongzhiBtn];
        [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(101);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101+16+15, 15, 27, 20)];
        label.textColor = COLOR_999999;
        label.font = FONT_14;
        label.text = @"男";
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
        self.sexStr = self.model.sex == 1 ? @"男":@"女";
        UIButton *chongzhiBtn1 = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setImage:IMAGE_NAME(@"未选中") forState:UIControlStateNormal];
            [view setImage:IMAGE_NAME(@"选中") forState:UIControlStateSelected];
            view.tag = 4;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
        [cell.contentView addSubview:chongzhiBtn1];
        [chongzhiBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(199);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.centerY.mas_equalTo(cell.contentView).mas_offset(0);
        }];
        UILabel *titlelab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_999999;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"女";
            view ;
        });
        if (self.model.sex == 1) {
            chongzhiBtn.selected = YES;
            chongzhiBtn1.selected = NO;
        } else {
            chongzhiBtn1.selected = YES;
            chongzhiBtn.selected = NO;
        }
        [cell.contentView addSubview:titlelab1];
        [titlelab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(199+16+13);
            make.size.mas_equalTo(CGSizeMake(117, 20));
            make.top.mas_equalTo(cell.contentView).mas_offset(15);
        }];
        
    }else if (indexPath.row == 3 && indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101, 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_14;
        label.text = @"点击设置";
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
        label.userInteractionEnabled = YES;
         XYWeakSelf;
         [label addTapGestureWithBlock:^(UIView *gestureView) {
             [weakSelf openTimeSelectVie:gestureView];
         }];
    }else if (indexPath.row == 0 && indexPath.section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101, 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_14;
        label.text = [self.model.school isNotBlank]?self.model.school:@"点击设置";
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
        label.userInteractionEnabled = YES;
         XYWeakSelf;
         [label addTapGestureWithBlock:^(UIView *gestureView) {
             [weakSelf openSeletmenuView:gestureView andNumber:indexPath.row];
         }];
    }else if (indexPath.row == 1 && indexPath.section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101, 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_14;
        label.text = [self.model.profession isNotBlank]?self.model.profession: @"点击设置";
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
        label.userInteractionEnabled = YES;
         XYWeakSelf;
         [label addTapGestureWithBlock:^(UIView *gestureView) {
             [weakSelf openSeletmenuView:gestureView andNumber:indexPath.row];
         }];
    }else if (indexPath.row == 2 && indexPath.section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(101, 10, Window_W-kWidth(94)-27, 30)];
        label.textColor = COLOR_999999;
        label.font = FONT_14;
        label.text = [self.model.work isNotBlank] ?self.model.work: @"点击设置";
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        label.tag = 110+indexPath.row;
        label.userInteractionEnabled = YES;
         XYWeakSelf;
         [label addTapGestureWithBlock:^(UIView *gestureView) {
             [weakSelf openSeletmenuView:gestureView andNumber:indexPath.row];
         }];
    }
    return cell;
}
- (void)textChange:(UITextField *)textFiled {
    self.nick = textFiled.text;
}
- (void)BtnClicked:(UIButton *)button {
    button.selected = !button.isSelected;
    UIView *cell = (UIView *)button.superview;
    if (button.tag == 13) {//提交
        XYWeakSelf;
        if ([self.headUrl isNotBlank] && [self.nick isNotBlank] && [self.sexStr isNotBlank] && [self.qianming isNotBlank] && [self.school isNotBlank] && [self.profession isNotBlank] && [self.nianString isNotBlank] ) {
            NSDictionary *params = @{@"avatar":self.headUrl,
                                     @"nickname":self.nick,
                                     @"sex":[self.sexStr isEqualToString:@"男"]?@1:@2,
                                     @"person_sign":self.qianming,
                                     @"school":self.school,
                                     @"profession":self.profession,
                                     @"birthday":self.nianString,
                                     @"real_name":@"",
                                     @"card_id":@"",
                                     
            };
            [[STHttpResquest sharedManager] requestWithMethod:POST
                                                     WithPath:@"user/edit"
                                                   WithParams:params
                                             WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                NSInteger status = [[dic objectForKey:@"status"] integerValue];
                NSString *msg = [[dic objectForKey:@"msg"] description];
                if(status == 200){
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                    [kNotificationCenter postNotificationName:@"refreshMyInfo" object:nil];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else {
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                }
            } WithFailurBlock:^(NSError * _Nonnull error) {
            }];
        } else {
            [MBManager showBriefAlert:@"请填写全部信息！"];
        }
        
    } else if (button.tag == 3) {
        self.sexStr = @"男";
        button.selected = YES;
        UIButton *otherBtn = [cell viewWithTag:4];
        otherBtn.selected = NO;
    } else {
        self.sexStr = @"女";
        button.selected = YES;
        UIButton *otherBtn = [cell viewWithTag:3];
        otherBtn.selected = NO;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    if (section == 0) {
       view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)saveImageMethod{
    UIImage* image = IMAGE_NAME(@"");
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        [MBManager showBriefAlert:@"保存成功"];
    }];
}

- (void)presentImageView:(NSInteger )buttonIndex {
    if (buttonIndex == 1) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];

        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
            [controller setDelegate:self];
            [self presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
        }
    } else if(buttonIndex == 2){
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

#pragma mark - 1.STPhotoKitDelegate的委托

- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    NSLog(@"image:%@",resultImage);
    self.headImage.image = resultImage;
//    [[NSUserDefaults standardUserDefaults] setObject:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJncmFjZXVpLnFoengueHl6IiwiYXVkIjoiZ3JhY2V1aS5xaHp4Lnh5eiIsImlhdCI6MTU4NzUzODQ5NCwibmJmIjoxNTg3NTM4NDk0LCJleHAiOjE1OTU0MDA4OTQsImp0aSI6eyJpZCI6MSwidHlwZSI6InVzZXIifX0.dAhjltYVotE09e0l5ldtH8xoi_h1AbpRbbuaYaoFt80" forKey:@"token"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%@",[kUserDefaults objectForKey:@"token"]);
    [[STHttpResquest sharedManager] POST:@"api/upload/image"
                              parameters:@{}
               constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImagePNGRepresentation(resultImage);
        //上传的参数(上传图片，以文件流的格式
        [formData appendPartWithFileData:data
                                     name:@"file"
                                 fileName:@"gauge.png"
                                 mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"resp:%@",responseObject);
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        NSString *msg = [[responseObject objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            self.headUrl = [dict objectForKey:@"url"];
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.description);
    }];
}

#pragma mark - 2.UIImagePickerController的委托

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];

        [photoVC setSizeClip:CGSizeMake(300,
                                        300)];

        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self.fieldTextView resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.fieldTextView resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
