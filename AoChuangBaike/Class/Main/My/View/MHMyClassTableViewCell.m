//
//  MHMyClassTableViewCell.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHMyClassTableViewCell.h"
#import "MHZhangJIeLianXiViewController.h"
@implementation MHMyClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColor = Color_2A2A2A;
    self.titleLab.font = FONT_15;
    [self.startBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [self.startBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.lianXiBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.lianXiBtn setTitle:@"章节练习" forState:UIControlStateNormal];
    [self.lianXiBtn.titleLabel setFont:FONT_12];
    [self.lianXiBtn setBackgroundColor:kMainColor];
    self.lianXiBtn.layer.cornerRadius = 12;
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor: [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:0.27]];
    
    [self.moniBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.moniBtn setTitle:@"章节模拟" forState:UIControlStateNormal];
    [self.moniBtn.titleLabel setFont:FONT_12];
    [self.moniBtn setBackgroundColor:Color_A4A4A4];
    self.moniBtn.layer.cornerRadius = 12;
    [self.moniBtn setImage:IMAGE_NAME(@"解锁") forState:UIControlStateNormal];
    [self.moniBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    [self.testBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.testBtn setTitle:@"章节测试" forState:UIControlStateNormal];
    [self.testBtn.titleLabel setFont:FONT_12];
    [self.testBtn setBackgroundColor:Color_A4A4A4];
    self.testBtn.layer.cornerRadius = 12;
    [self.testBtn setImage:IMAGE_NAME(@"解锁") forState:UIControlStateNormal];
    [self.testBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
}
- (void)setModel:(MHMyClassModel *)Model {
    _Model = Model;
    self.titleLab.text = [NSString stringWithFormat:@"%@",Model.name];
//    if (Model.study == 1) {
//        [self.startBtn setTitle:@"开始学习" forState:UIControlStateNormal];
//    } else if (Model.study == 2){
//        [self.startBtn setTitle:@"学习结束" forState:UIControlStateNormal];
//    }
    switch (Model.lianxi) {
        case 0:
        {
//            [self.lianXiBtn setBackgroundColor:Color_A4A4A4];
//            [self.lianXiBtn setImage:IMAGE_NAME(@"解锁") forState:UIControlStateNormal];
//            [self.lianXiBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        }
            break;
        case 1:
        {
            [self.lianXiBtn setBackgroundColor:kMainColor];
            [self.lianXiBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
            [self.lianXiBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    switch (Model.moni) {
        case 0:
        {
            [self.moniBtn setBackgroundColor:Color_A4A4A4];
            [self.moniBtn setImage:IMAGE_NAME(@"解锁") forState:UIControlStateNormal];
            [self.moniBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
            
        }
            break;
        case 1:
        {
            [self.moniBtn setBackgroundColor:kTipYellowCOLOR];
            [self.moniBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
            [self.moniBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
        }
            break;
        case 2:
        {
            [self.moniBtn setBackgroundColor:kTipYellowCOLOR];
            [self.moniBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
            [self.moniBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
        }
            break;
        default:
            break;
    }
    switch (Model.ceshi) {
        case 0:
        {
            [self.testBtn setBackgroundColor:Color_A4A4A4];
            [self.testBtn setImage:IMAGE_NAME(@"解锁") forState:UIControlStateNormal];
            [self.testBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
        }
            break;
        case 1:
        {
            [self.testBtn setBackgroundColor:UIColorHex(0xED2156)];
            [self.testBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
            [self.testBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
        }
            break;
        case 2:
        {
            [self.testBtn setBackgroundColor:UIColorHex(0xED2156)];
            [self.testBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
            [self.testBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
        }
            break;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(KKButton *)sender {
    switch (sender.tag) {
        case 0:{
            MHZhangJIeLianXiViewController *vc = [MHZhangJIeLianXiViewController new];
            vc.type = STRING_FROM_INTAGER(sender.tag);
            vc.classID = STRING_FROM_INTAGER(self.Model.course_id);
            vc.zhangjieID = STRING_FROM_INTAGER(self.Model.mhid);
            vc.titleStr = @"章节练习";
            [sender.superview.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
//            if (self.Model.lianxi == 0) {
//                MHZhangJIeLianXiViewController *vc = [MHZhangJIeLianXiViewController new];
//                vc.type = STRING_FROM_INTAGER(sender.tag);
//                vc.classID = STRING_FROM_INTAGER(self.Model.course_id);
//                vc.zhangjieID = STRING_FROM_INTAGER(self.Model.mhid);
//                [sender.superview.viewController.navigationController pushViewController:vc animated:YES];
//            } else {
                MHZhangJIeLianXiViewController *vc = [MHZhangJIeLianXiViewController new];
                vc.type = STRING_FROM_INTAGER(sender.tag);
                vc.classID = STRING_FROM_INTAGER(self.Model.course_id);
                vc.zhangjieID = STRING_FROM_INTAGER(self.Model.mhid);
                vc.titleStr = @"章节练习";
                [sender.superview.viewController.navigationController pushViewController:vc animated:YES];
//            }
        }
            
            break;
        case 2:{
            if (self.Model.moni == 0) {
                if (self.zhangJieTip) {
                    self.zhangJieTip(@"章节练习");
                }
            } else {
                MHZhangJIeLianXiViewController *vc = [MHZhangJIeLianXiViewController new];
                vc.type = STRING_FROM_INTAGER(sender.tag);
                vc.classID = STRING_FROM_INTAGER(self.Model.course_id);
                vc.zhangjieID = STRING_FROM_INTAGER(self.Model.mhid);
                vc.titleStr = @"章节模拟";
                [sender.superview.viewController.navigationController pushViewController:vc animated:YES];
            }
        }
            
            break;
        case 3:{
            if (self.Model.ceshi == 0) {
                if (self.zhangJieTip) {
                    self.zhangJieTip(@"章节模拟");
                }
            } else {
                MHZhangJIeLianXiViewController *vc = [MHZhangJIeLianXiViewController new];
                vc.type = STRING_FROM_INTAGER(sender.tag);
                vc.classID = STRING_FROM_INTAGER(self.Model.course_id);
                vc.zhangjieID = STRING_FROM_INTAGER(self.Model.mhid);
                [sender.superview.viewController.navigationController pushViewController:vc animated:YES];
            }
        }
            
            break;
        default:
            break;
    }

}

@end
