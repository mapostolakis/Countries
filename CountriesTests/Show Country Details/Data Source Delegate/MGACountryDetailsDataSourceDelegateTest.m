//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsDataSourceDelegate.h"
#import "MGADataSource.h"
#import "MGACountryDetails.h"
#import "MGACountryDetailsSelectionDelegate.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryDetailsDataSourceDelegateTest : XCTestCase
{
    NSIndexPath *indexPath;
    UITableView *tableView;
    id <MGADataSource> dataSource;
    id <MGACountryDetailsSelectionDelegate> delegate;
    MGACountryDetailsDataSourceDelegate *sut;
}
@end

@implementation MGACountryDetailsDataSourceDelegateTest

- (void)setUp
{
    [super setUp];

    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    tableView = mock([UITableView class]);
    dataSource = mockProtocol(@protocol(MGADataSource));
    delegate = mockProtocol(@protocol(MGACountryDetailsSelectionDelegate));
    sut = [[MGACountryDetailsDataSourceDelegate alloc] initWithSectionTitle:@"a section title" dataSource:dataSource delegate:delegate];
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
    UITableViewCell *countryDetailsCell = mock([UITableViewCell class]);
    [given(countryDetailsCell.textLabel) willReturn:mock([UILabel class])];
    id <MGACountryDetails> countryDetails = mockProtocol(@protocol(MGACountryDetails));
    [given(countryDetails.value) willReturn:@"a value"];

    [given([dataSource objectAtIndexPath:indexPath]) willReturn:countryDetails];
    [given([tableView dequeueReusableCellWithIdentifier:@"Cell"]) willReturn:countryDetailsCell];

    UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:indexPath];

    assertThat(cell, is(equalTo(countryDetailsCell)));
    [MKTVerify(cell.textLabel) setText:@"a value"];
}

- (void)test_tableViewTitleForHeaderInSection_returnsSectionTitle
{
    assertThat([sut tableView:tableView titleForHeaderInSection:0], is(equalTo(@"a section title")));
    assertThat([sut tableView:tableView titleForHeaderInSection:1], is(equalTo(@"a section title")));
}

- (void)test_tableViewHeightForRowAtIndexPath_returns44
{
    assertThatFloat([sut tableView:anything() heightForRowAtIndexPath:anything()], is(equalToFloat(44.f)));
}

- (void)test_tableViewHeightForHeaderInSection_returnsDefaultValue
{
    assertThatFloat([sut tableView:anything() heightForHeaderInSection:0], is(equalToFloat(UITableViewAutomaticDimension)));
    assertThatFloat([sut tableView:anything() heightForHeaderInSection:1], is(equalToFloat(UITableViewAutomaticDimension)));
}

- (void)test_tableViewDidSelectRowAtIndexPath_selectsCountry
{
    id <MGACountryDetails> countryDetails = mockProtocol(@protocol(MGACountryDetails));
    [given([dataSource objectAtIndexPath:indexPath]) willReturn:countryDetails];

    [sut tableView:anything() didSelectRowAtIndexPath:indexPath];

    [MKTVerify(delegate) didSelectCountryDetails:countryDetails];
}

@end
