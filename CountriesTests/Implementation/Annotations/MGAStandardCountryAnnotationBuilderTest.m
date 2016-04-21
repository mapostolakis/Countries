//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardCountryAnnotationsBuilder.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAStandardCountryAnnotationBuilderTest : XCTestCase
{
    NSArray <id <MKAnnotation>> *annotations;
    NSArray *countries;
    MGAStandardCountryAnnotationsBuilder *sut;
}
@end

@implementation MGAStandardCountryAnnotationBuilderTest

- (void)setUp
{
    [super setUp];

    NSValue *coordinate0 = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(123, 456)];
    NSValue *coordinate1 = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(234, 567)];
    id <MGACountry> country0 = [self stubCountryWithCoordinatesValue:coordinate0 name:@"a name" subregion:@"a subregion"];
    id <MGACountry> country1 = [self stubCountryWithCoordinatesValue:coordinate1 name:@"another name" subregion:@"another subregion"];
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
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given(country.coordinates) willReturn:value];
    [given(country.name) willReturn:name];
    [given(country.subregion) willReturn:subregion];
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
