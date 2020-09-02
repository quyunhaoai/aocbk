//
//  MHAnswerRelustView.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHAnswerRelustView.h"


//
//  TTTiKaSendView.m
//  TTAnswer
//
//  Created by GOOUC on 2020/3/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#define PopMargin 15 // 边距
#define PopLineSpacing 10 // 上下间距
#define PopInteritemSpacing 15 // 左右间距
#define PopItemNumber 6 // 每一行的个数
#define TopBgViewHeight 50  // 顶部视图的高度


#import "YJAnswerPopModel.h"
#import "YJAnswerPopCollectionViewCell.h"
#import "TTSendSucViewController.h"
#import "MHPactioceModel.h"
@interface MHAnswerRelustView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *dataSources;

@property (nonatomic,strong) UIButton *lookBtn;
@property (strong, nonatomic) UIProgressView *progress;


@end

@implementation MHAnswerRelustView


- (void)setupUI {
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(Window_W-24);
    }];
    [self collectionView];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    self.layer.backgroundColor = kWhiteColor.CGColor;
    [self addSubview:self.sendBtn];
    [self addSubview:self.lookBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(Window_W/2+10);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(150);
    }];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(30);
        make.right.mas_equalTo(-(Window_W/2+10));
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(150);
    }];
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = 20.5;
    self.lookBtn.layer.masksToBounds = YES;
    self.lookBtn.layer.cornerRadius = 20.5;
    [[CCTools sharedInstance] addborderToView:self.lookBtn width:0.5 color:kMainColor];
    [self.topView addSubview:self.titleLab];
    [self.topView addSubview:self.progress];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView).mas_offset(30);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(Window_W-60);
    }];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"答对10题" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 20],NSForegroundColorAttributeName: [UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:1.0]}];
    UILabel *label = [[UILabel alloc] init];

    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"共计15题" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    [string appendAttributedString:string2];
    label.attributedText = string;
    self.titleLab.attributedText = string;
}

- (void)setCategoryQuestionList:(NSArray *)categoryQuestionList {
    _categoryQuestionList = categoryQuestionList;
    _dataSources = [NSMutableArray array];
    __block int i = 0;
    __block int a = 0;
    [self.categoryQuestionList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        i += 1;
        YJAnswerPopModel *model = [[YJAnswerPopModel alloc] init];
        model.number = [NSString stringWithFormat:@"%d",i];
        if ([obj isKindOfClass:NSIndexPath.class]) {
            model.status = YJAnswerPopStatusAnswered;
            a +=1;
        }
        [_dataSources addObject:model];
    }];
//    _topView.text = [NSString stringWithFormat:@"本次试卷一共%ld道题，已答%ld道",(long)(i-1),(long)a];
}

-(UIProgressView *)progress {
    if (!_progress) {
        
        //进度条高度不可修改
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(14, 100, Window_W-24-28, 40)];
        
        //设置进度条的颜色
        _progress.progressTintColor = [UIColor blueColor];
        _progress.trackTintColor =  [UIColor colorWithRed:170/255.0 green:236/255.0 blue:255/255.0 alpha:1.0];
        //设置进度条的当前值，范围：0~1；
        _progress.progress = 0.5;
        
        /*
         typedef NS_ENUM(NSInteger, UIProgressViewStyle) {
         UIProgressViewStyleDefault,     // normal progress bar
         UIProgressViewStyleBar __TVOS_PROHIBITED,     // for use in a toolbar
         };
        */
        _progress.progressViewStyle = UIProgressViewStyleDefault;
    }
    return _progress;
}

#pragma mark - collectionView
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(PopMargin, PopMargin, 0, PopMargin);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 120, Window_W-20, 180) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"YJAnswerPopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YJAnswerPopCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark  collectionViewDataSource -  UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return PopInteritemSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return PopLineSpacing;
}

/* 个数 **/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count-1;
}

/* 选中 **/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSIndexPath *temp = nil;
     temp = indexPath;
     if (temp) {
         if (self.callBack) {
             self.callBack(temp);
         }
     }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat w = (Window_W - PopMargin * 2 - (PopItemNumber - 1) * PopInteritemSpacing)/ PopItemNumber;
    return CGSizeMake(w, w);
}

/* cell设置 **/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YJAnswerPopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YJAnswerPopCollectionViewCell" forIndexPath:indexPath];
    if (self.dataSources.count > indexPath.item) {
        cell.cmodel = self.dataSources[indexPath.item];
    }
    return cell;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = ({
            UIView *view = [UIView new];
            view;
        });
    }
    return _topView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =  COLOR_333333;
            view.font = FONT_16;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.textAlignment = NSTextAlignmentCenter;
            view;
        });
    }
    return _titleLab;
}
- (UIButton *)lookBtn {
    if (!_lookBtn) {
        _lookBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"查看解析" forState:UIControlStateNormal];
            [view setTitleColor:kMainColor forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_15];
            [view setUserInteractionEnabled:YES];
            [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view setBackgroundColor:kWhiteColor];
            view.tag = 1;
            view ;
        });
    }
    return _lookBtn;
}
- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn =({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"继续挑战" forState:UIControlStateNormal];
            [view.titleLabel setTextColor:kWhiteColor];
            [view.titleLabel setFont:FONT_15];
            [view setUserInteractionEnabled:YES];
            [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view setBackgroundColor:kMainColor];
            view.tag = 2;
            view ;
        });
    }
    return _sendBtn;
}
- (void)commentBtnClick:(UIButton *)btn {
    NSString *url = [NSString stringWithFormat:@"course/check_test/%ld",self.paperid];
    NSMutableArray *dataSource = [NSMutableArray array];

    for (MHPactioceModel *model in _reslutArray) {

    [dataSource addObject:model.mj_keyValues];

    }
    XYWeakSelf;
    NSDictionary *params = @{@"test_result":[self convertToJsonData:dataSource],

    };
    [[STHttpResquest sharedManager] requestWithMethod:POST
                                             WithPath:url
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSArray *data = dic[@"data"];
            
//            [weakSelf.tableView reloadData];
        }else if(status == 410000) {//未登录
//            STLoginViewController *vc = [STLoginViewController new];
//            CCBaseNavController *nav = [[CCBaseNavController alloc] initWithRootViewController:vc];
//            [weakSelf presentViewController:nav animated:YES completion:nil];
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];

}
-(NSString *)convertToJsonData:(NSMutableArray *)dict {

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

    NSLog(@"%@",error);

    }else{

    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}


@end
