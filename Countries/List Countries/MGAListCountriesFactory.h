//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGACountrySelectionDelegate;

@protocol MGAListCountriesFactory <NSObject>

- (UIViewController *)createListCountriesWithDelegate:(id <MGACountrySelectionDelegate>)delegate;

@end