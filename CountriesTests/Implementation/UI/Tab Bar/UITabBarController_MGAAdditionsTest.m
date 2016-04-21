//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "UITabBarController+MGAAdditions.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface UITabBarController_MGAAdditionsTest : XCTestCase
{
    UITabBarController *sut;
}
@end

@implementation UITabBarController_MGAAdditionsTest

- (void)setUp
{
    [super setUp];

    sut = [[UITabBarController alloc] init];
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_addsViewControllerToViewControllersStack
{
    UIViewController *viewController = [UIViewController new];

    [sut mga_addViewController:viewController];

    assertThat(sut.viewControllers, is(equalTo(@[viewController])));
}

- (void)test_addsViewControllersToViewControllersStack
{
    UIViewController *viewController0 = [UIViewController new];
    UIViewController *viewController1 = [UIViewController new];

    [sut mga_addViewController:viewController0];
    [sut mga_addViewController:viewController1];

    assertThat(sut.viewControllers, is(equalTo(@[viewController0, viewController1])));
}

@end
