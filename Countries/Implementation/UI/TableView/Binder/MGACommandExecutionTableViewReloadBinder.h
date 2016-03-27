//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import UIKit;

@class RACCommand;

@interface MGACommandExecutionTableViewReloadBinder : NSObject

- (instancetype)initWithCommand:(RACCommand *)command tableView:(UITableView *)tableView;

- (void)bind;

@end