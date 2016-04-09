//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountrySelectionDelegate.h"

@protocol MGAViewControllerPresenter, MGAListCountriesFactory, MGACountryDetailsFlowFactory;

@interface MGAListCountriesFlow : NSObject <MGACountrySelectionDelegate>

- (instancetype)initWithFactory:(id <MGAListCountriesFactory>)factory
                      presenter:(id <MGAViewControllerPresenter>)rootPresenter
                    flowFactory:(id <MGACountryDetailsFlowFactory>)flowFactory;

- (void)start;

@end