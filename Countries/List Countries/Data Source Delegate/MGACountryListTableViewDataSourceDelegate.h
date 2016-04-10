//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewCellRegister.h"

@protocol MGADataSource, MGACountrySelectionDelegate, MGAFlagURLProvider;

@interface MGACountryListTableViewDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate, MGATableViewCellRegister>

@property (nonatomic, strong) NSString *sectionTitle;

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource
                          delegate:(id <MGACountrySelectionDelegate>)delegate
                   flagURLProvider:(id <MGAFlagURLProvider>)provider;

@end