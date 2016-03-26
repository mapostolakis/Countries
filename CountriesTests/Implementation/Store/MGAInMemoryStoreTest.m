//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAInMemoryStore.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAInMemoryStoreTest : XCTestCase

@end

@implementation MGAInMemoryStoreTest

- (void)test_conformsToMGAStore
{
    assertThat([MGAInMemoryStore new], conformsTo(@protocol(MGAStore)));
}

- (void)test_save_persistsObject
{
    NSObject *object = [NSObject new];
    MGAInMemoryStore *sut = [MGAInMemoryStore new];

    [sut save:object];

    assertThat(sut.cachedObject, is(equalTo(object)));
}

@end
