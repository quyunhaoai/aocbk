//
//  MHNewsCollectionViewCell.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHNewsCollectionViewCell.h"

@implementation MHNewsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLab.textColor = Color_2A2A2A;
    self.subLab.textColor = COLOR_666666;
    self.dateLab.textColor = COLOR_999999;
    
    [self.lookBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    
    self.cellBgView.layer.shadowColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:0.36].CGColor;
    self.cellBgView.layer.shadowOffset = CGSizeMake(0,0);
    self.cellBgView.layer.shadowOpacity = 1;
    self.cellBgView.layer.shadowRadius = 11;
    self.cellBgView.layer.cornerRadius = 5;
    
    self.titleLab.text = @"不要“被标签”影响了自我";
    self.subLab.text = @"这种现象是由于贴上标签后引起的 故称为“标签";
    self.dateLab.text = @"2020-03-13";
    
    [self.lookBtn setTitle:@"124" forState:UIControlStateNormal];
    [self.shareBtn setTitle:@"1234" forState:UIControlStateNormal];
    [self.lookBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.shareBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}

@end
