//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryMapper.h"
#import "MGACountry.h"
#import "MGACountryGateway.h"

@interface MGACountryMapper ()

@property (nonatomic, readonly) id <MGACountryGateway> gateway;
@property (nonatomic, readonly) id <MGAResourceMapper> listMapper;

@end

@implementation MGACountryMapper

- (instancetype)initWithGateway:(id <MGACountryGateway>)gateway listMapper:(id <MGAResourceMapper>)mapper
{
    self = [super init];
    if (self) {
        _gateway = gateway;
        _listMapper = mapper;
    }
    return self;
}

- (id <MGACountry>)mapResource:(NSDictionary *)resource
{
    id <MGACountry> country;
    if ([self resource:resource hasKeyAndValue:@"alpha3Code"]) {
        country = [self.gateway countryWithAlpha3Code:resource[@"alpha3Code"]];
    }
    if ([self resource:resource hasKeyAndValue:@"alpha2Code"]) {
        country.alpha2Code = resource[@"alpha2Code"];
    }
    if ([self resource:resource hasKeyAndValue:@"name"]) {
        country.name = resource[@"name"];
    }
    if ([self resource:resource hasKeyAndValue:@"nativeName"]) {
        country.nativeName = resource[@"nativeName"];
    }
    if ([self resource:resource hasKeyAndValue:@"capital"]) {
        country.capital = resource[@"capital"];
    }
    if ([self resource:resource hasKeyAndValue:@"altSpellings"]) {
        country.alternativeSpellings = resource[@"altSpellings"];
    }
    if ([self resource:resource hasKeyAndValue:@"region"]) {
        country.region = resource[@"region"];
    }
    if ([self resource:resource hasKeyAndValue:@"subregion"]) {
        country.subregion = resource[@"subregion"];
    }
    if ([self resource:resource hasKeyAndValue:@"population"]) {
        country.population = resource[@"population"];
    }
    if ([self resource:resource hasKeyAndValue:@"latlng"]) {
        NSArray <NSNumber *> *coordinates = resource[@"latlng"];
        double latitude = coordinates.firstObject.doubleValue;
        double longitude = coordinates.lastObject.doubleValue;
        country.coordinates = CLLocationCoordinate2DMake(latitude, longitude);
    }
    if ([self resource:resource hasKeyAndValue:@"area"]) {
        country.area = resource[@"area"];
    }
    if ([self resource:resource hasKeyAndValue:@"timezones"]) {
        country.timeZones = resource[@"timezones"];
    }
    if ([self resource:resource hasKeyAndValue:@"borders"]) {
        NSArray *borderCountries = resource[@"borders"];
        country.borderCountries = [self.listMapper mapResource:borderCountries];
    }
    if ([self resource:resource hasKeyAndValue:@"currencies"]) {
        country.currencies = resource[@"currencies"];
    }
    return country;
}

- (BOOL)resource:(NSDictionary *)resource hasKeyAndValue:(NSString *)key
{
    return resource != (id)[NSNull null] && resource[key] != [NSNull null];
}

@end