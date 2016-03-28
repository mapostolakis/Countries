//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountrySelectionDelegate.h"

@protocol MGAViewControllerPresenter, MGAShowCountryDetailsFactory, MGAListCountriesFactory;

@interface MGAListCountriesFlow : NSObject <MGACountrySelectionDelegate>

- (instancetype)initWithListCountriesFactory:(id <MGAListCountriesFactory>)listCountriesFactory
                       countryDetailsFactory:(id <MGAShowCountryDetailsFactory>)countryDetailsFactory
                               listPresenter:(id <MGAViewControllerPresenter>)rootPresenter
                            detailsPresenter:(id <MGAViewControllerPresenter>)presenter;

- (void)start;

@end