//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGACountry, MGACountrySelectionDelegate;

@protocol MGAShowCountryDetailsFactory <NSObject>

- (UIViewController *)createCountryDetailsViewForCountry:(id <MGACountry>)country delegate:(id <MGACountrySelectionDelegate>)delegate;

@end