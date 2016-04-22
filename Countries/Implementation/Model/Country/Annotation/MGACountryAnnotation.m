//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAnnotation.h"
#import "MGACountry.h"

@implementation MGACountryAnnotation

- (instancetype)initWithCountry:(id <MGACountry>)country
{
    self = [super init];
    if (self) {
        _country = country;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.country.coordinates;
}

- (NSString *)title
{
    return self.country.name;
}

- (NSString *)subtitle
{
    return self.country.subregion;
}

@end