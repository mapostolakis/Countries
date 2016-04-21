//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import MapKit;

@protocol MGACountry;

@protocol MGACountryAnnotationsBuilder <NSObject>

- (NSArray <id <MKAnnotation>> *)createCountryAnnotationsFromCountries:(NSArray <id <MGACountry>>*)countries;

@end