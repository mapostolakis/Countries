//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListServiceCommandBuilder.h"
#import "MGAFetchCountryListService.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAFetchCountryListServiceCommandBuilderTest : XCTestCase
{
    id <MGAFetchCountryListService> service;
    MGAFetchCountryListServiceCommandBuilder *sut;
}
@end

@implementation MGAFetchCountryListServiceCommandBuilderTest

- (void)setUp
{
    [super setUp];

    service = mockProtocol(@protocol(MGAFetchCountryListService));
    sut = [[MGAFetchCountryListServiceCommandBuilder alloc] initWithService:service];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_build_returnsCommand
{
    assertThat([[MGAFetchCountryListServiceCommandBuilder new] build], is(instanceOf([RACCommand class])));
}

- (void)test_service_fires_whenCommandExecutes
{
    [given([service fetchCountries]) willReturn:[RACSignal return:nil]];

    [[[sut build] execute:nil] asynchronouslyWaitUntilCompleted:nil];
    
    [MKTVerify(service) fetchCountries];
}

@end
