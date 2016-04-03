//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAURLImageDataSourceDelegate.h"
#import "MGADataSource.h"
#import "MGAImageCell.h"
#import "UIImageView+MGAImageFetcher.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAURLImageDataSourceDelegateTest : XCTestCase
{
    NSIndexPath *indexPath;
    UITableView *tableView;
    id <MGADataSource> dataSource;
    MGAURLImageDataSourceDelegate *sut;
}
@end

@implementation MGAURLImageDataSourceDelegateTest

- (void)setUp
{
    [super setUp];

    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    tableView = mock([UITableView class]);
    dataSource = mockProtocol(@protocol(MGADataSource));
    sut = [[MGAURLImageDataSourceDelegate alloc] initWithDataSource:dataSource];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_conformsToUITableViewDataSource
{
    assertThat(sut, conformsTo(@protocol(UITableViewDataSource)));
}

- (void)test_conformsToUITableViewDelegate
{
    assertThat(sut, conformsTo(@protocol(UITableViewDelegate)));
}

- (void)test_conformsToMGATableViewCellRegister
{
    assertThat(sut, conformsTo(@protocol(MGATableViewCellRegister)));
}

- (void)test_registersCell
{
    [sut registerCellsForTableView:tableView];

    [MKTVerify(tableView) registerClass:[MGAImageCell class] forCellReuseIdentifier:@"MGAImageCell"];
}

- (void)test_numberOfSectionsInTableView_returnNumberOfSections
{
    [given([dataSource numberOfSections]) willReturnInteger:2];

    assertThatInteger([sut numberOfSectionsInTableView:anything()], is(equalToInteger(2)));
}

- (void)test_tableViewNumberOfRowsInSection_returnsNumberOfObjectsInSection
{
    [given([dataSource numberOfObjectsInSection:0]) willReturnInteger:3];

    assertThatInteger([sut tableView:anything() numberOfRowsInSection:0], is(equalToInteger(3)));
}

- (void)test_tableViewCellForRowAtIndexPath_returnsImageCell
{
    MGAImageCell *imageCell = mock([MGAImageCell class]);
    NSURL *url = mock([NSURL class]);

    [given([dataSource objectAtIndexPath:indexPath]) willReturn:url];
    [given([tableView dequeueReusableCellWithIdentifier:@"MGAImageCell"]) willReturn:imageCell];

    UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:indexPath];

    assertThat(cell, is(equalTo(imageCell)));
    [MKTVerify(cell) setImageForURL:url];
}

- (void)test_tableViewHeightForRowAtIndexPath_returns120
{
    assertThatFloat([sut tableView:anything() heightForRowAtIndexPath:anything()], is(equalToFloat(120.f)));
}

@end
