//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewCellRegister.h"

@interface MGATableViewDataSourceDelegateCluster : NSObject <UITableViewDataSource, UITableViewDelegate, MGATableViewCellRegister>

- (instancetype)initWithDataSourceDelegates:(NSArray <id <UITableViewDataSource, UITableViewDelegate>> *)items;

@end