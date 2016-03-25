//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataToJSONConverter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGADataToJSONConverterTest : XCTestCase
{
    MGADataToJSONConverter *sut;
}
@end

@implementation MGADataToJSONConverterTest

- (void)setUp
{
    [super setUp];

    sut = [MGADataToJSONConverter new];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_conformsToMGAConverter
{
    assertThat(sut, conformsTo(@protocol(MGAConverter)));
}

- (void)test_convert_sendsError_whenJSONIsInvalid
{
    id invalidJSON = [@"some invalid json data" dataUsingEncoding:NSUTF8StringEncoding];

    __block NSError *expectedError = nil;
    [[sut convert:invalidJSON] subscribeError:^(NSError *error) {
        expectedError = error;
    }];

    assertThat(expectedError, is(notNilValue()));
}

- (void)test_convert_sendsCompleted_whenJSONIsValid
{
    id data = [@"[{\"a key\" : \"a value\"}]" dataUsingEncoding:NSUTF8StringEncoding];

    __block BOOL completed = NO;
    [[sut convert:data] subscribeCompleted:^{
        completed = YES;
    }];

    assertThatBool(completed, isTrue());
}

- (void)test_convert_sendsNextMappedJSON
{
    id data = [@"[{\"a key\" : \"a value\"}]" dataUsingEncoding:NSUTF8StringEncoding];

    id json = [[sut convert:data] first];

    assertThat(json, is(equalTo(@[ @{ @"a key" : @"a value" } ])));
}

@end
