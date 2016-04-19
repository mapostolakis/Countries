//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAnnotation.h"

#import <XCTest/XCTest.h>

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
    sut = [[MGACountryAnnotation alloc] initWithCoordinates:coordinates title:@"a title" subtitle:@"a subtitle"];
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
    assertThat(sut.title, is(equalTo(@"a title")));
}

- (void)test_subtitle
{
    assertThat(sut.subtitle, is(equalTo(@"a subtitle")));
}

@end
