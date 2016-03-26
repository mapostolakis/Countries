//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionEventDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGASingleSectionEventDataSourceTest : XCTestCase
{
    RACSubject *event;
    MGASingleSectionEventDataSource *sut;
}
@end

@implementation MGASingleSectionEventDataSourceTest

- (void)setUp
{
    [super setUp];

    event = [RACSubject subject];
    sut = [[MGASingleSectionEventDataSource alloc] initWithSignal:event];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_conformsToMGADataSource
{
    assertThat(sut, conformsTo(@protocol(MGADataSource)));
}

- (void)test_start_firesSignal
{
    __block BOOL fired = NO;
    [event subscribeNext:^(id x) {
        fired = YES;
    }];

    [sut start];

    [event sendNext:nil];

    assertThatBool(fired, isTrue());
}

- (void)test_numberOfSections_returns1
{
    assertThatInteger([sut numberOfSections], is(equalToInteger(1)));
}

- (void)test_numberOfObjectsInSection_returnsItemsCount
{
    [sut start];

    [event sendNext:@[ anything(), anything()]];

    assertThatInteger([sut numberOfObjectsInSection:0], is(equalToInteger(2)));
}

- (void)test_objectAtIndexPath_returnsObject
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSObject *item = [NSObject new];
    [sut start];

    [event sendNext:@[item]];

    assertThat([sut objectAtIndexPath:indexPath], is(equalTo(item)));
}

@end
