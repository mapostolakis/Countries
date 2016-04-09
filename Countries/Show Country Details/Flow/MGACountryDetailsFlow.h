//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountrySelectionDelegate.h"

@protocol MGACountry, MGACountryDetailsFactory, MGAViewControllerPresenter;

@interface MGACountryDetailsFlow : NSObject <MGACountrySelectionDelegate>

- (instancetype)initWithCountry:(id <MGACountry>)country factory:(id <MGACountryDetailsFactory>)factory presenter:(id <MGAViewControllerPresenter>)presenter;

- (void)start;

@end