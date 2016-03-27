//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGATableViewCellRegister <NSObject>

- (void)registerCellsForTableView:(UITableView *)tableView;

@end