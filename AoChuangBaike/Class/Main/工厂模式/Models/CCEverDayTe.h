//
//  CCEverDayTeModel.h
//  CunCunTong
//
//  Created by    on 2020/4/2.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseModel.h"
#import "MHCommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCEverDayTe : BaseModel
@property (nonatomic , assign) NSInteger              add_time;
@property (nonatomic , assign) NSInteger              buy_num;
@property (nonatomic , assign) NSInteger              cate_id;
@property (nonatomic , assign) NSInteger              class_num;
@property (nonatomic , copy) NSString              * del_price;
@property (nonatomic , assign) NSInteger              file_time;
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              is_download;
@property (nonatomic , strong) Lecturer              * lecturer;
@property (nonatomic , assign) NSInteger              lecturer_id;
@property (nonatomic , assign) NSInteger              main_file_type;
@property (nonatomic , copy) NSString              * main_image;
@property (nonatomic , copy) NSString              * main_live;
@property (nonatomic , copy) NSString              * main_mp3;
@property (nonatomic , copy) NSString              * main_video;
@property (nonatomic , assign) NSInteger              pay_type;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , assign) NSInteger              recommend;
@property (nonatomic , assign) NSInteger              reply_num;
@property (nonatomic , assign) NSInteger              share_num;
@property (nonatomic , copy) NSString              * short_content;
@property (nonatomic , copy) NSString              * short_title;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              view;
@end

NS_ASSUME_NONNULL_END
