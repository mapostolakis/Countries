//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryPinListMapViewDelegate.h"
#import "MGACountryAnnotation.h"
#import "MGACountrySelectionDelegate.h"
#import "MGAFlagURLProvider.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryPinListMapViewDelegateTest : XCTestCase
{
    id <MGAFlagURLProvider> flagProvider;
    id <MGACountrySelectionDelegate> delegate;
    MGACountryAnnotation *annotation;
    MKMapView *mapView;
    MGACountryPinListMapViewDelegate *sut;
}
@end

@implementation MGACountryPinListMapViewDelegateTest

- (void)setUp
{
    [super setUp];

    annotation = mock([MGACountryAnnotation class]);
    mapView = mock([MKMapView class]);
    delegate = mockProtocol(@protocol(MGACountrySelectionDelegate));
    flagProvider = mockProtocol(@protocol(MGAFlagURLProvider));
    sut = [[MGACountryPinListMapViewDelegate alloc] initWithFlagProvider:flagProvider delegate:delegate];
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

- (void)test_mapViewDidSelectAnnotationView_addsLeftAndRightCalloutAccessoryViews
{
    MKAnnotationView *view = [MKAnnotationView new];

    [sut mapView:mapView didSelectAnnotationView:view];

    assertThat(view.leftCalloutAccessoryView, is(instanceOf([UIImageView class])));
    assertThat(view.rightCalloutAccessoryView, is(instanceOf([UIButton class])));
}

- (void)test_delegate_selectsCountry_whenCalloutAccessoryControllerTapped
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given(annotation.country) willReturn:country];
    MKAnnotationView *view = mock([MKAnnotationView class]);
    [given(view.annotation) willReturn:annotation];

    [sut mapView:mapView annotationView:view calloutAccessoryControlTapped:anything()];

    [MKTVerify(delegate) didSelectCountry:country];
}

@end
