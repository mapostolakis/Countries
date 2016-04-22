//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardCountryAnnotationsBuilder.h"
#import "MGACountryAnnotation.h"
#import "MGACountry.h"

@implementation MGAStandardCountryAnnotationsBuilder

- (NSArray <id <MKAnnotation>> *)createCountryAnnotationsFromCountries:(NSArray <id <MGACountry>>*)countries
{
    NSMutableArray *annotations = [NSMutableArray array];
    for (id <MGACountry> country in countries) {
        MGACountryAnnotation *annotation = [[MGACountryAnnotation alloc] initWithCountry:country];
        [annotations addObject:annotation];
    }
    return [annotations copy];
}

@end