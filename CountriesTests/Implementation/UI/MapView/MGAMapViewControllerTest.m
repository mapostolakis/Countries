//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAMapViewController.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAMapViewControllerTest : XCTestCase
{
    id <MKMapViewDelegate> delegate;
    MGAMapViewController *sut;
}
@end

@implementation MGAMapViewControllerTest

- (void)setUp
{
    [super setUp];

    delegate = mockProtocol(@protocol(MKMapViewDelegate));
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(123, 456);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 123, 456);
    sut = [[MGAMapViewController alloc] initWithRegion:region delegate:delegate];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_mapViewDelegate_isSet
{
    assertThat(sut.mapView.delegate, is(equalTo(delegate)));
}

@end
