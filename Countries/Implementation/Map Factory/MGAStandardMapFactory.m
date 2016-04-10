//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardMapFactory.h"
#import "MGAMapViewController.h"

@implementation MGAStandardMapFactory

- (UIViewController *)createMapViewForCoordinates:(CLLocationCoordinate2D)coordinates
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinates, 500000, 500000);
    return [[MGAMapViewController alloc] initWithRegion:region];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end