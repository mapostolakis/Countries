//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsFlow.h"
#import "MGACountryDetailsFactory.h"
#import "MGAViewControllerPresenter.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryDetailsFlowTest : XCTestCase
{
    id <MGACountry> country;
    id <MGAViewControllerPresenter> presenter;
    id <MGACountryDetailsFactory> factory;
    MGACountryDetailsFlow *sut;
}
@end

@implementation MGACountryDetailsFlowTest

- (void)setUp
{
    [super setUp];

    factory = mockProtocol(@protocol(MGACountryDetailsFactory));
    presenter = mockProtocol(@protocol(MGAViewControllerPresenter));
    country = mockProtocol(@protocol(MGACountry));
    sut  = [[MGACountryDetailsFlow alloc] initWithCountry:country factory:factory presenter:presenter];
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

- (void)test_start_presentsCountryDetailsView
{
    UIViewController *viewController = [UIViewController new];
    [given([factory createCountryDetailsViewForCountry:country delegate:anything()]) willReturn:viewController];
    
    [sut start];

    [MKTVerify(presenter) present:viewController];
}

- (void)test_didSelectCountry_presentsCountryDetailsViewForThatCountry
{
    id <MGACountry> detailCountry = mockProtocol(@protocol(MGACountry));
    UIViewController *viewController = [UIViewController new];
    [given([factory createCountryDetailsViewForCountry:detailCountry delegate:anything()]) willReturn:viewController];

    [sut didSelectCountry:detailCountry];

    [MKTVerify(presenter) present:viewController];
}

@end
