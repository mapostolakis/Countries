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
#import "UITabBarController+MGAAdditions.h"
#import "MGAFetchCountryListServiceCommandBuilder.h"
#import "UITabBarItem+MGAFactory.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGAFlowFactory ()

@property (nonatomic, readonly) UITabBarController *tabBarController;
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

- (id <MGAFetchCountryListService>)service
{
    return [self.serviceProvider createFetchCountryListService];
}

- (RACCommand *)serviceCommand
{
    return [[[MGAFetchCountryListServiceCommandBuilder alloc] initWithService:self.service] build];
}

- (MGAListCountriesFlow *)createCountryListFlow
{
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.tabBarItem = [UITabBarItem countryList];
    [self.tabBarController mga_addViewController:navigationController];
    id <MGAViewControllerPresenter> rootPresenter =
    [[MGANavigationControllerRootPresenter alloc] initWithNavigationController:navigationController];
    id <MGAListCountriesFactory> factory =
    [[MGAStandardListCountriesFactory alloc] initWithDataSourceProvider:self.dataSourceProvider serviceCommand:[self serviceCommand]];
    return [[MGAListCountriesFlow alloc] initWithFactory:factory presenter:rootPresenter flowFactory:self];
}

- (MGAListCountriesFlow *)createMappedCountryListFlow
{
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.tabBarItem = [UITabBarItem map];
    [self.tabBarController mga_addViewController:navigationController];
    id <MGAViewControllerPresenter> rootPresenter =
    [[MGANavigationControllerRootPresenter alloc] initWithNavigationController:navigationController];
    id <MGAListCountriesFactory> factory =
    [[MGAMappedCountryListFactory alloc] initWithServiceCommand:[self serviceCommand]];
    return [[MGAListCountriesFlow alloc] initWithFactory:factory presenter:rootPresenter flowFactory:self];
}

- (MGACountryDetailsFlow *)createFlowForCountry:(id <MGACountry>)country
{
    UINavigationController *navigationController = self.tabBarController.selectedViewController;
    id <MGAFlagURLProvider> provider = [MGAGeonamesFlagURLProvider new];
    id <MGACountryGateway> gateway = [[MGAInMemoryStoreGateway alloc] initWithStore:self.store];
    id <MGACountryDetailsFactory> factory =
    [[MGAStandardCountryDetailsFactory alloc] initWithFlagURLProvider:provider gateway:gateway];
    MGANavigationControllerPushPresenter *presenter =
    [[MGANavigationControllerPushPresenter alloc] initWithNavigationController:navigationController];
    MGANavigationControllerLastItemReplacingPresenter *selectionPresenter =
    [[MGANavigationControllerLastItemReplacingPresenter alloc] initWithNavigationController:navigationController];
    MGAStandardMapFactory *mapFactory = [[MGAStandardMapFactory alloc] init];
    return [[MGACountryDetailsFlow alloc] initWithCountry:country
                                                  factory:factory
                                               mapFactory:mapFactory
                                       selectionPresenter:selectionPresenter
                                                presenter:presenter];
}

@end