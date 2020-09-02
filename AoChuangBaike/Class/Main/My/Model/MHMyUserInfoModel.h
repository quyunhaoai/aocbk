//
//  MHMyUserInfoModel.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyUserInfoModel : BaseModel
@property (nonatomic , assign) NSInteger              uid;
@property (nonatomic , copy) NSString              * real_name;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * now_money;
@property (nonatomic , copy) NSString              * integral;
@property (nonatomic , assign) NSInteger              sex;
@property (nonatomic , copy) NSString              * card_id;
@property (nonatomic , copy) NSString              * person_sign;
@property (nonatomic , copy) NSString              * school;
@property (nonatomic , copy) NSString              * profession;
@property (nonatomic , copy) NSString              * work;
@end

NS_ASSUME_NONNULL_END
