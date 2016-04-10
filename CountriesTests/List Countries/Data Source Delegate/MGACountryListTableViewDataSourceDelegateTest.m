//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryListTableViewDataSourceDelegate.h"
#import "MGADataSource.h"
#import "MGACountrySelectionDelegate.h"
#import "MGACountry.h"
#import "MGACountryAndFlagCell.h"
#import "MGAFlagURLProvider.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryListTableViewDataSourceDelegateTest : XCTestCase
{
    UITableView *tableView;
    NSIndexPath *indexPath;
    id <MGADataSource> dataSource;
    id <MGACountrySelectionDelegate> delegate;
    id <MGAFlagURLProvider> flagURLProvider;
    MGACountryListTableViewDataSourceDelegate *sut;
}

@end

@implementation MGACountryListTableViewDataSourceDelegateTest

- (void)setUp
{
    [super setUp];

    tableView = mock([UITableView class]);
    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    dataSource = mockProtocol(@protocol(MGADataSource));
    delegate = mockProtocol(@protocol(MGACountrySelectionDelegate));
    flagURLProvider = mockProtocol(@protocol(MGAFlagURLProvider));
    sut = [[MGACountryListTableViewDataSourceDelegate alloc] initWithDataSource:dataSource delegate:delegate flagURLProvider:flagURLProvider];
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

- (void)test_registerCellsForTableView_registersMGACountryAndFlagCell
{
    [sut registerCellsForTableView:tableView];

    [MKTVerify(tableView) registerClass:[MGACountryAndFlagCell class] forCellReuseIdentifier:@"MGACountryAndFlagCell"];
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
    NSURL *url = mock([NSURL class]);
    MGACountryAndFlagCell *countryCell = mock([MGACountryAndFlagCell class]);
    [given(countryCell.textLabel) willReturn:mock([UILabel class])];
    id <MGACountry> country = mockProtocol(@protocol(MGACountry));
    [given(country.name) willReturn:@"a country name"];
    [given(country.alpha2Code) willReturn:@"code"];
    [given([flagURLProvider URLForCountryCode:@"code"]) willReturn:url];

    [given([dataSource objectAtIndexPath:indexPath]) willReturn:country];
    [given([tableView dequeueReusableCellWithIdentifier:@"MGACountryAndFlagCell"]) willReturn:countryCell];

    UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:indexPath];

    assertThat(cell, is(equalTo(countryCell)));
    [MKTVerify(cell) setName:@"a country name"];
    [MKTVerify(cell) setFlagURL:url];
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

- (void)test_tableViewTitleForHeaderInSection_returnsNil_whenDataSourceIsEmpty
{
    [given([dataSource numberOfObjectsInSection:0]) willReturnInteger:0];

    assertThat([sut tableView:tableView titleForHeaderInSection:0], is(nilValue()));
}

- (void)test_tableViewTitleForHeaderInSection_returnsSectionTitle_whenSet
{
    [given([dataSource numberOfObjectsInSection:0]) willReturnInteger:3];

    sut.sectionTitle = @"a section title";

    assertThat([sut tableView:tableView titleForHeaderInSection:0], is(equalTo(@"a section title")));
}

- (void)test_tableViewHeightForHeaderInSection
{
    assertThatFloat([sut tableView:tableView heightForHeaderInSection:0], is(equalToFloat(UITableViewAutomaticDimension)));
}

@end
