//
//  TTSendSucViewController.h
//  TTAnswer
//
//  Created by GOOUC on 2020/3/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "TTListAnswerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTSendSucViewController : CCBaseTableViewController
@property (strong, nonatomic) NSDictionary * reslutDic;
@property (copy, nonatomic) NSString *PID;
@property (strong, nonatomic) TTListAnswerModel *questListModle;   
@end

NS_ASSUME_NONNULL_END
