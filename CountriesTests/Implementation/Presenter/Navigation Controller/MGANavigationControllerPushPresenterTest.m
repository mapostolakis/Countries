//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGANavigationControllerPushPresenter.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGANavigationControllerPushPresenterTest : XCTestCase
{
    UINavigationController *navigationController;
    MGANavigationControllerPushPresenter *sut;
}
@end

@implementation MGANavigationControllerPushPresenterTest

- (void)setUp
{
    [super setUp];

    navigationController = mock([UINavigationController class]);
    sut = [[MGANavigationControllerPushPresenter alloc] initWithNavigationController:navigationController];
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

    [MKTVerify(navigationController) pushViewController:viewController animated:YES];
}

@end
