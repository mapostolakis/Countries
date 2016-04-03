//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleObjectDataSource.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGASingleObjectDataSourceTestTest : XCTestCase
{
    MGASingleObjectDataSource *sut;
}
@end

@implementation MGASingleObjectDataSourceTestTest

- (void)setUp
{
    [super setUp];

    sut = [[MGASingleObjectDataSource alloc] init];
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

- (void)test_numberOfSections_returns1
{
    assertThatInteger([sut numberOfSections], is(equalToInteger(1)));
}

- (void)test_numberOfObjectsInSection_returns1
{
    assertThatInteger([sut numberOfObjectsInSection:0], is(equalToInteger(1)));
}

- (void)test_objectAtIndexPath_returnsValue
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSObject *item = [NSObject new];

    sut.value = item;

    assertThat([sut objectAtIndexPath:indexPath], is(equalTo(item)));
}

@end
