//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewCellRegister.h"

@protocol MGADataSource;

@interface MGAURLImageDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate, MGATableViewCellRegister>

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource;

@end