//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryCoordinateDetailsDataSourceDelegate.h"
#import "MGACoordinateSelectionDelegate.h"
#import "MGADataSource.h"
#import "MGACountryCoordinateDetailsCell.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACountryCoordinateDetailsDataSourceDelegateTest : XCTestCase
{
    NSIndexPath *indexPath;
    UITableView *tableView;
    id <MGADataSource> dataSource;
    id <MGACoordinateSelectionDelegate> delegate;
    CLLocationCoordinate2D coordinates;
    MGACountryCoordinateDetailsDataSourceDelegate *sut;
}
@end

@implementation MGACountryCoordinateDetailsDataSourceDelegateTest

- (void)setUp
{
    [super setUp];

    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    tableView = mock([UITableView class]);
    dataSource = mockProtocol(@protocol(MGADataSource));
    delegate = mockProtocol(@protocol(MGACoordinateSelectionDelegate));
    coordinates = CLLocationCoordinate2DMake(123, 456);
    sut = [[MGACountryCoordinateDetailsDataSourceDelegate alloc] initWithSectionTitle:@"a section title"
                                                                           dataSource:dataSource
                                                                             delegate:delegate
                                                                          coordinates:coordinates];
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

    [MKTVerify(tableView) registerClass:[MGACountryCoordinateDetailsCell class] forCellReuseIdentifier:@"MGACountryCoordinateDetailsCell"];
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

- (void)test_tableViewCellForRowAtIndexPath_returnsCountryCoordinateDetailsCell
{
    MGACountryCoordinateDetailsCell *coordinateDetailsCell = mock([MGACountryCoordinateDetailsCell class]);
    [given([tableView dequeueReusableCellWithIdentifier:@"MGACountryCoordinateDetailsCell"]) willReturn:coordinateDetailsCell];

    UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:indexPath];

    assertThat(cell, is(equalTo(coordinateDetailsCell)));
    [MKTVerify(cell) setLatitude:[NSString stringWithFormat:@"Latitude: 123"]];
    [MKTVerify(cell) setLongitude:[NSString stringWithFormat:@"Longitude: 456"]];
}

- (void)test_tableViewTitleForHeaderInSection_returnsSectionTitle
{
    assertThat([sut tableView:tableView titleForHeaderInSection:0], is(equalTo(@"a section title")));
    assertThat([sut tableView:tableView titleForHeaderInSection:1], is(equalTo(@"a section title")));
}

- (void)test_tableViewHeightForRowAtIndexPath_returns70
{
    assertThatFloat([sut tableView:anything() heightForRowAtIndexPath:anything()], is(equalToFloat(70.f)));
}

- (void)test_tableViewHeightForHeaderInSection_returnsDefaultValue
{
    assertThatFloat([sut tableView:anything() heightForHeaderInSection:0], is(equalToFloat(UITableViewAutomaticDimension)));
    assertThatFloat([sut tableView:anything() heightForHeaderInSection:1], is(equalToFloat(UITableViewAutomaticDimension)));
}

- (void)test_tableViewDidSelectRowAtIndexPath_selectsCoordinates
{
    [sut tableView:anything() didSelectRowAtIndexPath:indexPath];

    [MKTVerify(delegate) didSelectCoordinates:coordinates];
}

@end
