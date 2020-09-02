//
//  MHNewsListModelTableViewCell.m
//  MentalHorizonProject
//
//  Created by    on 2020/4/29.
//  Copyright © 2020   . All rights reserved.
//

#import "MHNewsListModelTableViewCell.h"
#import "MHNewsListModel.h"
@implementation MHNewsListModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColor = Color_2A2A2A;
    self.titleLab.font = FONT_14;
    self.subLab.textColor = COLOR_999999;
    self.subLab.font = FONT_13;
    [self.lookBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    self.imageIVew.layer.cornerRadius = 8;
    [self.lookBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.shareBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BaseModel *)model {
    MHNewsListModel *modelss = (MHNewsListModel *)model;
    self.titleLab.text = modelss.title;
    self.subLab.text = modelss.add_time;
    [self.lookBtn setTitle:[NSString stringWithFormat:@"%ld",(long)modelss.view] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",(long)modelss.share_num] forState:UIControlStateNormal];
    [self.imageIVew sd_setImageWithURL:[NSURL URLWithString:modelss.image]];
    
}

+ (CGFloat)height {
    return 104;
}
@end
