//
//  MHAnswerViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHAnswerViewController.h"
#import "MHPactioceModel.h"

#import "MyExamTableViewCell.h"
#import "MyExamHeaderView.h"
#import "MyExamFooterView.h"
#import "MultiSelectArrayModel.h"
#import "TTQuestionListModel.h"
#import "MHCheckAnswerModel.h"

#import "MHDaTiKaViewController.h"
@interface MHAnswerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSDictionary *item;
@property (strong, nonatomic) NSMutableArray *pactice_list;
@property (strong, nonatomic) NSDictionary * testDic;


@property (strong, nonatomic) MyExamHeaderView *myExamHeaderView;

@property (strong, nonatomic) MyExamFooterView *myExamFooterView;

@property (strong, nonatomic) NSIndexPath      *currentSelectIndex;

@property (strong, nonatomic) NSMutableArray   *sumArray;

@property (strong, nonatomic) NSMutableArray   *indexPathArray;

@property (strong, nonatomic) NSMutableArray   *myselectArray;
/** 缓存cell高度的数组 */
@property (nonatomic,strong) NSMutableArray *heightArray;

@property (strong, nonatomic) NSString    *seleIndexStr;

@property (strong, nonatomic) NSIndexPath *seleIndexPath;

@property (assign, nonatomic) NSInteger index;

@property (nonatomic,strong) MHPactioceModel *model;
@property (nonatomic,strong) MHCheckAnswerModel *checkModel;

@property (strong, nonatomic) NSMutableArray *selectArr;
@property (assign, nonatomic) BOOL isJiexi;

@property (strong, nonatomic) NSMutableArray * myAnswerArray;//结果数组

@property (strong, nonatomic) NSMutableArray    *relustArray;
@property (nonatomic,assign) NSInteger paperid;
@property (assign, nonatomic) NSInteger arrayIndex;
@property (strong, nonatomic) NSMutableArray *chooseArray;

@end

@implementation MHAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT_12];
        [btn setTitle:@"答题卡" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavWhiteBarWithtitle:self.titleStr andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.right.mas_equalTo(self.view).mas_offset(-12);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.myExamHeaderView;
    self.myExamFooterView.frame = CGRectMake(0, 0, Window_W, 180);
    self.tableView.tableFooterView = self.myExamFooterView;
    self.tableView.tableFooterView.hidden = YES;
    self.arrayIndex = 0;
    [self initData];
}

- (void)rightBtAction:(UIButton *)button {
    MHDaTiKaViewController *vc = [MHDaTiKaViewController new];
    vc.relutsArray = self.relustArray;
    vc.questArray = self.indexPathArray;
    vc.shiTiID =STRING_FROM_INTAGER([self.testDic[@"id"] integerValue]);
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData {
//    [self relustArray];
    [self sumArray];
    [self myselectArray];
//    NSString *url = [NSString stringWithFormat:@"course/pactice_list/%@",self.AnswerId];
    NSString *url = [NSString stringWithFormat:@"course/pactice_list/%@",@"10"];
    XYWeakSelf;
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:url
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *data = dic[@"data"];
            weakSelf.item = data[@"item"];
            weakSelf.pactice_list = data[@"pactice_list"];
            [weakSelf indexPathArray];
            [weakSelf relustArray];
            weakSelf.testDic = data[@"test"];
            MHPactioceModel *model = [MHPactioceModel mj_objectWithKeyValues:weakSelf.pactice_list[weakSelf.arrayIndex]];
            weakSelf.model = model;
            NSString *string = [NSString stringWithFormat:@"%@",model.question];
            
//            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"1、"];
//            [str1 appendAttributedString:attrStr];
//
            // 图文混排
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
            // 1 - 你好
            NSAttributedString *first = [[NSAttributedString alloc] initWithString:@"1、"];
            [attributedText appendAttributedString:first];
            // 2 - 图片
            // 带有图片的附件对象
//            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//            attachment.image = [UIImage imageNamed:@"多选题"];
//            attachment.bounds = CGRectMake(0, - ((model.headViewHeight - 16 - 20) * 0.5 - 5), 40, 16);
//            // 将附件对象包装成一个属性文字
//            NSAttributedString *second = [NSAttributedString attributedStringWithAttachment:attachment];
//            [attributedText appendAttributedString:second];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[string
                                                                                         dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            [attributedText appendAttributedString:attrStr];

            [weakSelf.myExamHeaderView.subjectLabel setAttributedText:attributedText];
//            if (model.type == 1) {
//                weakSelf.myExamHeaderView.subjectTypeLabel.text = @"单选题";
//            } else {
//                weakSelf.myExamHeaderView.subjectTypeLabel.text = @"多选题";
//            }
//            NSString *title = @"1、";
//            weakSelf.myExamHeaderView.titleLabel.text = title;
//            CGFloat w = [title widthWithFont:FONT_10 constrainedToHeight:20];
//            [weakSelf.myExamHeaderView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(w+3);
//            }];
            weakSelf.myExamHeaderView.height = model.headViewHeight;
            weakSelf.tableView.tableFooterView.hidden = YES;
            [weakSelf.tableView reloadData];
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setIsJiexi:(BOOL)isJiexi {
    _isJiexi = isJiexi;
}

- (void)setSelectArr:(NSMutableArray *)selectArr {
    _selectArr = selectArr;
}

- (void)setIndex:(NSInteger)index {
    _myExamHeaderView.titleLabel.text = [NSString stringWithFormat:@"第%ld题",(long)index];
}

- (void)setSeleIndexStr:(NSString *)seleIndexStr {
    _seleIndexStr = seleIndexStr;
}

- (void)setSeleIndexPath:(NSIndexPath *)seleIndexPath {

    _seleIndexPath = seleIndexPath;
    _currentSelectIndex = _seleIndexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *data = self.model.answer_all.mj_JSONObject;
    NSLog(@"%@",data);
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *string   = @"UITableViewCell";
    MyExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[MyExamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    switch (indexPath.row) {
        case 0:{
            [cell.selectedBtn setTitle:@"A" forState:UIControlStateNormal];
            [cell.selectedBtn setImage:IMAGE_NAME(@"A") forState:UIControlStateNormal];
            cell.selectedBtn.tag = 1;
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.answer_all.A
                                                                                          dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.contentLab.attributedText = attrStr;
    }
            break;
        case 1:{
            [cell.selectedBtn setTitle:@"B" forState:UIControlStateNormal];
            [cell.selectedBtn setImage:IMAGE_NAME(@"B") forState:UIControlStateNormal];
            cell.selectedBtn.tag = 2;
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.answer_all.B
                                                                                          dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.contentLab.attributedText = attrStr;
        }
            break;
        case 2:{
            [cell.selectedBtn setTitle:@"C" forState:UIControlStateNormal];
            [cell.selectedBtn setImage:IMAGE_NAME(@"C") forState:UIControlStateNormal];
            cell.selectedBtn.tag = 4;
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.answer_all.C
                                                                                          dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.contentLab.attributedText = attrStr;
        }
            break;
        case 3:{
            [cell.selectedBtn setTitle:@"D" forState:UIControlStateNormal];
            [cell.selectedBtn setImage:IMAGE_NAME(@"D") forState:UIControlStateNormal];
            cell.selectedBtn.tag = 8;
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.answer_all.D
                                                                                          dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.contentLab.attributedText = attrStr;
        }
            break;
        case 4:{
            [cell.selectedBtn setTitle:@"E" forState:UIControlStateNormal];
            [cell.selectedBtn setImage:IMAGE_NAME(@"E") forState:UIControlStateNormal];
            cell.selectedBtn.tag = 16;
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.answer_all.E
                                                                                          dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.contentLab.attributedText = attrStr;
        }
            break;
        default:
            break;
    }
    if (self.isJiexi) {
        cell.userInteractionEnabled = NO;
//        if (self.model.type == 1) {
            if ([cell.selectedBtn.titleLabel.text isEqualToString:self.checkModel.answer]) {
                [cell.selectedBtn setImage:IMAGE_NAME(@"选中") forState:UIControlStateNormal];
            } else if ([cell.selectedBtn.titleLabel.text isEqualToString:self.checkModel.user_choose] ){
                [cell.selectedBtn setImage:IMAGE_NAME(@"错误答案") forState:UIControlStateNormal];
            }
//        } else {
//           NSArray *arr = [self.checkModel.answer componentsSeparatedByString:@","];
//        }
    } else {
        cell.userInteractionEnabled = YES;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view         = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (self.heightArray.count > indexPath.row) {
        // 如果有缓存的高度，取出缓存高度
        height = [self.heightArray[indexPath.row] floatValue];;
    }else{
        //计算html字符串高度
        NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[self.model.answer_all.A dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
         
        [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
         
        CGSize textSize = [htmlString boundingRectWithSize:(CGSize){Window_W-20-18-24-20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        height = textSize.height;
        [self.heightArray addObject:[NSNumber numberWithDouble:height]];
    }
    if (height>40) {
        return height;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.model.type  == 1 ) {//单选
        [self check_quest:indexPath];
    } else if (self.model.type == 2){//多选
        [self check_quest:indexPath];
    }
//    if ([self.indexPathArray containsObject:indexPath]) {
//        [self.indexPathArray removeObject:indexPath];
//    }
//    [self.indexPathArray addObject:indexPath];
//    if ([self.indexPathArray containsObject:[NSNumber numberWithInteger:self.arrayIndex]]) {
//        [self.indexPathArray removeObject:[NSNumber numberWithInteger:self.arrayIndex]];
//    }
//    [self.indexPathArray addObject:[NSNumber numberWithInteger:self.arrayIndex]];
    [self.indexPathArray replaceObjectAtIndex:self.arrayIndex withObject:indexPath];
    MHPactioceModel *model = self.relustArray[indexPath.row];
    MyExamTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    model.choose = cell.selectedBtn.titleLabel.text;
    [self.relustArray replaceObjectAtIndex:indexPath.row withObject:model];
}
- (void)check_quest:(NSIndexPath *)path {

    MyExamTableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    NSString *url = [NSString stringWithFormat:@"course/check_quest_answer/%ld",self.model.mhid];
    XYWeakSelf;
    NSDictionary *params = @{@"test_id":@([self.testDic[@"id"] intValue]),
                             @"choose":cell.selectedBtn.titleLabel.text,
    };
    [[STHttpResquest sharedManager] requestWithMethod:POST
                                             WithPath:url
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *data = dic[@"data"];
            NSString *jiexi = data[@"answer_explain"];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[jiexi
                                                                                          dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            weakSelf.myExamFooterView.analysisLabel.attributedText = attrStr;
            weakSelf.myExamFooterView.answerLabel.text = msg;
            weakSelf.myExamFooterView.frame = CGRectMake(0, 0, Window_W, 180);
            weakSelf.tableView.tableFooterView.hidden = NO;
            weakSelf.isJiexi = YES;
            weakSelf.checkModel = [MHCheckAnswerModel mj_objectWithKeyValues:data];
            
            if ([weakSelf.checkModel.user_choose isEqualToString:weakSelf.checkModel.answer]) {
                weakSelf.myExamFooterView.stateImage.image = IMAGE_NAME(@"感叹");
                weakSelf.myExamFooterView.answerLabel.textColor = kMainColor;
                NSString *title = @"恭喜，答对啦";
                weakSelf.myExamFooterView.answerLabel.text = title;
                CGFloat W = [title widthWithFont:FONT_12 constrainedToHeight:14];
                [weakSelf.myExamFooterView.answerLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(W+20);
                }];
            } else {
                weakSelf.myExamFooterView.stateImage.image = IMAGE_NAME(@"感叹-1");
                weakSelf.myExamFooterView.answerLabel.textColor = kTipYellowCOLOR;
                NSString *title =  @"答错了，再接再厉哦";
                weakSelf.myExamFooterView.answerLabel.text = title;
                CGFloat W = [title widthWithFont:FONT_12 constrainedToHeight:14];
                [weakSelf.myExamFooterView.answerLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(W+20);
                }];
            }
            [weakSelf.tableView reloadData];
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (NSMutableArray *)chooseArray {
    if (!_chooseArray) {
        _chooseArray = [[NSMutableArray alloc] init];
    }
    return _chooseArray;
}
- (MyExamHeaderView *)myExamHeaderView {
    if (!_myExamHeaderView) {
        _myExamHeaderView = [[MyExamHeaderView alloc]init];
    }
    return _myExamHeaderView;
}

- (MyExamFooterView *)myExamFooterView {
    if (!_myExamFooterView) {
        _myExamFooterView = [[MyExamFooterView alloc]init];
        XYWeakSelf;
        _myExamFooterView.nextAnswer = ^{
            [weakSelf nextAnswer];
        };
    }
    return _myExamFooterView;
}
- (void)nextAnswer {
    if (self.arrayIndex >=self.pactice_list.count) {
        [MBManager showBriefAlert:@"已到最后一题了！"];
        return;
    }
    self.arrayIndex ++;
    self.model = [MHPactioceModel mj_objectWithKeyValues:self.pactice_list[self.arrayIndex]];
    self.isJiexi = NO;
    self.tableView.tableFooterView.hidden = YES;


    NSString *title =  [NSString stringWithFormat:@"%ld、",self.arrayIndex];;
//    self.myExamHeaderView.titleLabel.text = title;
//    CGFloat w = [title widthWithFont:FONT_10 constrainedToHeight:20];
//    [self.myExamHeaderView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(w+3);
//    }];
    // 图文混排
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 1 - 你好
    NSAttributedString *first = [[NSAttributedString alloc] initWithString:title];
    [attributedText appendAttributedString:first];
    // 2 - 图片
    // 带有图片的附件对象
//    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//    attachment.image = [UIImage imageNamed:@"多选题"];
////            CGFloat lineH = weakSelf.myExamHeaderView.subjectLabel.font.lineHeight;
//    attachment.bounds = CGRectMake(0, - ((self.model.headViewHeight - 16 - 20) * 0.5 - 5), 40, 16);
//    // 将附件对象包装成一个属性文字
//    NSAttributedString *second = [NSAttributedString attributedStringWithAttachment:attachment];
//    [attributedText appendAttributedString:second];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.question
                                                                                 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attributedText appendAttributedString:attrStr];

    [self.myExamHeaderView.subjectLabel setAttributedText:attributedText];
    if (self.model.type == 1) {
        self.myExamHeaderView.subjectTypeLabel.text = @"单选题";
    } else {
        self.myExamHeaderView.subjectTypeLabel.text = @"多选题";
    }
    self.myExamHeaderView.height = self.model.headViewHeight;
    
    [self.tableView reloadData];
}

- (NSMutableArray *)indexPathArray {
    if (!_indexPathArray) {
        _indexPathArray = [NSMutableArray array];
        for (NSDictionary *dic in self.pactice_list) {
            MHPactioceModel *model = [MHPactioceModel mj_objectWithKeyValues:dic];
            [_indexPathArray addObject:model];
        }
    }
    return _indexPathArray;
}

- (NSMutableArray *)sumArray {
    if (!_sumArray) {
        _sumArray = [NSMutableArray array];
    }
    return _sumArray;
}

- (NSMutableArray *)myAnswerArray {
    if (!_myAnswerArray) {
        _myAnswerArray = [[NSMutableArray alloc] init];
    }
    return _myAnswerArray;
}

- (NSMutableArray *)myselectArray {
    if (!_myselectArray) {
        _myselectArray = [[NSMutableArray alloc] init];
    }
    return _myselectArray;
}
- (NSMutableArray *)relustArray {
    if (!_relustArray) {
        _relustArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in self.pactice_list) {
            MHPactioceModel *model = [MHPactioceModel mj_objectWithKeyValues:dic];
            [_relustArray addObject:model];
        }
    }
    return _relustArray;
}

 - (NSMutableArray *)heightArray{
    if (_heightArray == nil) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
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
