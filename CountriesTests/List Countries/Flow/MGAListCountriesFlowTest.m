//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFlow.h"
#import "MGAListCountriesFactory.h"
#import "MGAViewControllerPresenter.h"
#import "MGACountry.h"
#import "MGACountryDetailsFlowFactory.h"
#import "MGACountryDetailsFlow.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface MGAListCountriesFlowTest : XCTestCase
{
    id <MGAListCountriesFactory> factory;
    id <MGAViewControllerPresenter> presenter;
    id <MGACountryDetailsFlowFactory> flowFactory;
    MGAListCountriesFlow *sut;
}
@end

@implementation MGAListCountriesFlowTest

- (void)setUp
{
    [super setUp];

    presenter = mockProtocol(@protocol(MGAViewControllerPresenter));
    factory = mockProtocol(@protocol(MGAListCountriesFactory));
    flowFactory = mockProtocol(@protocol(MGACountryDetailsFlowFactory));

    sut = [[MGAListCountriesFlow alloc] initWithFactory:factory presenter:presenter flowFactory:flowFactory];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_start_presentsCountryListViewAsRoot
{
    UIViewController *viewController = [UIViewController new];
    [given([factory createListCountriesWithDelegate:sut]) willReturn:viewController];

    [sut start];

    [MKTVerify(presenter) present:viewController];
}

- (void)test_didSelectCountry_presentsCountryDetailsView
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));

    MGACountryDetailsFlow *flow = mock([MGACountryDetailsFlow class]);
    [given([flowFactory createFlowForCountry:country]) willReturn:flow];

    [sut didSelectCountry:country];
    
    [(MGACountryDetailsFlow *)MKTVerify(flow) start];
}

@end
