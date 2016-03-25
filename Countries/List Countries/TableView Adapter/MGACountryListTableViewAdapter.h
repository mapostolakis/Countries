//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGADataSource, MGACountrySelectionDelegate;

@interface MGACountryListTableViewAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource delegate:(id <MGACountrySelectionDelegate>)delegate;

@end