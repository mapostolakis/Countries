//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGACountryDetails;

@protocol MGACountryDetailsSelectionDelegate <NSObject>

- (void)didSelectCountryDetails:(id <MGACountryDetails>)countryDetails;

@end