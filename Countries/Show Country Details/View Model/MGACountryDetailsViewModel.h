//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGACountry, MGACountryDetails;

@interface MGACountryDetailsViewModel : NSObject

- (instancetype)initWithCountry:(id <MGACountry>)country;

- (NSString *)area;
- (NSString *)areaTitle;
- (NSString *)population;
- (NSString *)populationTitle;
- (NSString *)bordersTitle;
- (NSString *)regionTitle;
- (NSString *)subregionTitle;
- (NSString *)capitalTitle;
- (NSString *)nativeNameTitle;
- (NSString *)coordinatesTitle;
- (NSArray <id <MGACountryDetails>> *)timeZones;
- (NSString *)timeZonesTitle;
- (NSArray <id <MGACountryDetails>> *)alternativeSpellings;
- (NSString *)alternativeSpellingsTitle;

@end