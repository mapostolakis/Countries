//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGACountry, MGACountrySelectionDelegate, MGACoordinateSelectionDelegate;

@protocol MGACountryDetailsFactory <NSObject>

- (UIViewController *)createCountryDetailsViewForCountry:(id <MGACountry>)country delegate:(id <MGACountrySelectionDelegate>)delegate coordinateSelectionDelegate:(id <MGACoordinateSelectionDelegate>)coordinateSelectionDelegate;

@end