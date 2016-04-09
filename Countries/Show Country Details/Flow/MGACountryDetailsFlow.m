//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsFlow.h"
#import "MGACountryDetailsFactory.h"
#import "MGAViewControllerPresenter.h"

@interface MGACountryDetailsFlow ()

@property (nonatomic, readonly) id <MGACountryDetailsFactory> factory;
@property (nonatomic, readonly) id <MGAViewControllerPresenter> presenter;
@property (nonatomic, readonly) id <MGACountry> country;

@end

@implementation MGACountryDetailsFlow

- (instancetype)initWithCountry:(id <MGACountry>)country factory:(id <MGACountryDetailsFactory>)factory presenter:(id <MGAViewControllerPresenter>)presenter
{
    self = [super init];
    if (self) {
        _country = country;
        _factory = factory;
        _presenter = presenter;
    }
    return self;
}

- (void)start
{
    UIViewController *viewController = [self.factory createCountryDetailsViewForCountry:self.country delegate:self];

    [self.presenter present:viewController];
}

- (void)didSelectCountry:(id <MGACountry>)country
{
    UIViewController *viewController = [self.factory createCountryDetailsViewForCountry:country delegate:self];

    [self.presenter present:viewController];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end