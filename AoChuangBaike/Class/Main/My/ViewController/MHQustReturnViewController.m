
//
//  MHQustReturnViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHQustReturnViewController.h"
#import "PYPhotosView.h"
#import "TZImagePickerController.h"
@interface MHQustReturnViewController ()<UITextViewDelegate,PYPhotosViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, retain) UITableView *tableview;
//备注
@property(nonatomic,strong) UITextView *noteTextView;

//文字说明
@property(nonatomic,strong) UILabel *placeholderLabel;

@property (nonatomic, weak) PYPhotosView *publishPhotosView;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UITextField *fieldTextView;
@end

@implementation MHQustReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT_13];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"意见反馈" andLeftView:@"" andRightView:@[rightBtn]];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self createUI];
    [self initViews];
    
}
- (void)rightBtAction:(UIButton *)button {
    
}
-(void)createUI{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)initViews{
    
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.frame = CGRectMake(10, -(220+20+((Window_W - 24) - 18)/4), Window_W - 20, 220);
    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _noteTextView.delegate = self;
    _noteTextView.font = FONT_14;
    [self.tableview addSubview:_noteTextView];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 22)];
    _placeholderLabel.textColor = COLOR_HEX_RGB(0x999999);
    _placeholderLabel.font = FONT_18;
    _placeholderLabel.text = @"请描述你遇到的问题";
    [_noteTextView addSubview:_placeholderLabel];
    
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.x = 12;
    publishPhotosView.y = -(((Window_W - 24) - 18)/4+30);
    publishPhotosView.width = Window_W -24;
    publishPhotosView.photoWidth = ((Window_W - 24) - 18)/4;
    publishPhotosView.photoHeight = ((Window_W - 24) - 18)/4;
    publishPhotosView.photoMargin = 8;
    publishPhotosView.delegate = self;
    [self.tableview addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    self.tableview.contentInset = UIEdgeInsetsMake(230+30+((Window_W - 24) - 18)/4, 0, 0, 0);
    self.tableview.contentOffset = CGPointMake(0, -(230+30+((Window_W - 24) - 18)/4));

}
#pragma mark -UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = Color_2A2A2A;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"联系方式"];
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
    NSString *placeString = @"请填写手机号";
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:placeString];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:COLOR_999999
                      range:[placeString rangeOfString:placeString]];
    titleTextField.attributedPlaceholder = textColor;
    self.fieldTextView = titleTextField;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(12,0,Window_W-24,0.5);
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [cell.contentView addSubview:view];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [cell.contentView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).mas_offset(12);
        make.bottom.mas_equalTo(cell.contentView);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(Window_W-24);
    }];
    return cell;
}
- (void)textChange:(UITextField *)textField {
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    UILabel *sectionTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 18, Window_W-24, 20)];
    sectionTitlelabel.textColor = COLOR_666666;
    sectionTitlelabel.font = FONT_14;
    sectionTitlelabel.tag = 100+section;
    sectionTitlelabel.text = @"1234";
    [header addSubview:sectionTitlelabel];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (_noteTextView.text.length == 0){
        [_placeholderLabel setHidden:NO];
    }else{
        [_placeholderLabel setHidden:YES];
    }
    if (_noteTextView.text.length > 512) {
        _noteTextView.text = [_noteTextView.text substringToIndex:512];
    }
    else{
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{

    if (_noteTextView.text.length == 0){
        [_placeholderLabel setHidden:NO];
    }
    else{
        [_placeholderLabel setHidden:YES];
    }
    
}



- (void)submitBtnClicked{
    if (_noteTextView.text.length == 0) {
        return;
    }
    if (_noteTextView.text.length < 10) {
        return;
    }

    if (self.imageArray.count > 0) {

    }else{
        [self sendText];
    }
}

#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）

///发送文字
- (void)sendText {

}

///发送图片
- (void)sendImage:(NSMutableArray *)qualificationFileListArray andType:(NSNumber *)type andIndes:(NSString *)string{

}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(3-self.imageArray.count) delegate:self];
    imagePickerVc.maxImagesCount = 3;
    imagePickerVc.allowPickingOriginalPhoto = NO; //不允许选择原图
    imagePickerVc.allowPickingVideo = NO; //不能选择视频
    imagePickerVc.showSelectBtn = YES; //允许显示选择按钮
    imagePickerVc.allowPickingGif = NO; //不允许选择Gif图
    XYWeakSelf;
    //MARK: 选择照片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imageArray addObjectsFromArray:photos];
            [photosView reloadDataWithImages:weakSelf.imageArray];
        });
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
