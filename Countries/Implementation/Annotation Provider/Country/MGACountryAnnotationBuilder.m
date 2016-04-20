//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAnnotationBuilder.h"
#import "MGACountryAnnotation.h"
#import "MGACountry.h"

@interface MGACountryAnnotationBuilder ()

@property (nonatomic, readonly) id <MGACountry> country;

@end

@implementation MGACountryAnnotationBuilder

- (instancetype)initWithCountry:(id <MGACountry>)country
{
    self = [super init];
    if (self) {
        _country = country;
    }
    return self;
}

- (MGACountryAnnotation *)build
{
    return [[MGACountryAnnotation alloc] initWithCoordinates:self.country.coordinates
                                                       title:self.country.name
                                                    subtitle:self.country.subregion];
}

@end