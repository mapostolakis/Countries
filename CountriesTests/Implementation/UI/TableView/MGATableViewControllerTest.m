//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewController.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGATableViewControllerTest : XCTestCase
{
    id <UITableViewDataSource> dataSource;
    id <UITableViewDelegate> delegate;
    MGATableViewController *sut;
}
@end

@implementation MGATableViewControllerTest

- (void)setUp
{
    [super setUp];

    dataSource = mockProtocol(@protocol(UITableViewDataSource));
    delegate = mockProtocol(@protocol(UITableViewDelegate));
    sut = [[MGATableViewController alloc] initWithDataSource:dataSource delegate:delegate style:UITableViewStyleGrouped];
}

- (void)test_dataSource_isSetAsTableViewDataSource
{
    assertThat(sut.tableView.dataSource, is(equalTo(dataSource)));
}

- (void)test_delegate_isSetAsTableViewDelegate
{
    assertThat(sut.tableView.delegate, is(equalTo(delegate)));
}

@end
