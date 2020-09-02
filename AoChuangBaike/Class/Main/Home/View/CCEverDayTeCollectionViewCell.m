//
//  CCEverDayTeCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCEverDayTeCollectionViewCell.h"

@implementation CCEverDayTeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.tittleLab.textColor = Color_2A2A2A;
    self.subTitltLab.textColor = COLOR_999999;
    self.nameLab.textColor = Color_363636;
    self.priceLab.textColor = kTipYellowCOLOR;
    [self.sureSales setBackgroundColor:color_BtnBG];
    self.tittleLab.text = @"应用心理专硕基础知识解析";
    self.subTitltLab.text = @"揭示如何化解现代人的孤独，实现自我成长... 拷贝";
    self.nameLab.text = @"王永军·北京大学副教授 拷贝";
    self.priceLab.text = @"6学习币";
    self.layer.shadowColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:0.18f].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2.0f);
    self.layer.shadowRadius =2.0f;
    self.layer.shadowOpacity =1.0f;
    self.layer.masksToBounds =NO;
    self.sureSales.layer.cornerRadius = 10;
    self.iconImageview.layer.cornerRadius = 8;
}

@end
