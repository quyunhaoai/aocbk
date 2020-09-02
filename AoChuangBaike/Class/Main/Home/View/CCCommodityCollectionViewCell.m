//
//  CCCommodityCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommodityCollectionViewCell.h"

@implementation CCCommodityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [[CCTools sharedInstance] addShadowToView:self withColor:[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:0.36]];
       
    self.bgView.layer.cornerRadius = 8;
    self.titleLab.textColor = UIColorHex(0x363636);
    self.subTitleLab.textColor = COLOR_999999;
    self.personNumberLab.textColor = COLOR_666666;
    
    self.titleLab.text = @"名师精选直播课程";
    self.subTitleLab.text = @"教你如何快速入门心理学";
    self.personNumberLab.text = @"126人已报名";
    
    self.baomingBtn.layer.masksToBounds = YES;
    self.baomingBtn.layer.cornerRadius = 7.5;
    [self.baomingBtn setBackgroundColor:UIColorHex(0x2385FF)];
    [self.lookBtn setTitleColor:UIColorHex(0x8A8A8A) forState:UIControlStateNormal];
//    [self.lookBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:20];
    
}

@end
