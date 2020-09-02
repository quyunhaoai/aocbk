//
//  MHZhangJieLXTableViewCell.m
//  MentalHorizonProject
//
//  Created by    on 2020/4/30.
//  Copyright © 2020   . All rights reserved.
//

#import "MHZhangJieLXTableViewCell.h"

@implementation MHZhangJieLXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.rightBtn.bounds;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:114/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:198/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [self.rightBtn.layer insertSublayer:gl below:self.rightBtn.titleLabel.layer];
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.cornerRadius = 12.5;
    
    self.title1Lab.textColor =Color_2A2A2A;
    self.title2Lab.textColor = COLOR_666666;
    self.title3Lab.textColor = COLOR_666666;
    self.title3Lab.font = FONT_10;
    self.title2Lab.font = FONT_10;
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:COLOR_f5f5f5];
}
- (void)setModel:(BaseModel *)model {
    MHZhangJieLX *modelss = (MHZhangJieLX *)model;
    self.modelcc = modelss;
    self.title1Lab.text = modelss.item_name;
    self.title2Lab.text = [NSString stringWithFormat:@"%ld人已答",(long)modelss.has_pass];
    self.title3Lab.text = [NSString stringWithFormat:@"共%ld题",modelss.pactice_num];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 82;
}
- (IBAction)rightBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
        [self.delegate clickButtonWithType:KKBarButtonTypeMore item:self.modelcc];
    }
}
@end
