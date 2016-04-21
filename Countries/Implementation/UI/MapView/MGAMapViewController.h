//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MGAMapViewController : UIViewController

@property (nonatomic, weak, readonly) MKMapView *mapView;

- (instancetype)initWithRegion:(MKCoordinateRegion)region delegate:(id <MKMapViewDelegate>)delegate;

@end