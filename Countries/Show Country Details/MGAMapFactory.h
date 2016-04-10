//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import UIKit;
@import MapKit;

@protocol MGAMapFactory <NSObject>

- (UIViewController *)createMapViewForCoordinates:(CLLocationCoordinate2D)coordinates;

@end