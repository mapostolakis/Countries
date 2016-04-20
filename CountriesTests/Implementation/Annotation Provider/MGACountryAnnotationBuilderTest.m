//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAnnotationBuilder.h"
#import "MGACountryAnnotation.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryAnnotationBuilderTest : XCTestCase
{
    MGACountryAnnotationBuilder *sut;
}
@end

@implementation MGACountryAnnotationBuilderTest

- (void)setUp
{
    [super setUp];
    
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    NSValue *coordinate = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(123, 456)];
    [given(country.coordinates) willReturn:coordinate];
    [given(country.name) willReturn:@"a country name"];
    [given(country.subregion) willReturn:@"a subregion"];
    
    sut = [[MGACountryAnnotationBuilder alloc] initWithCountry:country];
}

- (void)tearDown
{
    sut = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)test_coordinate_isSet
{
    MGACountryAnnotation *annotation = [sut build];

    assertThatDouble(annotation.coordinate.latitude, is(equalToDouble(123)));
    assertThatDouble(annotation.coordinate.longitude, is(equalToDouble(456)));
}

- (void)test_title_isSet
{
    MGACountryAnnotation *annotation = [sut build];

    assertThat(annotation.title, is(equalTo(@"a country name")));
}

- (void)test_subtitle_isSet
{
    MGACountryAnnotation *annotation = [sut build];

    assertThat(annotation.subtitle, is(equalTo(@"a subregion")));
}

@end
