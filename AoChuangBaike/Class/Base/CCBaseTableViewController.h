//
//  CCBaseTableViewController.h
//  CunCunTong
//
//  Created by    on 2020/3/13.
//  Copyright © 2020   . All rights reserved.
//

#import "CCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBaseTableViewController : CCBaseViewController

@property (strong, nonatomic) NSMutableArray *dataSoureArray;   

@property (nonatomic,strong) UITableView *tableView;

@property (strong, nonatomic) NSArray *titlesArray;   

@property (strong, nonatomic) NSMutableArray *baseTableDataArray;   

/**
 初始化类

 @param style 表风格类型
 @return 当前类
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;


- (void)tableViewDidSelect:(NSIndexPath *)indexPath;

/// 添加下拉刷新
- (void)addTableViewRefresh;

- (void)clickBaseButtonWithType:(KKBarButtonType)type item:(BaseModel *)item;



@end

NS_ASSUME_NONNULL_END
