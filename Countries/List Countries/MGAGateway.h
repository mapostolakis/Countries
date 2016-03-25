//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGACountry;

@protocol MGAGateway <NSObject>

- (id <MGACountry>)countryWithAlpha3Code:(NSString *)code;

@end