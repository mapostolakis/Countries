//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACommandExecutionTableViewReloadBinder.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACommandExecutionTableViewReloadBinderTest : XCTestCase
{
    RACCommand *command;
    UITableView *tableView;
    MGACommandExecutionTableViewReloadBinder *sut;
}
@end

@implementation MGACommandExecutionTableViewReloadBinderTest

- (void)setUp
{
    [super setUp];

    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal return:nil];
    }];
    tableView = mock([UITableView class]);
    sut = [[MGACommandExecutionTableViewReloadBinder alloc] initWithCommand:command tableView:tableView];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_conformsToMGABinder
{
    assertThat(sut, conformsTo(@protocol(MGABinder)));
}

- (void)test_bind_reloadsTableView_whenCommandIsExecuted
{
    [sut bind];

    [[command execute:nil] asynchronouslyWaitUntilCompleted:nil];

    [MKTVerify(tableView) reloadData];
}

@end
