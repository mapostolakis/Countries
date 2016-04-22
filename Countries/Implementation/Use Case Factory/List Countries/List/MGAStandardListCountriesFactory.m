//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardListCountriesFactory.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MGACommandExecutionTableViewReloadBinder.h"
#import "MGATableViewController.h"
#import "UINavigationItem+MGARefresh.h"
#import "MGADataSourceProvider.h"
#import "MGACountryListTableViewDataSourceDelegate.h"
#import "MGAGeonamesFlagURLProvider.h"
#import "MGACommandExecutionSingleSectionDataSourceBinder.h"
#import "MGASingleSectionDataSource.h"

@interface MGAStandardListCountriesFactory ()

@property (nonatomic, readonly) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, readonly) RACCommand *command;

@end

@implementation MGAStandardListCountriesFactory

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                            serviceCommand:(RACCommand *)command
{
    self = [super init];
    if (self) {
        _dataSourceProvider = dataSourceProvider;
        _command = command;
    }
    return self;
}

- (UIViewController *)createListCountriesWithDelegate:(id <MGACountrySelectionDelegate>)delegate
{
    MGASingleSectionDataSource *dataSource = [self.dataSourceProvider createCountryListDataSource];
    [[[MGACommandExecutionSingleSectionDataSourceBinder alloc] initWithCommand:self.command dataSource:dataSource] bind];
    MGACountryListTableViewDataSourceDelegate *dataSourceDelegate = [self createDataSourceDelegateForDataSource:dataSource delegate:delegate];
    MGATableViewController *viewController = [self createViewControllerWithDataSourceDelegate:dataSourceDelegate command:self.command];
    [[[MGACommandExecutionTableViewReloadBinder alloc] initWithCommand:self.command tableView:viewController.tableView] bind];
    [self.command execute:nil];
    return viewController;
}

- (MGACountryListTableViewDataSourceDelegate *)createDataSourceDelegateForDataSource:(id <MGADataSource>)dataSource
                                                                            delegate:(id <MGACountrySelectionDelegate>)delegate
{
    return [[MGACountryListTableViewDataSourceDelegate alloc] initWithDataSource:dataSource
                                                                        delegate:delegate
                                                                 flagURLProvider:[MGAGeonamesFlagURLProvider new]];
}

- (MGATableViewController *)createViewControllerWithDataSourceDelegate:(MGACountryListTableViewDataSourceDelegate *)dataSourceDelegate
                                                               command:(RACCommand *)command
{
    MGATableViewController *viewController = [[MGATableViewController alloc] initWithDataSource:dataSourceDelegate
                                                                                       delegate:dataSourceDelegate
                                                                                          style:UITableViewStylePlain];
    viewController.title = @"Countries";
    [viewController.navigationItem addRefreshItemWithCommand:command];
    [viewController view];
    [dataSourceDelegate registerCellsForTableView:viewController.tableView];
    return viewController;
}

@end