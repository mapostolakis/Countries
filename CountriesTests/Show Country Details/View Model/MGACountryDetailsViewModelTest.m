//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsViewModel.h"
#import "MGAFlattenCountry.h"

#import <XCTest/XCTest.h>

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

    country = [[MGAFlattenCountry alloc] init];
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
    country.area = @1234567;

    assertThat([sut area], is(equalTo(@"1,234,567 Km\u00b2")));
}

- (void)test_population
{
    country.population = @1234567;

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

@end
