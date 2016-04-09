//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAContext.h"
#import "MGADataSourceProvider.h"
#import "MGAServiceProvider.h"
#import "MGAListCountriesFlow.h"
#import "MGAStandardDataSourceProvider.h"
#import "MGAStandardServiceProvider.h"
#import "MGAInMemoryStore.h"
#import "MGAStandardListCountriesFactory.h"
#import "MGANavigationControllerRootPresenter.h"
#import "MGAStandardShowCountryDetailsFactory.h"
#import "MGANavigationControllerPushPresenter.h"
#import "MGAGeonamesFlagURLProvider.h"
#import "MGAInMemoryStoreGateway.h"

@interface MGAContext ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, strong) id <MGAServiceProvider> serviceProvider;
@property (nonatomic, strong) id <MGAStore> store;
@property (nonatomic, strong) id <MGACountryGateway> inMemoryCountryGateway;
@end

@implementation MGAContext

- (void)start
{
    MGANavigationControllerRootPresenter *rootPresenter = [[MGANavigationControllerRootPresenter alloc] initWithNavigationController:self.navigationController];
    MGANavigationControllerPushPresenter *pushPresenter = [[MGANavigationControllerPushPresenter alloc] initWithNavigationController:self.navigationController];
    MGAListCountriesFlow *flow = [[MGAListCountriesFlow alloc] initWithListCountriesFactory:[self createListCountriesFactory]
                                                                      countryDetailsFactory:[self createCountryDetailsFactory]
                                                                              listPresenter:rootPresenter detailsPresenter:pushPresenter];
    [flow start];
}

- (UIViewController *)rootViewController
{
    return self.navigationController;
}

- (UINavigationController *)navigationController
{
    if (_navigationController == nil) {
        _navigationController = [[UINavigationController alloc] init];
    }
    return _navigationController;
}

- (id <MGADataSourceProvider>)dataSourceProvider
{
    if (_dataSourceProvider == nil) {
        _dataSourceProvider = [[MGAStandardDataSourceProvider alloc] init];
    }
    return _dataSourceProvider;
}

- (id <MGAServiceProvider>)serviceProvider
{
    if (_serviceProvider == nil) {
        _serviceProvider = [[MGAStandardServiceProvider alloc] initWithStore:self.store];
    }
    return _serviceProvider;
}

- (id <MGAStore>)store
{
    if (_store == nil) {
        _store = [[MGAInMemoryStore alloc] init];
    }
    return _store;
}

- (id <MGAListCountriesFactory>)createListCountriesFactory
{
    return [[MGAStandardListCountriesFactory alloc] initWithDataSourceProvider:self.dataSourceProvider
                                                               serviceProvider:self.serviceProvider];
}

- (id <MGACountryGateway>)inMemoryCountryGateway
{
    if (_inMemoryCountryGateway == nil) {
        _inMemoryCountryGateway = [[MGAInMemoryStoreGateway alloc] initWithStore:self.store];
    }
    return _inMemoryCountryGateway;
}

- (id <MGAShowCountryDetailsFactory>)createCountryDetailsFactory
{
    id <MGAFlagURLProvider> provider = [MGAGeonamesFlagURLProvider new];
    id <MGACountryGateway> gateway = [[MGAInMemoryStoreGateway alloc] initWithStore:self.store];
    return [[MGAStandardShowCountryDetailsFactory alloc] initWithFlagURLProvider:provider gateway:gateway];
}

@end