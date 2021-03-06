//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGACountry, MGAViewControllerPresenter;
@class MGACountryDetailsFlow;

@protocol MGACountryDetailsFlowFactory <NSObject>

- (MGACountryDetailsFlow *)createFlowForCountry:(id <MGACountry>)country;

@end