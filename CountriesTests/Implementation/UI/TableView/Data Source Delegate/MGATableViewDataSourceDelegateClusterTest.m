//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewDataSourceDelegateCluster.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGATableViewDataSourceDelegateClusterTest : XCTestCase
{
    UITableView *tableView;
}
@end

@implementation MGATableViewDataSourceDelegateClusterTest

- (void)setUp
{
    [super setUp];

    tableView = mock([UITableView class]);
}

#pragma mark - Tests

- (void)test_conformsToUITableViewDataSource
{
    assertThat([MGATableViewDataSourceDelegateCluster new], conformsTo(@protocol(UITableViewDataSource)));
}

- (void)test_conformsToUITableViewDelegate
{
    assertThat([MGATableViewDataSourceDelegateCluster new], conformsTo(@protocol(UITableViewDelegate)));
}

- (void)test_conformsToMGATableViewCellRegister
{
    assertThat([MGATableViewDataSourceDelegateCluster new], conformsTo(@protocol(MGATableViewCellRegister)));
}

- (void)test_registerCellsForTableView_registersAllCells_whenDataSourceDelegateConformsToMGATableViewCellRegister
{
    id <MGATableViewCellRegister> dataSource0 = mockProtocol(@protocol(MGATableViewCellRegister));
    id <MGATableViewCellRegister> dataSource1 = mockProtocol(@protocol(MGATableViewCellRegister));

    NSArray *items = @[dataSource0, dataSource1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    [sut registerCellsForTableView:tableView];

    [MKTVerifyCount(dataSource0, times(1)) registerCellsForTableView:tableView];
    [MKTVerifyCount(dataSource1, times(1)) registerCellsForTableView:tableView];
}

#pragma mark - <UITableViewDataSource>

- (void)test_numberOfSections_returnsTotalNumberOfDataSourceDelegates
{
    NSArray *items = @[mockProtocol(@protocol(UITableViewDataSource)), mockProtocol(@protocol(UITableViewDataSource))];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    assertThatInteger([sut numberOfSectionsInTableView:tableView], is(equalToInteger(2)));
}

- (void)test_tableViewNumberOfRowsInSection_returnsTotalNumberOfRowsInSubSections
{
    id <UITableViewDataSource> dataSource0 = mockProtocol(@protocol(UITableViewDataSource));
    [given([dataSource0 numberOfSectionsInTableView:tableView]) willReturnInteger:2];
    [given([dataSource0 tableView:tableView numberOfRowsInSection:0]) willReturnInteger:5];

    id <UITableViewDataSource> dataSource1 = mockProtocol(@protocol(UITableViewDataSource));
    [given([dataSource1 numberOfSectionsInTableView:tableView]) willReturnInteger:1];
    [given([dataSource1 tableView:tableView numberOfRowsInSection:1]) willReturnInteger:3];

    NSArray *items = @[dataSource0, dataSource1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    assertThatInteger([sut tableView:tableView numberOfRowsInSection:0], is(equalToInteger(5)));
    assertThatInteger([sut tableView:tableView numberOfRowsInSection:1], is(equalToInteger(3)));
}

- (void)test_tableViewCellForRowAtIndexPath_returnsCellForRowForDataSourceDelegate
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:1];

    UITableViewCell *cell = mock([UITableViewCell class]);
    UITableViewCell *cell1 = mock([UITableViewCell class]);
    id <UITableViewDataSource> dataSource0 = mockProtocol(@protocol(UITableViewDataSource));
    [given([dataSource0 tableView:tableView cellForRowAtIndexPath:indexPath]) willReturn:cell];

    id <UITableViewDataSource> dataSource1 = mockProtocol(@protocol(UITableViewDataSource));
    [given([dataSource1 tableView:tableView cellForRowAtIndexPath:indexPath1]) willReturn:cell1];

    NSArray *items = @[dataSource0, dataSource1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    assertThat([sut tableView:tableView cellForRowAtIndexPath:indexPath], is(equalTo(cell)));
    assertThat([sut tableView:tableView cellForRowAtIndexPath:indexPath1], is(equalTo(cell1)));
}

#pragma mark - <UITableViewDelegate>

- (void)test_tableViewHeightForRowAtIndexPath_returnsHeightForRowForDataSourceDelegate
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:1];

    id <UITableViewDelegate> delegate0 = mockProtocol(@protocol(UITableViewDelegate));
    [given([delegate0 tableView:tableView heightForRowAtIndexPath:indexPath]) willReturnFloat:40.f];

    id <UITableViewDelegate> delegate1 = mockProtocol(@protocol(UITableViewDelegate));
    [given([delegate1 tableView:tableView heightForRowAtIndexPath:indexPath1]) willReturnFloat:50.f];

    NSArray *items = @[delegate0, delegate1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    assertThatFloat([sut tableView:tableView heightForRowAtIndexPath:indexPath], is(equalToFloat(40.f)));
    assertThatFloat([sut tableView:tableView heightForRowAtIndexPath:indexPath1], is(equalToFloat(50.f)));
}

- (void)test_tableViewTitleForHeaderInSection_returnsSectionTitleForDataSourceDelegate
{
    id <UITableViewDataSource> dataSource0 = mockProtocol(@protocol(UITableViewDataSource));
    [given([dataSource0 tableView:tableView titleForHeaderInSection:0]) willReturn:@"a title"];

    id <UITableViewDataSource> dataSource1 = mockProtocol(@protocol(UITableViewDataSource));

    NSArray *items = @[dataSource0, dataSource1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    assertThat([sut tableView:tableView titleForHeaderInSection:0], is(equalTo(@"a title")));
    assertThat([sut tableView:tableView titleForHeaderInSection:1], is(nilValue()));
}

- (void)test_tableViewHeightForHeaderInSection_returnsSectionHeightForDataSourceDelegate
{
    id <UITableViewDelegate> delegate0 = mockProtocol(@protocol(UITableViewDelegate));
    [given([delegate0 tableView:tableView heightForHeaderInSection:0]) willReturnFloat:40.f];

    id <UITableViewDelegate> delegate1 = mockProtocol(@protocol(UITableViewDelegate));

    NSArray *items = @[delegate0, delegate1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    assertThatFloat([sut tableView:tableView heightForHeaderInSection:0], is(equalToFloat(40.f)));
    assertThatFloat([sut tableView:tableView heightForHeaderInSection:1], is(equalToFloat(0.f)));
}

- (void)test_tableViewDidSelectRowAtIndexPath_delegatesSelection
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    id <UITableViewDelegate> delegate0 = mockProtocol(@protocol(UITableViewDelegate));
    id <UITableViewDelegate> delegate1 = mockProtocol(@protocol(UITableViewDelegate));

    NSArray *items = @[delegate0, delegate1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    [sut tableView:tableView didSelectRowAtIndexPath:indexPath];

    [MKTVerify(delegate0) tableView:tableView didSelectRowAtIndexPath:indexPath];
    [MKTVerifyCount(delegate1, never()) tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)test_tableViewDidSelectRowAtIndexPath_delegatesSelection_1
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];

    id <UITableViewDelegate> delegate0 = mockProtocol(@protocol(UITableViewDelegate));
    id <UITableViewDelegate> delegate1 = mockProtocol(@protocol(UITableViewDelegate));

    NSArray *items = @[delegate0, delegate1];
    MGATableViewDataSourceDelegateCluster *sut = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];

    [sut tableView:tableView didSelectRowAtIndexPath:indexPath];

    [MKTVerifyCount(delegate0, never()) tableView:tableView didSelectRowAtIndexPath:indexPath];
    [MKTVerify(delegate1) tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end