//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListResourceMapper.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAListResourceMapperTest : XCTestCase
{
    id <MGAResourceMapper> resourceMapper;
    MGAListResourceMapper *sut;
}
@end

@implementation MGAListResourceMapperTest

- (void)setUp
{
    [super setUp];

    resourceMapper = mockProtocol(@protocol(MGAResourceMapper));
    sut = [[MGAListResourceMapper alloc] initWithResourceMapper:resourceMapper];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_conformsToMGAResourceMapper
{
    assertThat(sut, conformsTo(@protocol(MGAResourceMapper)));
}

- (void)test_mapResource_returnsAnArray
{
    assertThat([sut mapResource:@[]], is(instanceOf([NSArray class])));
}

- (void)test_mapResource_returnsAnArrayOfMappedResources
{
    NSArray *resources =  @[ @{ @"a key" : @"a value" } ];
    id mappedResource = [NSObject new];
    [given([resourceMapper mapResource:resources.firstObject]) willReturn:mappedResource];

    NSArray *mappedResources = [sut mapResource:resources];

    assertThat(mappedResources, is(equalTo(@[mappedResource])));
}

@end
