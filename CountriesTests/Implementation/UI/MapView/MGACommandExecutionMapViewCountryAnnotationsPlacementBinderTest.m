//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACommandExecutionMapViewCountryAnnotationsPlacementBinder.h"
#import "MGACountryAnnotationsBuilder.h"
#import "MGACountry.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface MGACommandExecutionMapViewCountryAnnotationsPlacementBinderTest : XCTestCase
{
    NSArray *countries;
    RACCommand *command;
    id <MGACountryAnnotationsBuilder> annotationsBuilder;
    MKMapView *mapView;
    MGACommandExecutionMapViewCountryAnnotationsPlacementBinder *sut;
}
@end

@implementation MGACommandExecutionMapViewCountryAnnotationsPlacementBinderTest

- (void)setUp
{
    [super setUp];

    countries = @[mockProtocol(@protocol(MGACountry))];
    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal return:countries];
    }];

    annotationsBuilder = mockProtocol(@protocol(MGACountryAnnotationsBuilder));
    mapView = mock([MKMapView class]);
    sut = [[MGACommandExecutionMapViewCountryAnnotationsPlacementBinder alloc] initWithCommand:command
                                                                            annotationsBuilder:annotationsBuilder
                                                                                       mapView:mapView];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Test

- (void)test_bind_addsAnnotationsToMapView_whenCommandExecutes
{
    NSArray *annotations = @[mockProtocol(@protocol(MKAnnotation))];
    [given([annotationsBuilder createCountryAnnotationsFromCountries:countries]) willReturn:annotations];
    [sut bind];

    [[command execute:nil] asynchronouslyWaitUntilCompleted:nil];

    [MKTVerify(mapView) addAnnotations:annotations];
}

@end
