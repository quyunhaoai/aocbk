//
//  MHMyClassModel.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyClassModel : BaseModel
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , assign) NSInteger              course_id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              is_free;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              begin_order;
@property (nonatomic , assign) NSInteger              is_end;
@property (nonatomic , assign) NSInteger              is_exam;
@property (nonatomic , assign) NSInteger              file_status;
@property (nonatomic , copy) NSString              * file_info;
@property (nonatomic , copy) NSString              * videoId;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * open_time;
@property (nonatomic , assign) NSInteger              play_num;
@property (nonatomic , assign) NSInteger              study;
@property (nonatomic , assign) NSInteger              lianxi;
@property (nonatomic , assign) NSInteger              moni;
@property (nonatomic , assign) NSInteger              ceshi;
@end

NS_ASSUME_NONNULL_END
