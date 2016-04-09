//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGANavigationControllerLastItemReplacingPresenter.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGANavigationControllerLastItemReplacingPresenterTest : XCTestCase
{
    UINavigationController *navigationController;
    MGANavigationControllerLastItemReplacingPresenter *sut;
}

@end

@implementation MGANavigationControllerLastItemReplacingPresenterTest

- (void)setUp
{
    [super setUp];

    navigationController = mock([UINavigationController class]);
    sut = [[MGANavigationControllerLastItemReplacingPresenter alloc] initWithNavigationController:navigationController];
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

- (void)test_present_replacesLastItemInNavigationStackWithViewController
{
    UIViewController *viewController0 = [UIViewController new];
    UIViewController *viewController1 = [UIViewController new];
    NSArray *viewControllers = @[viewController0, viewController1];
    [given(navigationController.viewControllers) willReturn:viewControllers];

    UIViewController *viewController2 = mock([UIViewController class]);

    [sut present:viewController2];

    [MKTVerify(navigationController) setViewControllers:@[viewController0, viewController2] animated:YES];
}

@end
