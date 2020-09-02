//
//  YJAnswerPopCollectionViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "YJAnswerPopCollectionViewCell.h"

@interface YJAnswerPopCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YJAnswerPopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.font = STFont(20);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

- (void)setModel:(YJAnswerPopModel *)model {
    _model = model;

    self.titleLabel.text = model.number;
    self.titleLabel.layer.cornerRadius = CGRectGetHeight(self.titleLabel.frame)/2.0;
    switch (model.status) {
        case YJAnswerPopStatusNoAnswer:
            self.titleLabel.textColor = UIColorHex(0x505050);
            self.titleLabel.layer.borderColor = COLOR_e5e5e5.CGColor;
            break;
        case YJAnswerPopStatusAnswering:
            self.titleLabel.textColor =  UIColorHex(0xfba937);
            self.titleLabel.layer.borderColor = UIColorHex(0xfba937).CGColor;
            break;
        case YJAnswerPopStatusAnswered:
            self.titleLabel.textColor =  UIColorHex(0xfba937);
            self.titleLabel.layer.borderColor =  UIColorHex(0xfba937).CGColor;
            break;
            
        default:
            break;
    }
}
- (void)setCmodel:(YJAnswerPopModel *)cmodel {
    _cmodel = cmodel;

    self.titleLabel.layer.cornerRadius = CGRectGetHeight(self.titleLabel.frame)/2.0;
    switch (cmodel.status) {
        case YJAnswerPopStatusNoAnswer:
            self.titleLabel.textColor = UIColorHex(0x505050);
            self.bgImageView.image = IMAGE_NAME(@"未答");
            break;
        case YJAnswerPopStatusAnswering:
            [self addlayerToTitleLab:self.bgImageView];
            self.titleLabel.textColor =  kWhiteColor;
            break;
        case YJAnswerPopStatusAnswered:
            self.bgImageView.layer.cornerRadius = 20;
            [self addlayerToTitleLab:self.bgImageView];
            self.titleLabel.textColor =  kWhiteColor;
            break;
            
        default:
            break;
    }
    self.titleLabel.text = cmodel.number;
}

- (void)addlayerToTitleLab:(UIView *)label{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = label.frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:198/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:119/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];

    [label.layer insertSublayer:gl atIndex:0];
}
@end
