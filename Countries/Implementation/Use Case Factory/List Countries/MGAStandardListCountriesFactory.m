//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardListCountriesFactory.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MGACommandExecutionTableViewReloadBinder.h"
#import "MGATableViewController.h"
#import "UINavigationItem+MGARefresh.h"
#import "MGADataSourceProvider.h"
#import "MGAServiceProvider.h"
#import "MGACountryListTableViewDataSourceDelegate.h"
#import "MGAFetchCountryListServiceCommandBuilder.h"
#import "MGAGeonamesFlagURLProvider.h"

@interface MGAStandardListCountriesFactory ()

@property (nonatomic, readonly) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, readonly) id <MGAServiceProvider> serviceProvider;

@end

@implementation MGAStandardListCountriesFactory

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                           serviceProvider:(id <MGAServiceProvider>)serviceProvider
{
    self = [super init];
    if (self) {
        _dataSourceProvider = dataSourceProvider;
        _serviceProvider = serviceProvider;
    }
    return self;
}

- (UIViewController *)createListCountriesWithDelegate:(id <MGACountrySelectionDelegate>)delegate
{
    id <MGAFetchCountryListService> service = [self.serviceProvider createFetchCountryListService];
    RACCommand *command = [[[MGAFetchCountryListServiceCommandBuilder alloc] initWithService:service] build];
    id <MGADataSource> dataSource = [self.dataSourceProvider createCountryListDataSourceForEvent:[[command executionSignals] switchToLatest]];
    MGACountryListTableViewDataSourceDelegate *dataSourceDelegate = [self createDataSourceDelegateForDataSource:dataSource delegate:delegate];
    MGATableViewController *viewController = [self createViewControllerWithDataSourceDelegate:dataSourceDelegate command:command];
    [[[MGACommandExecutionTableViewReloadBinder alloc] initWithCommand:command tableView:viewController.tableView] bind];
    [command execute:nil];
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