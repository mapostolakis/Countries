#import "MGACountry.h"//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAnnotation.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryAnnotationTest : XCTestCase
{
    MGACountryAnnotation *sut;
}
@end

@implementation MGACountryAnnotationTest

- (void)setUp
{
    [super setUp];

    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(123, 456);
    NSValue *value = [NSValue valueWithMKCoordinate:coordinates];
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given(country.name) willReturn:@"a name"];
    [given(country.subregion) willReturn:@"a subregion"];
    [given(country.coordinates) willReturn:value];
    sut = [[MGACountryAnnotation alloc] initWithCountry:country];
}

- (void)tearDown
{
    sut = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)test_conformsToMKAnnotation
{
    assertThat([MGACountryAnnotation new], conformsTo(@protocol(MKAnnotation)));
}

- (void)test_coordinates
{
    assertThatDouble(sut.coordinate.latitude, is(equalToDouble(123)));
    assertThatDouble(sut.coordinate.longitude, is(equalToDouble(456)));
}

- (void)test_title
{
    assertThat(sut.title, is(equalTo(@"a name")));
}

- (void)test_subtitle
{
    assertThat(sut.subtitle, is(equalTo(@"a subregion")));
}

@end
