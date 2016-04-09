//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAPartialToFullCountryListMapper.h"
#import "MGACountry.h"
#import "MGACountryGateway.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAPartialToFullCountryListMapperTest : XCTestCase
{
    id <MGACountryGateway> gateway;
    MGAPartialToFullCountryListMapper *sut;
}
@end

@implementation MGAPartialToFullCountryListMapperTest

- (void)setUp
{
    [super setUp];

    gateway = mockProtocol(@protocol(MGACountryGateway));

    sut = [[MGAPartialToFullCountryListMapper alloc] initWithGateway:gateway];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_conformsToMGAResourceMapper
{
    assertThat(sut, conformsTo(@protocol(MGAResourceMapper)));
}

- (void)test_mapResource_returnsFullCountries
{
    id <MGACountry> partialCountry = mockProtocol(@protocol(MGACountry));
    [given(partialCountry.alpha3Code) willReturn:@"a code"];
    NSArray *partials = @[partialCountry];

    id <MGACountry> fullCountry = mockProtocol(@protocol(MGACountry));
    [given([gateway countryWithAlpha3Code:@"a code"]) willReturn:fullCountry];
    NSArray *fullCountries = @[fullCountry];
    
    assertThat([sut mapResource:partials], is(equalTo(fullCountries)));
}

@end
