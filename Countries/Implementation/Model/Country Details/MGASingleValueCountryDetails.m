//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleValueCountryDetails.h"

@implementation MGASingleValueCountryDetails

@synthesize name = _name, value = _value;

- (instancetype)initWithName:(NSString *)name value:(NSString *)value
{
    self = [super init];
    if (self) {
        _name = name;
        _value = value;
    }
    return self;
}

@end