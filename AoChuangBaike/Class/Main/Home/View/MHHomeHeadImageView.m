//
//  MHHomeHeadImageView.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHHomeHeadImageView.h"
#import "ImageTitleButton.h"
#import "MHBannerModel.h"
@implementation MHHomeHeadImageView
- (void)setupUI {
    [self buildWithCycleView];
    [self addPageControl];
    
    NSArray *arr = @[@"直播",@"试听",@"资料",@"问答",@"资讯"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 10)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTag:i];
        [button.titleLabel setFont:FONT_13];
        [button setTitleColor:Color_363636 forState:UIControlStateNormal];
        NSString *str = [NSString stringWithFormat:@"%@",arr[i]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(str) forState:UIControlStateNormal];
        [button setBackgroundColor:kRedColor];
        [self addSubview:button];
        [tolAry addObject:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@158);
        make.height.equalTo(@64);
    }];
    self.buttosArray = [tolAry copy];
    
}
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
//    for (int i = 0; i <_dataArray.count; i++) {
//        MHGuoyiFirstPageModl *model = [MHGuoyiFirstPageModl mj_objectWithKeyValues:_dataArray[i]];
//        UIButton *btn = self.buttosArray[i];
//        btn.imageView.size = CGSizeMake(46, 46);
//        [btn.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
//        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        [btn sd_setImageWithURL:[NSURL URLWithString:model.pic] forState:UIControlStateNormal];
//        [btn setTitle:model.name forState:UIControlStateNormal];
//    }
}
- (void)buttonClick:(UIButton *)btn {
    if (self.menusClick ) {
        self.menusClick(btn.tag);
    }
}
#pragma mark --懒加载
- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    _pageControl.numberOfPages = _imageArray.count;
    [_pagerView reloadData];
}

#pragma mark-----轮播图修改
- (void)buildWithCycleView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.frame = CGRectMake(0, 0, self.width, 140);
    pagerView.backgroundColor = kYellowColor;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    pagerView.layout.layoutType = TYCyclePagerTransformLayoutNormal;
    [self addSubview:pagerView];
    _pagerView = pagerView;
}
- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    pageControl.pageIndicatorSize = CGSizeMake(6, 6);//pageIndicatorSize
    pageControl.currentPageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26-8, CGRectGetWidth(_pagerView.frame), 26);
}
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _imageArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds];
    cell.layer.shadowColor = COLOR_999999.CGColor;
    cell.layer.shadowOffset = CGSizeMake( 5.0f, 5.0f);
    cell.layer.shadowOpacity = .4f;
    cell.layer.shadowPath = shadowPath.CGPath;
    cell.layer.shadowRadius = 7.f;
    MHBannerModel *model = [MHBannerModel mj_objectWithKeyValues:self.imageArray[index]];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:ImageNamed(@"矩形 2") options:0];
    return cell;
}


- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (self.homeBannerClick) {
        self.homeBannerClick(index);
    }
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
//    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pageControlValueChangeAction:(TYPageControl *)sender {
//    NSLog(@"pageControlValueChangeAction: %ld",sender.currentPage);
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame) * 0.85, CGRectGetHeight(pageView.frame) * 0.85);
    layout.itemSpacing = kWidth(11);
    layout.itemHorizontalCenter = NO;
    layout.layoutType = TYCyclePagerTransformLayoutNormal;
    return layout;
}


@end
