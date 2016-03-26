//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGACountrySelectionDelegate.h"

@protocol MGAServiceProvider, MGADataSourceProvider;

@interface MGARootUIFlow : NSObject <MGACountrySelectionDelegate>

@property (nonatomic, readonly) UIViewController *rootViewController;

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                           serviceProvider:(id <MGAServiceProvider>)serviceProvider;

@end