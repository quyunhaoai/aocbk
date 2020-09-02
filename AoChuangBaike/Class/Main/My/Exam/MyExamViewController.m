//
//  MyExamViewController.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/8.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MyExamViewController.h"

#import "MyExamTopView.h"
#import "MyExamBoomView.h"

#import "QutestCollectionViewCell.h"
//#import "TTTiKaSendView.h"
#import "Header.h"

#import "YJAnswerPopViewController.h"
#import "YJ_GCDTimerManager.h"
#import "TTQuestionModel.h"
#import "YYModel.h"
@interface MyExamViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;

@property (strong, nonatomic) UICollectionView           *collectionView;

@property (strong, nonatomic) MyExamTopView              *myExamTopView;

@property (strong, nonatomic) MyExamBoomView             *myExamBoomView;

@property (strong, nonatomic) NSMutableArray             *dataSource;

@property (strong, nonatomic) NSMutableArray             *resultArray;

@property (strong, nonatomic) NSMutableArray             *indexPathArray;

@property (assign, nonatomic) NSInteger                   currentSelectIndex;

//@property (strong, nonatomic) TTTiKaSendView             *sendView;

@property (nonatomic,strong) UIButton                    *oldBtn;

@property (nonatomic, assign) NSInteger                  totalTime; // 秒数

@property (strong, nonatomic) NSMutableArray             *reslutQuestArray;

@end

@implementation MyExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBarWithTitle:@"答题"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initView];
    
    [self initData];
}

- (void)initView {
    
    [self.view addSubview:self.myExamTopView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.myExamBoomView];
    
    __weak typeof(self) weakSelf = self;
    
    _myExamBoomView.subjectBlock = ^(NSInteger btnTag) {
    
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        switch (btnTag) {
                
            case 1:
                
                [strongSelf collectionViewScrollToItem:NO btnTag:btnTag];
                break;
            case 2:
                
                [weakSelf popView];
                break;
            case 3:
                
                [strongSelf collectionViewScrollToItem:YES btnTag:btnTag];
                break;
                
            default:
                break;
        }
    };
}

- (void)initData {
//    if (self.model == nil) {
//        self.model = [[NSUserDefaults standardUserDefaults] objectForKey:QuestionModel];
//    }
    [self dataSource];
    [self resultArray];
    [self indexPathArray];
    /**
     start_time: 1585273274913
    uid: 32
    paperid: 11
    op: exam*/
    NSString *currentTime = [NSString getCurrentTimeSp];
    XYWeakSelf;

    NSDictionary *params = @{@"uid":@"32",
                             @"start_time":currentTime,
                             @"paperid":@(self.model.PID),
                             @"op":@"exam",
                            };
    if (self.isJiexi) {
        params = @{@"uid":@"32",
               @"paperid":self.PID,
                     @"m":@"goouc_practice",
        };
    }
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"question" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSLog(@"--%@--",dic);
        NSDictionary *data = dic[@"data"];
        NSArray *list = data[@"list"];
        weakSelf.dataSource = list.mutableCopy;
        [weakSelf.dataSource addObject:@{@"type":@"5"}];
        for (int i = 0; i < weakSelf.dataSource.count; i++) {
            [weakSelf.resultArray addObject:@[]];
            [weakSelf.indexPathArray addObject:@[]];
        }
        [weakSelf setQuestNumber];
        [weakSelf.collectionView reloadData];
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
    _myExamTopView.subjectTypeLabel.text = self.model.title;
    _myExamTopView.headLab.text = [self.model.cname substringToIndex:1];

    if (self.model.times > 0) {
        self.totalTime = self.model.times;
        [self startTimer];
    } else {
        self.myExamTopView.timeLab.text =  @"不限时";
    }
}
- (void) setQuestNumber {
    NSString *str = [NSString stringWithFormat:@"1/%ld",(long)_dataSource.count-1];
    NSMutableAttributedString *attributedstr =  [[NSMutableAttributedString alloc] initWithString:str];
    [attributedstr addAttribute:NSForegroundColorAttributeName value:UIColorHex(0xfba937) range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)1]]];
    [attributedstr addAttribute:NSFontAttributeName value:FONT_18 range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)1]]];
    _myExamTopView.subjectNumLabel.attributedText = attributedstr;
}
- (void)setTotalTime:(NSInteger)totalTime {
    _totalTime = totalTime;
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        self.myExamTopView.timeLab.text =  [self handleTime:self.totalTime];
    });
}

- (NSString *)handleTime:(NSInteger)time {
    if (time <= 0) {
        return @"00:00:00";
    }
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)time/360,(long)time/60,(long)time%60];
}

- (void)startTimer {
    __weak typeof(self) weakSelf = self;
    [[YJ_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:NSStringFromClass([MyExamViewController class]) timeInterval:1.f queue:nil repeats:YES actionOption:(YJ_ActionOptionAbandonPrevious) action:^{
        weakSelf.totalTime -= 1;
        if (weakSelf.totalTime <= 0) {
            [weakSelf endTimer];
        }
    }];
}

- (void)endTimer {
    
    NSLog(@"到时间了交卷");
    
    [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:NSStringFromClass([MyExamViewController class])];
}
#pragma mark - YJAnswerPopViewController

- (void)popView {
    __weak typeof(self) weakSelf = self;
    YJAnswerPopViewController *popVC = [[YJAnswerPopViewController alloc] initWithShowFrame:CGRectMake(0, 176, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 176) ShowStyle:MYPresentedViewShowStyleFromBottomDropStyle callback:^(id callback) {
        NSLog(@"callback - %@",callback);
        if ([callback isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = callback;
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
            NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.item+1,(long)weakSelf.dataSource.count-1];
            NSMutableAttributedString *attributedstr =  [[NSMutableAttributedString alloc] initWithString:str];
            [attributedstr addAttribute:NSForegroundColorAttributeName value:UIColorHex(0xfba937) range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)indexPath.item+1]]];
            [attributedstr addAttribute:NSFontAttributeName value:FONT_18 range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)indexPath.item+1]]];
            if (indexPath.row == weakSelf.dataSource.count-1) {
                weakSelf.myExamTopView.subjectNumLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
                UIButton *button = [weakSelf.myExamBoomView viewWithTag:3];
                [button setTitle:@"提交" forState:UIControlStateNormal];
                [button setEnabled:NO];
            } else {
                weakSelf.myExamTopView.subjectNumLabel.attributedText = attributedstr;
                for (UIView *vvv in weakSelf.myExamBoomView.subviews) {
                    if ([vvv.class isEqual:[UIButton class]]) {
                        [(UIButton *)vvv setEnabled:YES];
                        if (vvv.tag == 3) {
                            [(UIButton *)vvv setTitle:@"下一题" forState:UIControlStateNormal];
                        }
                    }
                }
            }
        }
    }];
    popVC.categoryQuestionList = [self.indexPathArray copy];
    [self presentViewController:popVC animated:YES completion:nil];
}
// 设置单元格的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

// 设置段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QutestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorHex(0xf7f7f7);
    if ([_resultArray[indexPath.item] isKindOfClass:[NSString class]] && [_indexPathArray[indexPath.item] isKindOfClass:[NSIndexPath class]]) {
        cell.seleIndexStr  = _resultArray[indexPath.item];
        cell.seleIndexPath = _indexPathArray[indexPath.item];
    }
    cell.index = self.currentSelectIndex +1;
    __weak typeof(self) weakSelf = self;
    cell.SingleSelectBlock = ^(NSIndexPath *seleIndexPath, NSInteger btnTag) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf.indexPathArray containsObject:seleIndexPath]) {
            [strongSelf.indexPathArray replaceObjectAtIndex:indexPath.item withObject:@""];
        } else {
            [strongSelf.indexPathArray replaceObjectAtIndex:indexPath.item withObject:seleIndexPath];
        }
        [strongSelf.resultArray replaceObjectAtIndex:indexPath.item withObject:[NSString stringWithFormat:@"%ld",(long)btnTag]];
    };
    cell.MultiSelectBlock = ^(NSInteger btnTagSum) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (btnTagSum) {
            [strongSelf.indexPathArray replaceObjectAtIndex:indexPath.item withObject:indexPath];
        } else {
            [strongSelf.indexPathArray replaceObjectAtIndex:indexPath.item withObject:@""];
        }
        [strongSelf.resultArray replaceObjectAtIndex:indexPath.item withObject:[NSString stringWithFormat:@"%ld",(long)btnTagSum]];
    };
    cell.sendView.callBack = ^(id  _Nonnull path) {
        NSLog(@"callback - %@",path);
        if ([path isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = path;

            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
            NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.item+1,(long)weakSelf.dataSource.count-1];
            NSMutableAttributedString *attributedstr =  [[NSMutableAttributedString alloc] initWithString:str];
            [attributedstr addAttribute:NSForegroundColorAttributeName value:UIColorHex(0xfba937) range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)indexPath.item+1]]];
            [attributedstr addAttribute:NSFontAttributeName value:FONT_18 range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)indexPath.item+1]]];
            if (indexPath.row == self.dataSource.count-1) {
                weakSelf.myExamTopView.subjectNumLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
                UIButton *button = [weakSelf.myExamBoomView viewWithTag:3];
                [button setTitle:@"提交" forState:UIControlStateNormal];
                [button setEnabled:NO];
            } else {
                weakSelf.myExamTopView.subjectNumLabel.attributedText = attributedstr;
                for (UIView *vvv in weakSelf.myExamBoomView.subviews) {
                    if ( [vvv isKindOfClass:[UIButton class]]) {
                        [(UIButton *)vvv setEnabled:YES];
                        if (vvv.tag == 3) {
                            [(UIButton *)vvv setTitle:@"下一题" forState:UIControlStateNormal];
                        }
                    }
                }
            }
        }
    };
    cell.isJiexi = self.isJiexi;
    TTQuestionModel *questionModel = [TTQuestionModel yy_modelWithJSON:self.dataSource[indexPath.row]];
    cell.model = questionModel;

    cell.blackModel = ^(TTQuestionModel *Qmodel) {
        if ([weakSelf.reslutQuestArray containsObject:Qmodel]) {
            [weakSelf.reslutQuestArray removeObject:Qmodel];
        }
        [weakSelf.reslutQuestArray addObject:Qmodel];
    };
    cell.relustArray = self.reslutQuestArray;
    cell.selectArr = [self.indexPathArray mutableCopy];
    cell.paperid = self.model.PID ;
    cell.listModel = self.model;
    return cell;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewEndScrolling:scrollView.contentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewEndScrolling:scrollView.contentOffset];
}

// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 单元格默认大小：50*50
    // 第一个参数：设置单元格的宽
    // 第二个参数：设置单元格的高
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 75-51);
}

// cell与cell之间的间隔，边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上左下右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置垂直最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

// 设置水平最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

// 设置标题头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // 第一个参数：只有当水平滑动时有效
    // 第二个参数：只有当垂直滑动时有效
    return CGSizeMake(0, 0);
}

- (void)scrollViewEndScrolling:(CGPoint)contentOffset {

    NSInteger index = contentOffset.x / SCREEN_WIDTH;
    _currentSelectIndex = index;
    NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)_currentSelectIndex + 1, (long)_dataSource.count-1];
    NSMutableAttributedString *attributedstr =  [[NSMutableAttributedString alloc] initWithString:str];
    [attributedstr addAttribute:NSForegroundColorAttributeName value:UIColorHex(0xfba937) range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)_currentSelectIndex + 1]]];
    [attributedstr addAttribute:NSFontAttributeName value:FONT_18 range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)_currentSelectIndex + 1]]];

    UIButton *button  = (UIButton *)[_myExamBoomView viewWithTag:3];
    if (_currentSelectIndex == self.dataSource.count-1) {
        _myExamTopView.subjectNumLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];;
        [button setTitle:@"提交" forState:UIControlStateNormal];
        self.oldBtn = button;
    } else {
        _myExamTopView.subjectNumLabel.attributedText = attributedstr;
        [self.oldBtn setTitle:@"下一题" forState:UIControlStateNormal];
    }
    QutestCollectionViewCell *cell = (QutestCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentSelectIndex inSection:0]];
    cell.index = _currentSelectIndex+1;
    cell.selectArr = self.indexPathArray.mutableCopy;
}

- (void)collectionViewScrollToItem:(BOOL)bl btnTag:(NSInteger)btnTag {
    
    if (bl)  _currentSelectIndex ++;
    else     _currentSelectIndex --;
//    NSLog(@"----------------%ld",_currentSelectIndex);
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentSelectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)_currentSelectIndex + 1,(long)_dataSource.count-1];
    NSMutableAttributedString *attributedstr =  [[NSMutableAttributedString alloc] initWithString:str];
    [attributedstr addAttribute:NSForegroundColorAttributeName value:UIColorHex(0xfba937) range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)_currentSelectIndex + 1]]];
    [attributedstr addAttribute:NSFontAttributeName value:FONT_18 range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)_currentSelectIndex + 1]]];

    UIButton *button  = (UIButton *)[_myExamBoomView viewWithTag:btnTag];
    if (_currentSelectIndex == self.dataSource.count-1) {
        _myExamTopView.subjectNumLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];;
        [button setTitle:@"提交" forState:UIControlStateNormal];
        self.oldBtn = button;
    } else {
        _myExamTopView.subjectNumLabel.attributedText = attributedstr;
        [self.oldBtn setTitle:@"下一题" forState:UIControlStateNormal];
    }
    
    if (_currentSelectIndex == _dataSource.count - 1 || _currentSelectIndex == _dataSource.count - 2 || _currentSelectIndex == 0 || _currentSelectIndex == 1) {
        
        UIButton *button  = (UIButton *)[_myExamBoomView viewWithTag:btnTag];
        
        if (_currentSelectIndex == _dataSource.count - 1 || _currentSelectIndex == 0)
            button.enabled = NO;
        
        NSArray *subArray = _myExamBoomView.subviews;
        for (UIButton *subbutton  in subArray) {
            if ([subbutton isKindOfClass:[UIButton class]]) {
                if (subbutton != button) {
                    subbutton.enabled = YES;
                }
            }
        }
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionViewLayout                          = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
        _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 75, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 75 - 51) collectionViewLayout:_collectionViewLayout];
        _collectionViewLayout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces                        = NO;
        _collectionView.pagingEnabled                  = YES;
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.scrollsToTop                   = NO;
        _collectionView.backgroundColor                = UIColorHex(0xf7f7f7);
        // 注册cell
        [_collectionView registerClass:[QutestCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

- (MyExamTopView *)myExamTopView {
    if (!_myExamTopView) {
        _myExamTopView = [[MyExamTopView alloc]init];
    }
    return _myExamTopView;
}

- (MyExamBoomView *)myExamBoomView {
    if (!_myExamBoomView) {
        _myExamBoomView = [[MyExamBoomView alloc]init];
    }
    return _myExamBoomView;
}

//- (TTTiKaSendView *)sendView {
//    if (!_sendView) {
//        _sendView = [[TTTiKaSendView alloc] init];
//        XYWeakSelf;
//        _sendView.callBack = ^(id  _Nonnull path) {
//            NSLog(@"callback - %@",path);
//            if ([path isKindOfClass:[NSIndexPath class]]) {
//                NSIndexPath *indexPath = path;
//
//                [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
//                NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.item+1,(long)weakSelf.dataSource.count-1];
//                NSMutableAttributedString *attributedstr =  [[NSMutableAttributedString alloc] initWithString:str];
//                [attributedstr addAttribute:NSForegroundColorAttributeName value:UIColorHex(0xfba937) range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)indexPath.item+1]]];
//                [attributedstr addAttribute:NSFontAttributeName value:FONT_18 range:[str rangeOfString: [NSString stringWithFormat:@"%ld",(long)indexPath.item+1]]];
//                if (indexPath.row == self.dataSource.count-1) {
//                    weakSelf.myExamTopView.subjectNumLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
//                    UIButton *button = [weakSelf.myExamBoomView viewWithTag:3];
//                    [button setTitle:@"提交" forState:UIControlStateNormal];
//                    [button setEnabled:NO];
//                } else {
//                    weakSelf.myExamTopView.subjectNumLabel.attributedText = attributedstr;
//                    for (UIView *vvv in weakSelf.myExamBoomView.subviews) {
//                        if ( [vvv isKindOfClass:[UIButton class]]) {
//                            [(UIButton *)vvv setEnabled:YES];
//                            if (vvv.tag == 3) {
//                                [(UIButton *)vvv setTitle:@"下一题" forState:UIControlStateNormal];
//                            }
//                        }
//                    }
//                }
//            }
//        };
//    }
//    return _sendView;
//}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (NSMutableArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

- (NSMutableArray *)reslutQuestArray {
    if (!_reslutQuestArray) {
        _reslutQuestArray = [[NSMutableArray alloc] init];
    }
    return _reslutQuestArray;
}

- (NSMutableArray *)indexPathArray {
    if (!_indexPathArray) {
        _indexPathArray = [[NSMutableArray alloc]init];
    }
    return _indexPathArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
