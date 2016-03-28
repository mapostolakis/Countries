//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGANavigationControllerRootPresenter.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGANavigationControllerRootPresenterTest : XCTestCase
{
    UINavigationController *navigationController;
    MGANavigationControllerRootPresenter *sut;
}
@end

@implementation MGANavigationControllerRootPresenterTest

- (void)setUp
{
    [super setUp];

    navigationController = mock([UINavigationController class]);
    sut = [[MGANavigationControllerRootPresenter alloc] initWithNavigationController:navigationController];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

- (void)test_conformsToMGAViewControllerPresenter
{
    assertThat(sut, conformsTo(@protocol(MGAViewControllerPresenter)));
}

- (void)test_present_setsViewControllerAsOnlyViewControllerInTheStack_nonAnimated
{
    UIViewController *viewController = mock([UIViewController class]);

    [sut present:viewController];

    [MKTVerify(navigationController) setViewControllers:@[viewController] animated:NO];
}

@end
