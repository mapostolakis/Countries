//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardCountryAnnotationsBuilder.h"
#import "MGACountryAnnotation.h"
#import "MGACountry.h"

@implementation MGAStandardCountryAnnotationsBuilder

- (NSArray <id <MKAnnotation>> *)createCountryAnnotationsFromCountries:(NSArray <id <MGACountry>> *)countries
{
    NSMutableArray *annotations = [NSMutableArray array];
    for (id <MGACountry> country in countries) {
        MGACountryAnnotation *annotation = [[MGACountryAnnotation alloc] initWithCoordinates:country.coordinates
                                                                                       title:country.name
                                                                                    subtitle:country.subregion];
        [annotations addObject:annotation];
    }
    return [annotations copy];
}

@end