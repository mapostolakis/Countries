//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAPartialToFullCountryListMapper.h"
#import "MGACountryGateway.h"
#import "MGACountry.h"

@interface MGAPartialToFullCountryListMapper ()

@property (nonatomic, readonly) id <MGACountryGateway> gateway;

@end

@implementation MGAPartialToFullCountryListMapper

- (instancetype)initWithGateway:(id <MGACountryGateway>)gateway
{
    self = [super init];
    if (self) {
        _gateway = gateway;
    }
    return self;
}

- (NSArray *)mapResource:(NSArray *)partials
{
    NSMutableArray *fullCountries = [NSMutableArray array];
    for (id <MGACountry> partialCountry in partials) {
        id <MGACountry> fullCountry = [self.gateway countryWithAlpha3Code:partialCountry.alpha3Code];
        [fullCountries addObject:fullCountry];
    }
    return [fullCountries copy];
}

@end