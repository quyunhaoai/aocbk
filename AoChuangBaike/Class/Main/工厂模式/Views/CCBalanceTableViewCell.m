//
//  CCBalanceTableViewCell.m
//  CunCunTong
//
//  Created by    on 2020/3/30.
//  Copyright © 2020   . All rights reserved.
//

#import "CCBalanceTableViewCell.h"

@implementation CCBalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLab.textColor = COLOR_333333;
    self.subtitleLab.textColor = COLOR_999999;
    //UIFont(name: "DIN-Medium", size: 19.0)
    [self.priceLab setFont:[UIFont fontWithName:@"DIN-Medium" size:19]];
    self.priceLab.textColor = COLOR_333333;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BaseModel *)model {
    self.titleLab.text = @"微信充值";
    self.subtitleLab.text = @"12-10  09:50";
    self.priceLab.text = @"+1000";
}
+ (CGFloat)height {
    return 58.f;
}
@end
