//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGABinder.h"
@import UIKit;

@class RACCommand;

@interface MGACommandExecutionTableViewReloadBinder : NSObject <MGABinder>

- (instancetype)initWithCommand:(RACCommand *)command tableView:(UITableView *)tableView;

@end