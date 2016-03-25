//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryListTableViewAdapter.h"
#import "MGADataSource.h"
#import "MGACountrySelectionDelegate.h"
#import "MGACountry.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryListTableViewAdapterTest : XCTestCase
{
    UITableView *tableView;
    NSIndexPath *indexPath;
    id <MGADataSource> dataSource;
    id <MGACountrySelectionDelegate> delegate;
    MGACountryListTableViewAdapter *sut;
}

@end

@implementation MGACountryListTableViewAdapterTest

- (void)setUp
{
    [super setUp];

    tableView = mock([UITableView class]);
    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    dataSource = mockProtocol(@protocol(MGADataSource));
    delegate = mockProtocol(@protocol(MGACountrySelectionDelegate));
    sut = [[MGACountryListTableViewAdapter alloc] initWithDataSource:dataSource delegate:delegate];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Helpers

- (void)test_conformsToUITableViewDataSource
{
    assertThat(sut, conformsTo(@protocol(UITableViewDataSource)));
}

- (void)test_conformsToUITableViewDelegate
{
    assertThat(sut, conformsTo(@protocol(UITableViewDelegate)));
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

- (void)test_tableViewCellForRowAtIndexPath_returnsCountryCell
{
    UITableViewCell *countryCell = mock([UITableViewCell class]);
    [given(countryCell.textLabel) willReturn:mock([UILabel class])];
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given(country.name) willReturn:@"a country name"];
    [given([dataSource objectAtIndexPath:indexPath]) willReturn:country];
    [given([tableView dequeueReusableCellWithIdentifier:@"MGACountryCell"]) willReturn:countryCell];

    UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:indexPath];

    assertThat(cell, is(equalTo(countryCell)));
    [MKTVerify(cell.textLabel) setText:@"a country name"];
}

- (void)test_tableViewHeightForRowAtIndexPath_returns44
{
    assertThatFloat([sut tableView:anything() heightForRowAtIndexPath:anything()], is(equalToFloat(44.f)));
}

- (void)test_tableViewDidSelectRowAtIndexPath_selectsCountry
{
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given([dataSource objectAtIndexPath:indexPath]) willReturn:country];

    [sut tableView:anything() didSelectRowAtIndexPath:indexPath];

    [MKTVerify(delegate) didSelectCountry:country];
}

@end
