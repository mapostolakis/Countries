//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGADataSource, MGACountryDetailsSelectionDelegate;

@interface MGACountryDetailsDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithSectionTitle:(NSString *)title
                          dataSource:(id <MGADataSource>)dataSource
                            delegate:(id <MGACountryDetailsSelectionDelegate>)delegate;

@end