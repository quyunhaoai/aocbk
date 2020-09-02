//
//  MHMYSalesClassTableViewCell.m
//  MentalHorizonProject
//
//  Created by    on 2020/4/27.
//  Copyright © 2020   . All rights reserved.
//

#import "MHMYSalesClassTableViewCell.h"
#import "MHMYSalesClass.h"
@implementation MHMYSalesClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.rightBtn setBackgroundColor:kMainColor];
    self.imageViewsss.layer.cornerRadius = 8;
    self.titleLab.textColor = Color_2A2A2A;
    self.titleLab.font = FONT_15;
    self.subtitleLab.font = FONT_13;
    self.subtitleLab.textColor = COLOR_999999;
    self.nameLab.textColor = COLOR_666666;
    self.nameLab.font = FONT_13;
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:[UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:0.2]];
    //[UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:0.2]
    self.rightBtn.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BaseModel *)model {
    MHMYSalesClass *modelsss = (MHMYSalesClass *)model;
    self.titleLab.text = [NSString stringWithFormat:@"%@",checkNull(modelsss.title)];
    self.subtitleLab.text = checkNull(modelsss.short_title);
    self.nameLab.text = [NSString stringWithFormat:@"%@·%@",checkNull(modelsss.lecturer.name),checkNull(modelsss.lecturer.title)];
    if ([modelsss.main_image isNotBlank]) {
        [self.imageViewsss sd_setImageWithURL:[NSURL URLWithString:modelsss.main_image]];
    } else {
        [self.imageViewsss sd_setImageWithURL:[NSURL URLWithString:modelsss.lecturer.pic]];
    }
    self.rightBtn.hidden = modelsss.isCollection;
}
+ (CGFloat)height {
    return 130;
}

@end
