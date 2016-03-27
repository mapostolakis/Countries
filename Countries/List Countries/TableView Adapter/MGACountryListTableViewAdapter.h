//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewCellRegister.h"

@protocol MGADataSource, MGACountrySelectionDelegate, MGAFlagURLProvider;

@interface MGACountryListTableViewAdapter : NSObject <UITableViewDataSource, UITableViewDelegate, MGATableViewCellRegister>

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource
                          delegate:(id <MGACountrySelectionDelegate>)delegate
                   flagURLProvider:(id <MGAFlagURLProvider>)provider;

@end