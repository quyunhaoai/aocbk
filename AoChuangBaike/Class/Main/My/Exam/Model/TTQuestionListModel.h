//
//  TTQuestionListModel.h
//  TTAnswer
//
//  Created by GOOUC on 2020/3/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTQuestionListModel : NSObject
@property (nonatomic,copy) NSString *desStr;
@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *uanswer;
@property (assign, nonatomic) BOOL isSelect;
@property (assign, nonatomic) NSInteger type;    



@end

NS_ASSUME_NONNULL_END
