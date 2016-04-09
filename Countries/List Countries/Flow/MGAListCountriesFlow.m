//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFlow.h"
#import "MGAStandardListCountriesFactory.h"
#import "MGACountry.h"
#import "MGAShowCountryDetailsFactory.h"
#import "MGAViewControllerPresenter.h"

@interface MGAListCountriesFlow ()

@property (nonatomic, readonly) id <MGAListCountriesFactory> listCountriesFactory;
@property (nonatomic, readonly) id <MGAShowCountryDetailsFactory> countryDetailsFactory;
@property (nonatomic, readonly) id <MGAViewControllerPresenter> listPresenter;
@property (nonatomic, readonly) id <MGAViewControllerPresenter> detailsPresenter;

@end

@implementation MGAListCountriesFlow

- (instancetype)initWithListCountriesFactory:(id <MGAListCountriesFactory>)listCountriesFactory
                       countryDetailsFactory:(id <MGAShowCountryDetailsFactory>)countryDetailsFactory
                               listPresenter:(id <MGAViewControllerPresenter>)listPresenter
                            detailsPresenter:(id <MGAViewControllerPresenter>)detailsPresenter
{
    self = [super init];
    if (self) {
        _listCountriesFactory = listCountriesFactory;
        _countryDetailsFactory = countryDetailsFactory;
        _listPresenter = listPresenter;
        _detailsPresenter = detailsPresenter;
    }
    return self;
}

- (void)start
{
    UIViewController *viewController = [self.listCountriesFactory createListCountriesWithDelegate:self];
    [self.listPresenter present:viewController];
}

- (void)didSelectCountry:(id <MGACountry>)country
{
    UIViewController *viewController = [self.countryDetailsFactory createCountryDetailsViewForCountry:country delegate:nil];
    [self.detailsPresenter present:viewController];
}

@end