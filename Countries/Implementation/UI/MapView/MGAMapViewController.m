//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAMapViewController.h"

@interface MGAMapViewController ()

@property (nonatomic, weak, readwrite) MKMapView *mapView;
@property (nonatomic, readonly) MKCoordinateRegion region;
@property (nonatomic, readonly) id <MKMapViewDelegate> delegate;

@end

@implementation MGAMapViewController

- (instancetype)initWithRegion:(MKCoordinateRegion)region delegate:(id <MKMapViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _region = region;
        _delegate = delegate;
    }
    return self;
}

- (MKMapView *)mapView
{
    if (_mapView == nil) {
        MKMapView *mapView = [[MKMapView alloc] init];
        mapView.translatesAutoresizingMaskIntoConstraints = NO;
        [mapView setRegion:self.region animated:YES];
        mapView.delegate = self.delegate;
        [self.view addSubview:mapView];
        _mapView = mapView;
    }
    return _mapView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupConstraints];
}

- (void)setupConstraints
{
    UIView *mapView = self.mapView;

    NSDictionary *views = NSDictionaryOfVariableBindings(mapView);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mapView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapView]|" options:0 metrics:nil views:views]];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end