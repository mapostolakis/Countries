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
#import "MGACountryListTableViewAdapter.h"
#import "MGAFetchCountryListServiceCommandBuilder.h"

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
    MGACountryListTableViewAdapter *adapter = [[MGACountryListTableViewAdapter alloc] initWithDataSource:dataSource delegate:delegate];
    MGATableViewController *viewController = [self createViewControllerWithAdapter:adapter command:command];
    [[[MGACommandExecutionTableViewReloadBinder alloc] initWithCommand:command tableView:viewController.tableView] bind];
    [command execute:nil];
    return viewController;
}

- (MGATableViewController *)createViewControllerWithAdapter:(MGACountryListTableViewAdapter *)adapter command:(RACCommand *)command
{
    MGATableViewController *viewController = [[MGATableViewController alloc] initWithDataSource:adapter
                                                                                       delegate:adapter
                                                                                          style:UITableViewStylePlain];
    viewController.title = @"Countries";
    [viewController.navigationItem addRefreshItemWithCommand:command];
    [viewController view];
    return viewController;
}

@end