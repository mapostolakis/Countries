//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardCountryAnnotationsBuilder.h"
#import "MGACountry.h"
#import "MGACountryAnnotation.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAStandardCountryAnnotationsBuilderTest : XCTestCase
{
    NSArray *annotations;
    NSArray *countries;
    MGAStandardCountryAnnotationsBuilder *sut;
}
@end

@implementation MGAStandardCountryAnnotationsBuilderTest

- (void)setUp
{
    [super setUp];

    NSValue *coordinate0 = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(123, 456)];
    NSValue *coordinate1 = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(234, 567)];
    id <MGACountry> country0 = [self stubCountryWithCoordinatesValue:coordinate0 name:@"a name" subregion:@"a subregion" alpha2Code:@"a code"];
    id <MGACountry> country1 = [self stubCountryWithCoordinatesValue:coordinate1 name:@"another name" subregion:@"another subregion" alpha2Code:@"another code"];
    countries = @[country0, country1];

    sut = [[MGAStandardCountryAnnotationsBuilder alloc] init];
    annotations = [sut createCountryAnnotationsFromCountries:countries];
}

- (void)tearDown
{
    sut = nil;
    
    [super tearDown];
}

#pragma mark - Helpers

- (id <MGACountry>)stubCountryWithCoordinatesValue:(NSValue *)value
                                              name:(NSString *)name
                                         subregion:(NSString *)subregion
                                        alpha2Code:(NSString *)code
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given(country.coordinates) willReturn:value];
    [given(country.name) willReturn:name];
    [given(country.subregion) willReturn:subregion];
    [given(country.alpha2Code) willReturn:code];
    return country;
}


#pragma mark - Tests

- (void)test_conformsToMGACountryAnnotationsBuilder
{
    assertThat(sut, conformsTo(@protocol(MGACountryAnnotationsBuilder)));
}

- (void)test_createCountryAnnotationsForCountries_createsAnnotationsWithCountryCoordinates
{
    assertThatDouble([annotations.firstObject coordinate].latitude, is(equalToDouble(123)));
    assertThatDouble([annotations.firstObject coordinate].longitude, is(equalToDouble(456)));
    assertThatDouble([annotations.lastObject coordinate].latitude, is(equalToDouble(234)));
    assertThatDouble([annotations.lastObject coordinate].longitude, is(equalToDouble(567)));
}

- (void)test_createCountryAnnotationsForCountries_createsAnnotationsWithCountryName
{
    assertThat([annotations.firstObject title], is(equalTo(@"a name")));
    assertThat([annotations.lastObject title], is(equalTo(@"another name")));
}
- (void)test_createCountryAnnotationsForCountries_createsAnnotationsWithCountrySubregion
{
    assertThat([annotations.firstObject subtitle], is(equalTo(@"a subregion")));
    assertThat([annotations.lastObject subtitle], is(equalTo(@"another subregion")));
}

@end
