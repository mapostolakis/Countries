//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFlowFactory.h"
#import "MGACountryDetailsFlow.h"
#import "MGAInMemoryStoreGateway.h"
#import "MGAGeonamesFlagURLProvider.h"
#import "MGAStandardCountryDetailsFactory.h"
#import "MGAInMemoryStore.h"
#import "MGANavigationControllerPushPresenter.h"
#import "MGAListCountriesFlow.h"
#import "MGANavigationControllerRootPresenter.h"
#import "MGAStandardListCountriesFactory.h"
#import "MGADataSourceProvider.h"
#import "MGAServiceProvider.h"
#import "MGANavigationControllerLastItemReplacingPresenter.h"
#import "MGAStandardMapFactory.h"
#import "MGAMappedCountryListFactory.h"
#import "MGAStandardAnnotationProvider.h"
#import "UITabBarController+MGAAdditions.h"

@interface MGAFlowFactory ()

@property (nonatomic, readonly) UITabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, readonly) MGAInMemoryStore *store;
@property (nonatomic, readonly) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, readonly) id <MGAServiceProvider> serviceProvider;

@end

@implementation MGAFlowFactory

- (instancetype)initWithInMemoryStore:(MGAInMemoryStore *)store
                     tabBarController:(UITabBarController *)tabBarController
                   dataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                      serviceProvider:(id <MGAServiceProvider>)serviceProvider
{
    self = [super init];
    if (self) {
        _store = store;
        _tabBarController = tabBarController;
        _dataSourceProvider = dataSourceProvider;
        _serviceProvider = serviceProvider;
    }
    return self;
}

- (UINavigationController *)navigationController
{
    if (_navigationController == nil) {
        _navigationController = [[UINavigationController alloc] init];
    }
    return _navigationController;
}

- (MGAListCountriesFlow *)createCountryListFlow
{
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"List" image:nil selectedImage:nil];;
    [self.tabBarController mga_addViewController:self.navigationController];
    id <MGAViewControllerPresenter> rootPresenter =
    [[MGANavigationControllerRootPresenter alloc] initWithNavigationController:self.navigationController];
    id <MGAListCountriesFactory> factory =
    [[MGAStandardListCountriesFactory alloc] initWithDataSourceProvider:self.dataSourceProvider serviceProvider:self.serviceProvider];
    return [[MGAListCountriesFlow alloc] initWithFactory:factory presenter:rootPresenter flowFactory:self];
}

- (MGAListCountriesFlow *)createMappedCountryListFlow
{
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:nil selectedImage:nil];
    [self.tabBarController mga_addViewController:navigationController];
    id <MGAViewControllerPresenter> rootPresenter =
    [[MGANavigationControllerRootPresenter alloc] initWithNavigationController:navigationController];
    id <MGADataSource> dataSource = [self.dataSourceProvider createCountryListDataSource];
    id <MGAAnnotationProvider> provider = [[MGAStandardAnnotationProvider alloc] initWithDataSource:dataSource];
    id <MGAListCountriesFactory> factory =
    [[MGAMappedCountryListFactory alloc] initWithAnnotationProvider:provider];
    return [[MGAListCountriesFlow alloc] initWithFactory:factory presenter:rootPresenter flowFactory:self];
}

- (MGACountryDetailsFlow *)createFlowForCountry:(id <MGACountry>)country
{
    id <MGAFlagURLProvider> provider = [MGAGeonamesFlagURLProvider new];
    id <MGACountryGateway> gateway = [[MGAInMemoryStoreGateway alloc] initWithStore:self.store];
    id <MGACountryDetailsFactory> factory =
    [[MGAStandardCountryDetailsFactory alloc] initWithFlagURLProvider:provider gateway:gateway];
    MGANavigationControllerPushPresenter *presenter =
    [[MGANavigationControllerPushPresenter alloc] initWithNavigationController:self.navigationController];
    MGANavigationControllerLastItemReplacingPresenter *selectionPresenter =
    [[MGANavigationControllerLastItemReplacingPresenter alloc] initWithNavigationController:self.navigationController];
    MGAStandardMapFactory *mapFactory = [[MGAStandardMapFactory alloc] init];
    return [[MGACountryDetailsFlow alloc] initWithCountry:country
                                                  factory:factory
                                               mapFactory:mapFactory
                                       selectionPresenter:selectionPresenter
                                                presenter:presenter];
}

@end