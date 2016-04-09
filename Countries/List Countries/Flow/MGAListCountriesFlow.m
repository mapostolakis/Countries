//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFlow.h"
#import "MGAStandardListCountriesFactory.h"
#import "MGACountry.h"
#import "MGAViewControllerPresenter.h"
#import "MGACountryDetailsFlowFactory.h"
#import "MGACountryDetailsFlow.h"

@interface MGAListCountriesFlow ()

@property (nonatomic, readonly) id <MGAListCountriesFactory> factory;
@property (nonatomic, readonly) id <MGAViewControllerPresenter> presenter;
@property (nonatomic, readonly) id <MGACountryDetailsFlowFactory> flowFactory;

@end

@implementation MGAListCountriesFlow

- (instancetype)initWithFactory:(id <MGAListCountriesFactory>)factory
                      presenter:(id <MGAViewControllerPresenter>)presenter
                    flowFactory:(id <MGACountryDetailsFlowFactory>)flowFactory
{
    self = [super init];
    if (self) {
        _factory = factory;
        _presenter = presenter;
        _flowFactory = flowFactory;
    }
    return self;
}

- (void)start
{
    UIViewController *viewController = [self.factory createListCountriesWithDelegate:self];

    [self.presenter present:viewController];
}

- (void)didSelectCountry:(id <MGACountry>)country
{
    [[self.flowFactory createFlowForCountry:country] start];
}

@end