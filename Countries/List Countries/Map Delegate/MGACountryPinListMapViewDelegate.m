//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryPinListMapViewDelegate.h"

@implementation MGACountryPinListMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MGACountryPinListMapViewDelegate"];
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    return annotationView;
}

@end