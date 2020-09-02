//
//  QutestCollectionViewCell.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/8.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "QutestCollectionViewCell.h"

#import "MyExamTableViewCell.h"

#import "MyExamHeaderView.h"
#import "MyExamFooterView.h"

#import "MultiSelectArrayModel.h"
#import "TTQuestionListModel.h"
@interface QutestCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MyExamHeaderView *myExamHeaderView;

@property (strong, nonatomic) UITableView      *tableView;

@property (strong, nonatomic) MyExamFooterView *myExamFooterView;

@property (strong, nonatomic) NSIndexPath      *currentSelectIndex;

@property (strong, nonatomic) NSMutableArray  *dataSoureArray;

@property (strong, nonatomic) NSMutableArray   *sumArray;

@property (strong, nonatomic) NSMutableArray   *indexPathArray;

@property (strong, nonatomic) NSMutableArray   *myselectArray;
/** 缓存cell高度的数组 */
@property (nonatomic,strong) NSMutableArray *heightArray;





@end

@implementation QutestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {

    [self.contentView addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.right.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    _tableView.tableHeaderView = self.myExamHeaderView;
    _tableView.tableFooterView = self.myExamFooterView;
}

- (void)initData {
    [self indexPathArray];
    [self sumArray];
    [self myselectArray];
//    if ([self.model.question containsString:@"&"]) {
//        NSString *str = @"	<font color=\"#6c6c6c\">满20减5 满40减15，还剩<font color=\"#ff9147\">113天";
//        NSString *str = @"罗梦槐，您好！您的借款项目【0903.按月3.02】债权转让已经完成，当前持有信息如下：<table  border='1' cellpadding='0' width='80%;' cellspacing='0'><tr><td align='center'>用户名</td><td align='center'>债权持有金额</td></tr><tr><td align='center'>13944831072</td><td align='center'>2200.00</td></tr><tr><td align='center'>13944831077</td><td align='center'>600.00</td></tr><tr><td align='center'>13944831078</td><td align='center'>200.00</td></tr><tr><td align='center'>13944831078</td><td align='center'>200.00</td></tr><tr><td align='center'>13944831078</td><td align='center'>1800.00</td></tr><tr><td align='center'>13944831078</td><td align='center'>800.00</td></tr><tr><td align='center'>13944831079</td><td align='center'>400.00</td></tr></table>";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.question
                                                                                 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [_myExamHeaderView.subjectLabel setAttributedText:attrStr];
    _myExamHeaderView.height = self.model.headViewHeight;
    if (self.isJiexi) {
        _myExamFooterView.answerLabel.text = [NSString stringWithFormat:@"正确答案：%@",_model.answer];
        _myExamFooterView.analysisLabel.text = [NSString stringWithFormat:@"你的答案：%@",_model.uanswer];
    }
    
}

- (void)setModel:(TTQuestionModel *)model {
    _model = model;
    if (!_model.headViewHeight) {
        //计算html字符串高度
        NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[_model.question dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    
        [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
    
        CGSize textSize = [htmlString boundingRectWithSize:(CGSize){Window_W-20-15, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
        _model.headViewHeight =  textSize.height+34+20;
    }
    [self initData];
    self.tableView.hidden = NO;
    [self.sendView removeFromSuperview];
    [self.dataSoureArray removeAllObjects];
    if ([model.type integerValue] == 2) {//单选题
        _myExamHeaderView.subjectTypeLabel.text = @"(单选题)";
//        _dataSoureArray = _model.items.mutableCopy;
        for (int i = 0; i < model.items.count; i++) {
            TTQuestionListModel *Qmodel = [TTQuestionListModel new];
            Qmodel.type = 2;
            Qmodel.desStr = model.items[i];
            Qmodel.uanswer = model.uanswer;
            Qmodel.answer = model.answer;
            [_dataSoureArray addObject:Qmodel];
        }
    } else if([model.type integerValue] == 3) {//多选题
        _myExamHeaderView.subjectTypeLabel.text = @"(多选题)";
//        _dataSoureArray = _model.items.mutableCopy;
        for (int i = 0; i < model.items.count; i++) {
            TTQuestionListModel *Qmodel = [TTQuestionListModel new];
            Qmodel.type = 3;
            Qmodel.desStr = model.items[i];
            Qmodel.uanswer = model.uanswer;
            Qmodel.answer = model.answer;
            [_dataSoureArray addObject:Qmodel];
        }
    } else if ([model.type integerValue] == 4){
        //填空题
        _myExamHeaderView.subjectTypeLabel.text = @"(填空题)";
        TTQuestionListModel *Qmodel = [TTQuestionListModel new];
          Qmodel.type = 4;
          Qmodel.desStr = @"";
          Qmodel.uanswer = model.uanswer;
          Qmodel.answer = model.answer;
          [_dataSoureArray addObject:Qmodel];
    } else if([model.type integerValue] == 1){
        //判断题
        _myExamHeaderView.subjectTypeLabel.text = @"(判断题)";
        NSArray *arr = @[@"正确",@"错误"];
        for (int i = 0; i < arr.count; i++) {
            TTQuestionListModel *Qmodel = [TTQuestionListModel new];
            Qmodel.type = 1;
            Qmodel.desStr = arr[i];
            if ([model.uanswer isEqualToString:@"1"]) {
                Qmodel.uanswer = @"A";
            } else {
                Qmodel.uanswer = @"B";
            }
            if ([model.answer isEqualToString:@"1"]) {
                Qmodel.answer = @"A";
            } else {
                Qmodel.answer = @"B";
            }
            [_dataSoureArray addObject:Qmodel];
        }
        if (self.isJiexi) {
            if ([model.answer isEqualToString:@"1"]) {
                _myExamFooterView.answerLabel.text = [NSString stringWithFormat:@"正确答案：A"];
            } else {
                _myExamFooterView.answerLabel.text = [NSString stringWithFormat:@"正确答案：B"];
            }
            if ([model.uanswer isEqualToString:@"1"]) {
                _myExamFooterView.analysisLabel.text = [NSString stringWithFormat:@"你的答案：A"];
            } else {
                _myExamFooterView.analysisLabel.text = [NSString stringWithFormat:@"你的答案：B"];
            }
        }
    } else {
        self.tableView.hidden = YES;
        [self.contentView addSubview:self.sendView];
        [self.sendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(10);
            make.bottom.right.mas_equalTo(self.contentView).mas_offset(-10);
        }];
        self.sendView.categoryQuestionList = self.selectArr;
        self.sendView.reslutArray = self.relustArray;
        self.sendView.paperid = self.paperid;
        self.sendView.questListModel = self.listModel;
        [self.sendView.collectionView reloadData];
    }
//    [_tableView reloadData];
}
- (void)setIsJiexi:(BOOL)isJiexi {
    _isJiexi = isJiexi;
    if (!_isJiexi) {
        self.tableView.tableFooterView = nil;
    }

}
- (void)setSelectArr:(NSMutableArray *)selectArr {
    _selectArr = selectArr;
    if (self.sendView) {
        self.sendView.categoryQuestionList = self.selectArr.mutableCopy;
        self.sendView.reslutArray = self.relustArray.mutableCopy;
        self.sendView.paperid = self.paperid;
        self.sendView.questListModel = self.listModel;
        [self.sendView.collectionView reloadData];
    }
}


- (void)setIndex:(NSInteger)index {
    _myExamHeaderView.titleLabel.text = [NSString stringWithFormat:@"第%ld题",(long)index];
//    [_tableView reloadData];
}

- (void)setSeleIndexStr:(NSString *)seleIndexStr {

    _seleIndexStr = seleIndexStr;
     if (_indexPathArray.count > 0) [_indexPathArray removeAllObjects];
     
     [_indexPathArray addObjectsFromArray:[MultiSelectArrayModel MultiSelectArray:[_seleIndexStr integerValue]]];
    
}

- (void)setSeleIndexPath:(NSIndexPath *)seleIndexPath {

    _seleIndexPath = seleIndexPath;
    _currentSelectIndex = _seleIndexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *string   = @"UITableViewCell";
    
    MyExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        
        cell = [[MyExamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }

    cell.Qmodel = self.dataSoureArray[indexPath.row];
    
    switch (indexPath.row) {
            
        case 0:
            [cell.selectedBtn setTitle:@"A" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 1;
            break;
        case 1:
            [cell.selectedBtn setTitle:@"B" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 2;
            break;
        case 2:
            [cell.selectedBtn setTitle:@"C" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 4;
            break;
        case 3:
            [cell.selectedBtn setTitle:@"D" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 8;
            break;
        case 4:
            [cell.selectedBtn setTitle:@"E" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 16;
            break;
        case 5:
            [cell.selectedBtn setTitle:@"F" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 32;
            break;
        default:
            break;
    }
    if (self.isJiexi) {
        cell.userInteractionEnabled = NO;
        
//        switch (indexPath.row) {
//                
//            case 0:
//                if ([cell.Qmodel.answer isEqualToString:@"A"]) {
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0x09bb07);
//                } else if ([cell.Qmodel.uanswer isEqualToString:@"A"]){
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0xf76260);
//                }
//                break;
//            case 1:
//                if ([cell.Qmodel.answer isEqualToString:@"B"]) {
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0x09bb07);
//                } else if ([cell.Qmodel.uanswer isEqualToString:@"B"]){
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0xf76260);
//                }
//                break;
//            case 2:
//                if ([cell.Qmodel.answer isEqualToString:@"C"]) {
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0x09bb07);
//                } else if ([cell.Qmodel.uanswer isEqualToString:@"C"]){
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0xf76260);
//                }
//                
//                break;
//            case 3:
//                if ([cell.Qmodel.answer isEqualToString:@"D"]) {
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0x09bb07);
//                } else if ([cell.Qmodel.uanswer isEqualToString:@"D"]){
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0xf76260);
//                }
//                break;
//            case 4:
//                if ([cell.Qmodel.answer isEqualToString:@"E"]) {
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0x09bb07);
//                } else if ([cell.Qmodel.uanswer isEqualToString:@"E"]){
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0xf76260);
//                }
//                break;
//            case 5:
//                if ([cell.Qmodel.answer isEqualToString:@"F"]) {
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0x09bb07);
//                } else if ([cell.Qmodel.uanswer isEqualToString:@"F"]){
//                    [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//                    cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//                    cell.contentLab.textColor = UIColorHex(0xf76260);
//                }
//                break;
//            default:
//                break;
//        }
//        if ([cell.Qmodel.answer isEqualToString:@"A"]) {
//            [cell.selectedBtn setImage:IMAGE_NAME(@"success-pic") forState:UIControlStateNormal];;
//            cell.contentCustomView.layer.borderColor =UIColorHex(0x09bb07).CGColor;
//            cell.contentLab.textColor = UIColorHex(0x09bb07);
//        } else if (indexPath.row == 1){
//            [cell.selectedBtn setImage:IMAGE_NAME(@"error-pic") forState:UIControlStateNormal];;
//            cell.contentCustomView.layer.borderColor = UIColorHex(0xf76260).CGColor;
//            cell.contentLab.textColor = UIColorHex(0xf76260);
//        }
    }
//    if ([self.model.type integerValue] ==2 || [self.model.type integerValue] == 1) {
//        if (cell.selectedBtn.tag == [_seleIndexStr integerValue]) {
//            cell.selectedBtn.selected = YES;
//            cell.contentCustomView.layer.borderColor = cell.selectedBtn.selected ? UIColorHex(0xfba937).CGColor : COLOR_e5e5e5.CGColor;
//            cell.contentLab.textColor = cell.selectedBtn.selected ? UIColorHex(0xfba937) : UIColorHex(0x505050);
//        }
//    } else if ([self.model.type integerValue] == 3){
//        if (_indexPathArray.count > 0){
//            cell.selectedBtn.selected = [_indexPathArray[indexPath.row] boolValue];
//            cell.contentCustomView.layer.borderColor = cell.selectedBtn.selected ? UIColorHex(0xfba937).CGColor : COLOR_e5e5e5.CGColor;
//            cell.contentLab.textColor = cell.selectedBtn.selected ? UIColorHex(0xfba937) : UIColorHex(0x505050);
//        }
//    }


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
        NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[[(TTQuestionListModel *)self.dataSoureArray[indexPath.row] desStr] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
         
        [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
         
        CGSize textSize = [htmlString boundingRectWithSize:(CGSize){Window_W-20-18-24-20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        height = textSize.height;
        [self.heightArray addObject:[NSNumber numberWithDouble:height]];
    }
    if (height>50) {
        return height;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.model.type integerValue] == 2 || [self.model.type integerValue] == 1) {
        if (_currentSelectIndex != nil && _currentSelectIndex != indexPath) {
            MyExamTableViewCell  *cell = [tableView cellForRowAtIndexPath:_currentSelectIndex];
            cell.selectedBtn.selected  = NO;
            cell.contentCustomView.layer.borderColor = cell.selectedBtn.selected ? UIColorHex(0xfba937).CGColor : COLOR_e5e5e5.CGColor;
            cell.contentLab.textColor = cell.selectedBtn.selected ? UIColorHex(0xfba937) : UIColorHex(0x505050);
        }
        MyExamTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedBtn.selected = !cell.selectedBtn.selected;
        cell.contentCustomView.layer.borderColor = cell.selectedBtn.selected ? UIColorHex(0xfba937).CGColor : COLOR_e5e5e5.CGColor;
        cell.contentLab.textColor = cell.selectedBtn.selected ? UIColorHex(0xfba937) : UIColorHex(0x505050);
        _currentSelectIndex = indexPath;
        if (self.SingleSelectBlock) {
            self.SingleSelectBlock(indexPath, cell.selectedBtn.tag);
        }
        if (cell.selectedBtn.selected) {
            self.model.myAnswers = [NSMutableArray arrayWithArray:@[cell.selectedBtn.titleLabel.text]];
        }
    } else if ([self.model.type integerValue]== 3){
        MyExamTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedBtn.selected = !cell.selectedBtn.selected;
        cell.contentCustomView.layer.borderColor = cell.selectedBtn.selected ? UIColorHex(0xfba937).CGColor : COLOR_e5e5e5.CGColor;
        cell.contentLab.textColor = cell.selectedBtn.selected ? UIColorHex(0xfba937) : UIColorHex(0x505050);
        if (![_sumArray containsObject:[NSString stringWithFormat:@"%ld",(long)cell.selectedBtn.tag]]) {
            [_sumArray addObject:[NSString stringWithFormat:@"%ld",(long)cell.selectedBtn.tag]];
        }else {
            [_sumArray removeObject:[NSString stringWithFormat:@"%ld",(long)cell.selectedBtn.tag]];
        }
        if (![_myselectArray containsObject:cell.selectedBtn.titleLabel.text]) {
            [_myselectArray addObject:cell.selectedBtn.titleLabel.text];
        }else {
            [_myselectArray removeObject:cell.selectedBtn.titleLabel.text];
        }
        NSInteger btnTagSum = [[_sumArray valueForKeyPath:@"@sum.floatValue"] integerValue];
        self.model.myAnswers = [NSMutableArray arrayWithArray:_myselectArray];
        if (self.MultiSelectBlock) {
            self.MultiSelectBlock(btnTagSum);
        }
    }
    if (self.blackModel) {
        self.blackModel(self.model);
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.layer.cornerRadius = 4;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.backgroundColor = kWhiteColor.CGColor;
    }
    return _tableView;
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
    }
    return _myExamFooterView;
}

- (NSMutableArray *)dataSoureArray {
    if (!_dataSoureArray) {
        _dataSoureArray = [NSMutableArray array];
    }
    return _dataSoureArray;
}

- (NSMutableArray *)indexPathArray {
    if (!_indexPathArray) {
        _indexPathArray = [NSMutableArray array];
    }
    return _indexPathArray;
}

- (NSMutableArray *)sumArray {
    if (!_sumArray) {
        _sumArray = [NSMutableArray array];
    }
    return _sumArray;
}

- (TTTiKaSendView *)sendView {
    if (!_sendView) {
        _sendView = [[TTTiKaSendView alloc] init];
    }
    return _sendView;
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
    }
    return _relustArray;
}

 - (NSMutableArray *)heightArray{
    if (_heightArray == nil) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
@end
