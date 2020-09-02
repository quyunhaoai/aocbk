//
//  MHHomeHeadImageView.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "TYCyclePagerView.h"
#import "TYCyclePagerTransformLayout.h"
#import "TYCyclePagerViewCell.h"
#import "TYPageControl.h"
#import "MHGuoyiFirstPageModl.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHHomeHeadImageView : CCBaseView<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYPageControl *pageControl;
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/*
 *  home banner click block
 */
@property (copy, nonatomic) void(^homeBannerClick)(NSInteger number);
/*
 *  menuer block
 */
@property (copy, nonatomic) void(^menusClick)(NSInteger number);

/**
 轮播图
 */
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (strong, nonatomic) NSArray *buttosArray;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
