//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionDataSource.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGASingleSectionDataSourceTest : XCTestCase
{
    NSArray *items;
    MGASingleSectionDataSource *sut;
}
@end

@implementation MGASingleSectionDataSourceTest

- (void)setUp
{
    [super setUp];

    items = mock([NSArray class]);
    sut = [[MGASingleSectionDataSource alloc] initWithItems:items];
}

- (void)test_conformsToMGADataSource
{
    assertThat(sut, conformsTo(@protocol(MGADataSource)));
}

- (void)test_numberOfSections_returns1
{
    assertThatInteger([sut numberOfSections], is(equalToInteger(1)));
}

- (void)test_numberOfObjectsInSection_returnsItemsCount
{
    [given(items.count) willReturnInteger:3];

    assertThatInteger([sut numberOfObjectsInSection:0], is(equalToInteger(3)));
}

- (void)test_objectAtIndexPath_returnsObject
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSObject *item = [NSObject new];
    [given(items[0]) willReturn:item];
    
    assertThat([sut objectAtIndexPath:indexPath], is(equalTo(item)));
}

@end
