//
//  CCBaseGroupShadowTableViewController.h
//  CunCunTong
//
//  Created by    on 2020/3/30.
//  Copyright © 2020   . All rights reserved.
//

#import "CCBaseViewController.h"
#import "GroupShadowTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCBaseGroupShadowTableViewController : CCBaseViewController
@property (nonatomic, strong) GroupShadowTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSoureArray;
@end

NS_ASSUME_NONNULL_END
