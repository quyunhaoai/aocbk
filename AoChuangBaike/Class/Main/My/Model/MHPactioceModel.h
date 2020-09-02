//
//  MHPactioceModel.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Answer_all :NSObject
@property (nonatomic , copy) NSString              * A;
@property (nonatomic , copy) NSString              * B;
@property (nonatomic , copy) NSString              * C;
@property (nonatomic , copy) NSString              * D;
@property (nonatomic , copy) NSString              * E;
@property (nonatomic , copy) NSString              * F;
@end
@interface MHPactioceModel : BaseModel
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , assign) NSInteger              course_id;
@property (nonatomic , assign) NSInteger              class_id;
@property (nonatomic , assign) NSInteger              class_item_id;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * question;
@property (nonatomic , strong) Answer_all              * answer_all;
@property (nonatomic , copy) NSString              * choose;
@property (assign, nonatomic) CGFloat   headViewHeight;
@end

NS_ASSUME_NONNULL_END
