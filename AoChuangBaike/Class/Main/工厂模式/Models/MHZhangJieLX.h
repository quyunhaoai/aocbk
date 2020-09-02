//
//  MHZhangJieLX.h
//  MentalHorizonProject
//
//  Created by    on 2020/4/30.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHZhangJieLX : BaseModel
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , copy) NSString              * item_name;
@property (nonatomic , assign) NSInteger              course_id;
@property (nonatomic , assign) NSInteger              class_id;
@property (nonatomic , assign) NSInteger              item_type;
@property (nonatomic , assign) NSInteger              item_level;
@property (nonatomic , copy) NSString              * total;
@property (nonatomic , copy) NSString              * franction;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              own_pactice;
@property (nonatomic , copy) NSString              * pass_fen;
@property (nonatomic , assign) NSInteger              has_pass;
@property (nonatomic , assign) NSInteger              pactice_num;
@end

NS_ASSUME_NONNULL_END
