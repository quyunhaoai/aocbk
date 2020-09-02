
//
//  CCMessageModelTableViewCell.m
//  CunCunTong
//
//  Created by    on 2020/4/9.
//  Copyright © 2020   . All rights reserved.
//

#import "CCMessageModelTableViewCell.h"
#import "KKButton.h"

@implementation CCMessageModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.lookDetailBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    self.bgView.layer.cornerRadius = 8;
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:[UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:0.2]];
    self.namelab.textColor = Color_363636;
    [self.lookDetailBtn setBackgroundColor:kMainColor];
    self.lookDetailBtn.layer.cornerRadius = 10;
    [self.lookDetailBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.lookDetailBtn.titleLabel setFont:FONT_12];
    self.ICONIMageView.layer.cornerRadius = 9;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 145.f;
}
- (void)setModel:(BaseModel *)model {
    CCMessageModel *modelss = (CCMessageModel *)model;
    self.cellmodel = modelss;
    self.titleLab.text = [NSString stringWithFormat:@"%@·%ld讲",modelss.title,(long)modelss.class_num];
    self.subLab.text = modelss.short_title;
    [self.ICONIMageView sd_setImageWithURL:[NSURL URLWithString:modelss.main_image]];
    self.namelab.text = [NSString stringWithFormat:@"%@·%@",modelss.lecturer.name,modelss.lecturer.title];
    if (modelss.study_status == 0 ) {
        [self.lookDetailBtn setTitle:@"开始学习" forState:UIControlStateNormal];
        self.timeLab.text = @"开始学习";
    } else {
        [self.lookDetailBtn setTitle:@"继续学习" forState:UIControlStateNormal];
        self.timeLab.text = @"继续学习";
    }
}
- (IBAction)startLear:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
        [self.delegate clickButtonWithType:KKBarButtonTypeMore item:self.cellmodel];
    }
    
}
@end
