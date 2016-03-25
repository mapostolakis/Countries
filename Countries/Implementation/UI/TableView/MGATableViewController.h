//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGATableViewController : UIViewController

@property (nonatomic, readonly, weak) UITableView *tableView;

- (instancetype)initWithDataSource:(id <UITableViewDataSource>)dataSource
                          delegate:(id <UITableViewDelegate>)delegate
                             style:(UITableViewStyle)style;

@end