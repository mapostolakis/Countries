//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountrySelectionDelegate.h"
#import "MGACoordinateSelectionDelegate.h"

@protocol MGACountry, MGACountryDetailsFactory, MGAMapFactory, MGAViewControllerPresenter;

@interface MGACountryDetailsFlow : NSObject <MGACountrySelectionDelegate, MGACoordinateSelectionDelegate>

- (instancetype)initWithCountry:(id <MGACountry>)country factory:(id <MGACountryDetailsFactory>)factory mapFactory:(id <MGAMapFactory>)mapFactory selectionPresenter:(id <MGAViewControllerPresenter>)selectionPresenter presenter:(id <MGAViewControllerPresenter>)presenter;

- (void)start;

@end