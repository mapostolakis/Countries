//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryPinListMapViewDelegate.h"
#import "MGACountryAnnotation.h"
#import "UIImageView+MGAImageFetcher.h"
#import "MGAFlagURLProvider.h"
#import "MGACountrySelectionDelegate.h"
#import "MGACountry.h"

@interface MGACountryPinListMapViewDelegate ()

@property (nonatomic, readonly) id <MGAFlagURLProvider> flagProvider;
@property (nonatomic, readonly) id <MGACountrySelectionDelegate> delegate;

@end

@implementation MGACountryPinListMapViewDelegate

- (instancetype)initWithFlagProvider:(id <MGAFlagURLProvider>)provider
                            delegate:(id <MGACountrySelectionDelegate>)delegate
{
    self = [super init];
    if (self) {
        _flagProvider = provider;
        _delegate = delegate;
    }
    return self;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MGACountryAnnotation *)annotation
{
    MKPinAnnotationView *annotationView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MGACountryPinListMapViewDelegate"];
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    CGRect frame = CGRectMake(0.f, 0.f, 44.f, 44.f);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *code = ((MGACountryAnnotation *)view.annotation).country.alpha2Code;
    [imageView setImageForURL:[self.flagProvider URLForCountryCode:code]];
    view.leftCalloutAccessoryView = imageView;

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    view.rightCalloutAccessoryView = rightButton;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id <MGACountry> country = ((MGACountryAnnotation *)view.annotation).country;
    [self.delegate didSelectCountry:country];
}

@end