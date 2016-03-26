//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAPartialCountryMapper.h"
#import "MGACountry.h"
#import "MGACountryGateway.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAPartialCountryMapperTest : XCTestCase
{
    id <MGACountryGateway> gateway;
    MGAPartialCountryMapper *sut;
}

@end

@implementation MGAPartialCountryMapperTest

- (void)setUp
{
    [super setUp];

    gateway = mockProtocol(@protocol(MGACountryGateway));

    sut = [[MGAPartialCountryMapper alloc] initWithGateway:gateway];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Helpers

- (id <MGACountry>)stubCountryFromGateway
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    NSString *code = @"GRC";
    [given([gateway countryWithAlpha3Code:code]) willReturn:country];
    return country;
}

#pragma mark - Tests

- (void)test_conformsToMGAResourceMapper
{
    assertThat(sut, conformsTo(@protocol(MGAResourceMapper)));
}

- (void)test_mapResource_returnsCountry
{
    id <MGACountry> country = [self stubCountryFromGateway];

    assertThat([sut mapResource:@"GRC"], is(equalTo(country)));
}

@end
