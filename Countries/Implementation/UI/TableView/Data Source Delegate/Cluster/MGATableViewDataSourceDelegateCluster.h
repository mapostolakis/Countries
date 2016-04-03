//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGATableViewDataSourceDelegateCluster : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithDataSourceDelegates:(NSArray <id <UITableViewDataSource, UITableViewDelegate>> *)items;

@end