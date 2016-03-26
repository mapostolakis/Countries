//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAInMemoryStoreGateway.h"
#import "MGAInMemoryStore.h"
#import "MGACountry.h"
#import "MGAFlattenCountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAInMemoryStoreGatewayTest : XCTestCase
{
    MGAInMemoryStore *store;
    MGAInMemoryStoreGateway *sut;
}
@end

@implementation MGAInMemoryStoreGatewayTest

- (void)setUp
{
    [super setUp];

    store = mock([MGAInMemoryStore class]);
    sut = [[MGAInMemoryStoreGateway alloc] initWithStore:store];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_conformsToMGACountryGateway
{
    assertThat(sut, conformsTo(@protocol(MGACountryGateway)));
}

- (void)test_countryForAlpha3Code_returnsCountryWithAlpha3Code
{
    id <MGACountry> country = [sut countryWithAlpha3Code:@"code"];

    assertThat(country.alpha3Code, is(equalTo(@"code")));
}

- (void)test_countryForAlpha3Code_returnsCountry_whenCountryExists
{
    MGAFlattenCountry *country = [MGAFlattenCountry new];
    country.alpha3Code = @"code";

    [given(store.cachedObject) willReturn:@[country]];

    assertThat([sut countryWithAlpha3Code:@"code"], is(equalTo(country)));
}

@end
