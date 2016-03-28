//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGAShowCountryDetailsFactory <NSObject>

- (UIViewController *)createCountryDetailsViewForCountryWithAlpha3Code:(NSString *)code;

@end