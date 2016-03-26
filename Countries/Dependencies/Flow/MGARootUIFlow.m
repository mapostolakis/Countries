//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGARootUIFlow.h"
#import "MGAStandardListCountriesFactory.h"
#import "MGAServiceProvider.h"
#import "MGADataSourceProvider.h"

@interface MGARootUIFlow ()

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, readonly) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, readonly) id <MGAServiceProvider> serviceProvider;

@end

@implementation MGARootUIFlow

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

- (UIViewController *)rootViewController
{
    if (_rootViewController == nil) {
        MGAStandardListCountriesFactory *factory =
        [[MGAStandardListCountriesFactory alloc] initWithDataSourceProvider:self.dataSourceProvider
                                                            serviceProvider:self.serviceProvider];
        UIViewController *controller = [factory createListCountriesWithDelegate:self];
        _rootViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    }
    return _rootViewController;
}

- (void)didSelectCountry:(id <MGACountry>)country
{

}

@end