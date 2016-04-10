//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsFlow.h"
#import "MGACountryDetailsFactory.h"
#import "MGAViewControllerPresenter.h"
#import "MGACountry.h"
#import "MGAMapFactory.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryDetailsFlowTest : XCTestCase
{
    id <MGACountry> country;
    id <MGAViewControllerPresenter> presenter;
    id <MGAViewControllerPresenter> selectionPresenter;
    id <MGACountryDetailsFactory> factory;
    id <MGAMapFactory> mapFactory;

    MGACountryDetailsFlow *sut;
}
@end

@implementation MGACountryDetailsFlowTest

- (void)setUp
{
    [super setUp];

    factory = mockProtocol(@protocol(MGACountryDetailsFactory));
    mapFactory = mockProtocol(@protocol(MGAMapFactory));

    presenter = mockProtocol(@protocol(MGAViewControllerPresenter));
    selectionPresenter = mockProtocol(@protocol(MGAViewControllerPresenter));
    country = mockProtocol(@protocol(MGACountry));
    sut  = [[MGACountryDetailsFlow alloc] initWithCountry:country
                                                  factory:factory
                                               mapFactory:mapFactory
                                       selectionPresenter:selectionPresenter
                                                presenter:presenter];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_conformsToMGACountrySelectionDelegate
{
    assertThat(sut, conformsTo(@protocol(MGACountrySelectionDelegate)));
}

- (void)test_conformsToMGACoordinateSelectionDelegate
{
    assertThat(sut, conformsTo(@protocol(MGACoordinateSelectionDelegate)));
}

- (void)test_start_presentsCountryDetailsView
{
    UIViewController *viewController = [UIViewController new];
    [given([factory createCountryDetailsViewForCountry:country delegate:sut coordinateSelectionDelegate:sut]) willReturn:viewController];
    
    [sut start];

    [MKTVerify(presenter) present:viewController];
}

- (void)test_didSelectCountry_presentsCountryDetailsViewForThatCountry
{
    id <MGACountry> detailCountry = mockProtocol(@protocol(MGACountry));
    UIViewController *viewController = [UIViewController new];
    [given([factory createCountryDetailsViewForCountry:detailCountry delegate:sut coordinateSelectionDelegate:sut]) willReturn:viewController];

    [sut didSelectCountry:detailCountry];

    [MKTVerify(selectionPresenter) present:viewController];
}

- (void)test_didSelectCoordinates_presentsMapView
{
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(123, 456);
    UIViewController *viewController = [UIViewController new];

    [given([mapFactory createMapViewForCoordinates:coordinates]) willReturn:viewController];

    [sut didSelectCoordinates:coordinates];

    [MKTVerify(presenter) present:viewController];
}

@end
