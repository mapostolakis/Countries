//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetails.h"

@interface MGASingleValueCountryDetails : NSObject <MGACountryDetails>

- (instancetype)initWithName:(NSString *)name value:(NSString *)value;

@end