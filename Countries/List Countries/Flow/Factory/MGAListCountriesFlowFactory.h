//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGAListCountriesFlow;

@protocol MGAListCountriesFlowFactory <NSObject>

- (MGAListCountriesFlow *)createCountryListFlow;
- (MGAListCountriesFlow *)createMappedCountryListFlow;

@end