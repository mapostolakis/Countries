//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsViewModel.h"
#import "MGACountry.h"

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

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end