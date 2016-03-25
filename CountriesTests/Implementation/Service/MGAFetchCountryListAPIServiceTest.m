//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListAPIService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAFetchCountryListAPIServiceTest : XCTestCase
{
    NSURL *url;
    NSURLSession *session;
    MGAFetchCountryListAPIService *sut;
}
@end

@implementation MGAFetchCountryListAPIServiceTest

- (void)setUp
{
    [super setUp];

    url = [NSURL URLWithString:@"http://a.url"];
    session = mock([NSURLSession class]);

    sut = [[MGAFetchCountryListAPIService alloc] initWithSession:session url:url];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Helpers

- (NSURLSessionDataTask *)stubTask
{
    NSURLSessionDataTask *task = mock([NSURLSessionDataTask class]);
    [given([session dataTaskWithURL:anything() completionHandler:anything()]) willReturn:task];
    return task;
}

- (void(^)(NSData *data, NSURLResponse *response, NSError *error))stubCompletionBlock
{
    MKTArgumentCaptor *captor = [[MKTArgumentCaptor alloc] init];
    [MKTVerify(session) dataTaskWithURL:anything() completionHandler:[captor capture]];
    return [captor value];
}

#pragma mark - Tests

- (void)test_conformsToMGAFetchCountryListService
{
    assertThat([MGAFetchCountryListAPIService new], conformsTo(@protocol(MGAFetchCountryListService)));
}

- (void)test_fetchCountries_startsTask
{
    NSURLSessionDataTask *task = [self stubTask];

    [[sut fetchCountries] replayLast];

    [MKTVerify(task) resume];
}

- (void)test_fetchCountries_cancelsTask_whenDisposed
{
    NSURLSessionDataTask *task = [self stubTask];

    [[[sut fetchCountries] subscribeCompleted:^{}] dispose];

    [MKTVerify(task) cancel];
}

- (void)test_fetchCountries_sendsError_whenErrorIsReturned
{
    __block NSError *expectedError = nil;
    [[sut fetchCountries] subscribeError:^(NSError *returnedError) {
        expectedError = returnedError;
    }];

    NSError *error = mock([NSError class]);
    [self stubCompletionBlock](nil, nil, error);

    assertThat(expectedError, is(equalTo(error)));
}

- (void)test_fetchCountries_completes
{
    __block BOOL completed = NO;
    [[sut fetchCountries] subscribeCompleted:^{
       completed = YES;
    }];

    NSData *data = [NSData data];
    [self stubCompletionBlock](data, nil, nil);

    assertThatBool(completed, isTrue());
}

- (void)test_fetchCountries_sendsNextReceivedData
{
    __block id expectedResult = nil;
    [[sut fetchCountries] subscribeNext:^(id x) {
        expectedResult = x;
    }];

    NSData *data = [NSData data];
    [self stubCompletionBlock](data, nil, nil);

    assertThat(expectedResult, is(equalTo(data)));
}

@end
