//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import MapKit;

@protocol MGACountry;

@interface MGACountryAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) id <MGACountry> country;

- (instancetype)initWithCountry:(id <MGACountry>)country;

@end