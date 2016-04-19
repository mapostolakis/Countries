//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryPinListMapViewDelegate.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryPinListMapViewDelegateTest : XCTestCase
{
    id <MKAnnotation> annotation;
    MKMapView *mapView;
    MGACountryPinListMapViewDelegate *sut;
}
@end

@implementation MGACountryPinListMapViewDelegateTest

- (void)setUp
{
    [super setUp];

    annotation = mockProtocol(@protocol(MKAnnotation));
    mapView = mock([MKMapView class]);
    sut = [[MGACountryPinListMapViewDelegate alloc] init];
}

- (void)tearDown
{
    sut = nil;
    
    [super tearDown];
}

#pragma mark - Helpers

- (MKPinAnnotationView *)stubMapViewAnnotationViewDequeue
{
    MKPinAnnotationView *pinView = [MKPinAnnotationView new];
    [given([mapView dequeueReusableAnnotationViewWithIdentifier:@"MGACountryPinListMapViewDelegate"]) willReturn:pinView];
    return pinView;
}

#pragma mark - Tests

- (void)test_conformsToMKMapViewDelegate
{
    assertThat(sut, conformsTo(@protocol(MKMapViewDelegate)));
}

- (void)test_mapViewViewForAnnotation_returnsAMKPinAnnotationView
{
    [self stubMapViewAnnotationViewDequeue];

    MKAnnotationView *view = [sut mapView:mapView viewForAnnotation:annotation];

    assertThat(view, is(instanceOf([MKPinAnnotationView class])));
}

- (void)test_mapViewViewForAnnotation_returnsDequeuedAnnotationViewWithAnnotation
{
    MKPinAnnotationView *pinView = [self stubMapViewAnnotationViewDequeue];

    MKAnnotationView *view = [sut mapView:mapView viewForAnnotation:annotation];

    assertThat(view, is(equalTo(pinView)));
    assertThat(view.annotation, is(equalTo(annotation)));
    assertThatBool(view.canShowCallout, isTrue());
}

@end
