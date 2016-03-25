//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryMapper.h"
#import "MGACountry.h"
#import "MGACountryGateway.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryMapperTest : XCTestCase
{
    id <MGACountryGateway> gateway;
    id <MGAResourceMapper> listMapper;
    MGACountryMapper *sut;
}
@end

@implementation MGACountryMapperTest

- (void)setUp
{
    [super setUp];

    gateway = mockProtocol(@protocol(MGACountryGateway));
    listMapper = mockProtocol(@protocol(MGAResourceMapper));

    sut = [[MGACountryMapper alloc] initWithGateway:gateway listMapper:listMapper];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Helpers

- (NSDictionary *)countryDictionary
{
    return @{
            @"name": @"Greece",
            @"capital": @"Athens",
            @"altSpellings": @[
                    @"GR",
            ],
            @"region": @"Europe",
            @"subregion": @"Southern Europe",
            @"population": @10846979,
            @"latlng": @[
                    @39,
                    @22
            ],
            @"area": @131990,
            @"timezones": @[
                    @"UTC+02:00"
            ],
            @"borders": @[
                    @"ALB",
            ],
            @"nativeName": @"Ελλάδα",
            @"alpha2Code": @"GR",
            @"alpha3Code": @"GRC",
            @"currencies": @[
                    @"EUR"
            ],
    };
}

- (id <MGACountry>)stubCountryFromGateway
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    NSString *code = @"GRC";
    [given([gateway countryWithAlpha3Code:code]) willReturn:country];
    return country;
}

- (NSArray *)stubMappedBorderCountries
{
    id mappedBorderCountries = @[];
    [given([listMapper mapResource:@[@"ALB"]]) willReturn:mappedBorderCountries];
    return mappedBorderCountries;
}

#pragma mark - Tests

- (void)test_conformsToMGAResourceMapper
{
    assertThat([MGACountryMapper new], conformsTo(@protocol(MGAResourceMapper)));
}

- (void)test_mapResource_returnsCountry
{
    id <MGACountry> country = [self stubCountryFromGateway];
    
    assertThat([sut mapResource:[self countryDictionary]], is(equalTo(country)));
}

- (void)test_mapResource_returnsMappedCountry
{
    [self stubCountryFromGateway];
    NSArray *countries = [self stubMappedBorderCountries];

    id <MGACountry> mappedCountry = [sut mapResource:[self countryDictionary]];

    [MKTVerify(mappedCountry) setAlpha2Code:@"GR"];
    [MKTVerify(mappedCountry) setName:@"Greece"];
    [MKTVerify(mappedCountry) setNativeName:@"Ελλάδα"];
    [MKTVerify(mappedCountry) setCapital:@"Athens"];
    [MKTVerify(mappedCountry) setAlternativeSpellings:@[@"GR"]];
    [MKTVerify(mappedCountry) setRegion:@"Europe"];
    [MKTVerify(mappedCountry) setSubregion:@"Southern Europe"];
    [MKTVerify(mappedCountry) setPopulation:@10846979];
    [MKTVerify(mappedCountry) setCoordinates:CLLocationCoordinate2DMake(39, 22)];
    [MKTVerify(mappedCountry) setArea:@131990];
    [MKTVerify(mappedCountry) setTimeZones:@[@"UTC+02:00"]];
    [MKTVerify(mappedCountry) setBorderCountries:countries];
    [MKTVerify(mappedCountry) setCurrencies:@[@"EUR"]];
}

@end
