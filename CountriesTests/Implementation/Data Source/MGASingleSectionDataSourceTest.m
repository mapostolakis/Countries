//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionDataSource.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGASingleSectionDataSourceTest : XCTestCase
{
    MGASingleSectionDataSource *sut;
}
@end

@implementation MGASingleSectionDataSourceTest

- (void)setUp
{
    [super setUp];

    sut = [[MGASingleSectionDataSource alloc] init];
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

- (void)test_numberOfAllObjects_returnsObjectCount
{
    sut.items = @[ anything(), anything(), anything() ];

    assertThatInteger([sut numberOfAllObjects], is(equalToInteger(3)));
}

- (void)test_numberOfSections_returns1
{
    assertThatInteger([sut numberOfSections], is(equalToInteger(1)));
}

- (void)test_numberOfObjectsInSection_returnsObjectCount
{
    sut.items = @[ anything(), anything(), anything() ];

    assertThatInteger([sut numberOfObjectsInSection:0], is(equalToInteger(3)));
}

- (void)test_objectAtIndexPath_returnsObject
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSObject *item = [NSObject new];
    sut.items = @[ item ];

    assertThat([sut objectAtIndexPath:indexPath], is(equalTo(item)));
}

@end
