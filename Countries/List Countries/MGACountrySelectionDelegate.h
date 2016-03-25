//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGACountry;

@protocol MGACountrySelectionDelegate <NSObject>

- (void)didSelectCountry:(id <MGACountry>)country;

@end