//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@protocol MGACountry <NSObject>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nativeName;
@property (nonatomic, strong) NSString *alpha2Code;
@property (nonatomic, strong) NSString *alpha3Code;
@property (nonatomic, strong) NSString *capital;
@property (nonatomic, strong) NSArray <NSString *> *alternativeSpellings;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *subregion;
@property (nonatomic, strong) NSNumber *population;
@property (nonatomic, assign) CLLocationCoordinate2D coordinates;
@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, strong) NSArray <NSString *> *timeZones;
@property (nonatomic, strong) NSArray <id <MGACountry>> *borderCountries;
@property (nonatomic, strong) NSArray <NSString *> *currencies;

@end