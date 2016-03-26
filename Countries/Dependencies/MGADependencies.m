//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADependencies.h"
#import "MGADataSourceProvider.h"
#import "MGAServiceProvider.h"
#import "MGARootUIFlow.h"
#import "MGAStandardDataSourceProvider.h"
#import "MGAStandardServiceProvider.h"
#import "MGAInMemoryStore.h"

@interface MGADependencies ()

@property (nonatomic, strong) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, strong) id <MGAServiceProvider> serviceProvider;
@property (nonatomic, strong) id <MGAStore> store;
@property (nonatomic, strong) MGARootUIFlow *uiFlow;

@end

@implementation MGADependencies

- (UIViewController *)rootViewController
{
    return self.uiFlow.rootViewController;
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

- (MGARootUIFlow *)uiFlow
{
    if (_uiFlow == nil) {
        _uiFlow = [[MGARootUIFlow alloc] initWithDataSourceProvider:self.dataSourceProvider
                                                    serviceProvider:self.serviceProvider];
    }
    return _uiFlow;
}

@end