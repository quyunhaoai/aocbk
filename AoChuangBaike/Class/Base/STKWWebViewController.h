//
//  STKWWebViewController.h
//  StudyOC
//
//  Created by   on 2019/9/6.
//  Copyright © 2019  . All rights reserved.
//

#import "CCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface STKWWebViewController : CCBaseViewController

@property (copy, nonatomic) NSString *urlString;  // 跳转地址
@property (copy, nonatomic) NSString *navTitle;    // 导航标题
@end

NS_ASSUME_NONNULL_END
