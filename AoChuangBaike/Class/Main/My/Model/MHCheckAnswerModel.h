//
//  MHCheckAnswerModel.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHCheckAnswerModel : BaseModel
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , assign) NSInteger              course_id;
@property (nonatomic , assign) NSInteger              class_id;
@property (nonatomic , copy) NSString              * class_item;
@property (nonatomic , assign) NSInteger              class_item_id;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * question;
@property (nonatomic , copy) NSString              * question_image;
@property (nonatomic , copy) NSString              * question_video;
@property (nonatomic , copy) NSString              * question_music;
@property (nonatomic , copy) NSString              * answer;
@property (nonatomic , copy) NSString              * answer_all;
@property (nonatomic , copy) NSString              * answer_explain;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , assign) NSInteger              is_del;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * user_choose;
@end

NS_ASSUME_NONNULL_END
