//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFlow.h"
#import "MGAListCountriesFactory.h"
#import "MGAShowCountryDetailsFactory.h"
#import "MGAViewControllerPresenter.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface MGAListCountriesFlowTest : XCTestCase
{
    id <MGAListCountriesFactory> listCountriesFactory;
    id <MGAShowCountryDetailsFactory> countryDetailsFactory;
    id <MGAViewControllerPresenter> listPresenter;
    id <MGAViewControllerPresenter> detailsPresenter;
    MGAListCountriesFlow *sut;
}
@end

@implementation MGAListCountriesFlowTest

- (void)setUp
{
    [super setUp];

    listPresenter = mockProtocol(@protocol(MGAViewControllerPresenter));
    detailsPresenter = mockProtocol(@protocol(MGAViewControllerPresenter));
    listCountriesFactory = mockProtocol(@protocol(MGAListCountriesFactory));
    countryDetailsFactory = mockProtocol(@protocol(MGAShowCountryDetailsFactory));

    sut = [[MGAListCountriesFlow alloc] initWithListCountriesFactory:listCountriesFactory
                                               countryDetailsFactory:countryDetailsFactory
                                                       listPresenter:listPresenter
                                                    detailsPresenter:detailsPresenter];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_start_presentsCountryListViewAsRoot
{
    UIViewController *viewController = [UIViewController new];
    [given([listCountriesFactory createListCountriesWithDelegate:sut]) willReturn:viewController];

    [sut start];

    [MKTVerify(listPresenter) present:viewController];
}

- (void)test_didSelectCountry_presentsCountryDetailsView
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    UIViewController *viewController = [UIViewController new];
    [given([countryDetailsFactory createCountryDetailsViewForCountry:country]) willReturn:viewController];

    [sut didSelectCountry:country];
    
    [MKTVerify(detailsPresenter) present:viewController];
}

@end
