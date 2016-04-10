//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsFlow.h"
#import "MGACountryDetailsFactory.h"
#import "MGAViewControllerPresenter.h"
#import "MGAMapFactory.h"

@interface MGACountryDetailsFlow ()

@property (nonatomic, readonly) id <MGACountryDetailsFactory> factory;
@property (nonatomic, readonly) id <MGAMapFactory> mapFactory;
@property (nonatomic, readonly) id <MGAViewControllerPresenter> presenter;
@property (nonatomic, readonly) id <MGAViewControllerPresenter> selectionPresenter;
@property (nonatomic, readonly) id <MGACountry> country;

@end

@implementation MGACountryDetailsFlow

- (instancetype)initWithCountry:(id <MGACountry>)country factory:(id <MGACountryDetailsFactory>)factory mapFactory:(id <MGAMapFactory>)mapFactory selectionPresenter:(id <MGAViewControllerPresenter>)selectionPresenter presenter:(id <MGAViewControllerPresenter>)presenter
{
    self = [super init];
    if (self) {
        _country = country;
        _factory = factory;
        _mapFactory = mapFactory;
        _presenter = presenter;
        _selectionPresenter = selectionPresenter;
    }
    return self;
}

- (void)start
{
    UIViewController *viewController = [self.factory createCountryDetailsViewForCountry:self.country delegate:self coordinateSelectionDelegate:self];

    [self.presenter present:viewController];
}

- (void)didSelectCountry:(id <MGACountry>)country
{
    UIViewController *viewController = [self.factory createCountryDetailsViewForCountry:country delegate:self coordinateSelectionDelegate:self];

    [self.selectionPresenter present:viewController];
}

- (void)didSelectCoordinates:(CLLocationCoordinate2D)coordinates
{
    UIViewController *viewController = [self.mapFactory createMapViewForCoordinates:coordinates];

    [self.presenter present:viewController];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end