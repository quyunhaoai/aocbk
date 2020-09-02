//
//  CCBalanceViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCBalanceViewController : CCBaseTableViewController
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet KKButton *goPay;
@property (nonatomic,copy) NSString *price;
@end

NS_ASSUME_NONNULL_END
