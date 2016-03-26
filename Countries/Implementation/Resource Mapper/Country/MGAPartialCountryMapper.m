//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAPartialCountryMapper.h"
#import "MGACountryGateway.h"
#import "MGACountry.h"

@interface MGAPartialCountryMapper ()

@property (nonatomic, readonly) id <MGACountryGateway> gateway;

@end

@implementation MGAPartialCountryMapper

- (instancetype)initWithGateway:(id <MGACountryGateway>)gateway
{
    self = [super init];
    if (self) {
        _gateway = gateway;
    }
    return self;
}

- (id <MGACountry>)mapResource:(NSString *)code
{
    id <MGACountry> country;
    if (code) {
        country = [self.gateway countryWithAlpha3Code:code];
    }
    return country;
}

@end