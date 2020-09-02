//
//  TYCyclePagerViewCell.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@interface TYCyclePagerViewCell ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation TYCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
//        [self addLabel];
        [self img];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
//        [self addLabel];
        [self img];
    }
    return self;
}
- (UIImageView *)img {
    if (_img == nil) {
        _img = [UIImageView new];
        [self addSubview:_img];
        self.img.frame = self.bounds;
        self.img.layer.masksToBounds = YES;
        self.img.layer.cornerRadius = 8;
        self.img.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _img;
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    _label = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _img.frame = self.bounds;
}

@end
