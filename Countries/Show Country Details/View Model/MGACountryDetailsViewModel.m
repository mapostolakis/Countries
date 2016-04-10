//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsViewModel.h"
#import "MGACountry.h"
#import "MGAMutableCountryDetails.h"

@interface MGACountryDetailsViewModel ()

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, readonly) id <MGACountry> country;

@end

@implementation MGACountryDetailsViewModel

- (instancetype)initWithCountry:(id <MGACountry>)country
{
    self = [super init];
    if (self) {
        _country = country;
    }
    return self;
}

- (NSNumberFormatter *)numberFormatter
{
    if (_numberFormatter == nil) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return _numberFormatter;
}

- (NSString *)area
{
    return [NSString stringWithFormat:@"%@ Km\u00b2", [self.numberFormatter stringFromNumber:self.country.area]];
}

- (NSString *)areaTitle
{
    return @"Area";
}

- (NSString *)population
{
    return [self.numberFormatter stringFromNumber:self.country.population];
}

- (NSString *)populationTitle
{
    return @"Population";
}

- (NSString *)bordersTitle
{
    return @"Borders";
}

- (NSString *)regionTitle
{
    return @"Region";
}

- (NSString *)subregionTitle
{
    return @"Subregion";
}

- (NSString *)capitalTitle
{
    return @"Capital";
}

- (NSString *)nativeNameTitle
{
    return @"Native Name";
}

- (NSString *)coordinatesTitle
{
    return @"Coordinates";
}

- (NSArray <id <MGACountryDetails>> *)timeZones
{
    NSMutableArray *details = [NSMutableArray array];
    for (NSString *timeZone in self.country.timeZones) {
        id <MGACountryDetails> countryDetail = [[MGAMutableCountryDetails alloc] init];
        countryDetail.value = timeZone;
        [details addObject:countryDetail];
    }
    return [details copy];
}

- (NSString *)timeZonesTitle
{
    return @"Time Zones";
}

- (NSString *)alternativeSpellingsTitle
{
    return @"Alternative Spellings";
}

- (NSArray <id <MGACountryDetails>> *)alternativeSpellings
{
    NSMutableArray *details = [NSMutableArray array];
    for (NSString *spelling in self.country.alternativeSpellings) {
        id <MGACountryDetails> countryDetail = [[MGAMutableCountryDetails alloc] init];
        countryDetail.value = spelling;
        [details addObject:countryDetail];
    }
    return [details copy];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end