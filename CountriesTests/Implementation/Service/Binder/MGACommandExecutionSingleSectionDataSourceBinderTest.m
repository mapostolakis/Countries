//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACommandExecutionSingleSectionDataSourceBinder.h"
#import "MGASingleSectionDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGACommandExecutionSingleSectionDataSourceBinderTest : XCTestCase
{
    NSArray *items;
    RACCommand *command;
    MGASingleSectionDataSource *dataSource;
    MGACommandExecutionSingleSectionDataSourceBinder *sut;
}
@end

@implementation MGACommandExecutionSingleSectionDataSourceBinderTest

- (void)setUp
{
    [super setUp];
    
    items = @[ anything() ];
    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal return:items];
    }];
    dataSource = [[MGASingleSectionDataSource alloc] init];
    sut = [[MGACommandExecutionSingleSectionDataSourceBinder alloc] initWithCommand:command
                                                                         dataSource:dataSource];
}

- (void)tearDown
{
    sut = nil;
    
    [super tearDown];
}

- (void)test_bind_mapsDataSourceItemsToCommandResponse
{
    [sut bind];
    
    [[command execute:nil] asynchronouslyWaitUntilCompleted:nil];
    
    assertThat(dataSource.items, is(equalTo(items)));
}

@end
