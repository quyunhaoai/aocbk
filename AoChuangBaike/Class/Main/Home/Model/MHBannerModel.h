//
//  MHBannerModel.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/15.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHBannerModel : BaseModel
@property (nonatomic , copy) NSString              * IOS_url;
@property (nonatomic , copy) NSString              * android_url;
//@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              link_type;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , assign) NSInteger              title;

@end

NS_ASSUME_NONNULL_END
