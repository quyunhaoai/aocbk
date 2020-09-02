//
//  MHFillTextContentView.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHFillTextContentView : CCBaseView
@property (strong, nonatomic) UITextView *myTextView;    
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^callBack)(NSString *qianming);
@property (strong, nonatomic) UILabel *titleLab;  

@end

NS_ASSUME_NONNULL_END
