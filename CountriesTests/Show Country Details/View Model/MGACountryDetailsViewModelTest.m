//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsViewModel.h"
#import "MGAMutableCountryDetails.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryDetailsViewModelTest : XCTestCase
{
    id <MGACountry> country;
    MGACountryDetailsViewModel *sut;
}
@end

@implementation MGACountryDetailsViewModelTest

- (void)setUp
{
    [super setUp];

    country = mockProtocol(@protocol(MGACountry));
    sut = [[MGACountryDetailsViewModel alloc] initWithCountry:country];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_area
{
    [given(country.area) willReturn:@1234567];

    assertThat([sut area], is(equalTo(@"1,234,567 Km\u00b2")));
}

- (void)test_population
{
    [given(country.population) willReturn:@1234567];

    assertThat([sut population], is(equalTo(@"1,234,567")));
}

- (void)test_areaTitle
{
    assertThat([sut areaTitle], is(equalTo(@"Area")));
}

- (void)test_populationTitle
{
    assertThat([sut populationTitle], is(equalTo(@"Population")));
}

- (void)test_bordersTitle
{
    assertThat([sut bordersTitle], is(equalTo(@"Borders")));
}

- (void)test_regionTitle
{
    assertThat([sut regionTitle], is(equalTo(@"Region")));
}

- (void)test_subregionTitle
{
    assertThat([sut subregionTitle], is(equalTo(@"Subregion")));
}

- (void)test_capitalTitle
{
    assertThat([sut capitalTitle], is(equalTo(@"Capital")));
}

- (void)test_nativeNameTitle
{
    assertThat([sut nativeNameTitle], is(equalTo(@"Native Name")));
}

- (void)test_coordinatesTitle
{
    assertThat([sut coordinatesTitle], is(equalTo(@"Coordinates")));
}

- (void)test_timeZonesTitle
{
    assertThat([sut timeZonesTitle], is(equalTo(@"Time Zones")));
}

- (void)test_timeZones
{
    MGAMutableCountryDetails *countryDetails = [[MGAMutableCountryDetails alloc] init];
    countryDetails.value = @"a timezone";

    [given(country.timeZones) willReturn:@[@"a timezone"]];

    assertThat([sut timeZones], is(equalTo(@[countryDetails])));
}

@end
