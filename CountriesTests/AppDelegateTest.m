//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "AppDelegate.h"
#import "MGAContext.h"

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface AppDelegateTest : XCTestCase
{
    MGAContext *context;
    AppDelegate *sut;
}
@end

@implementation AppDelegateTest

- (void)setUp
{
    [super setUp];

    context = mock([MGAContext class]);
    sut = [AppDelegate new];
    sut.appContext = context;
}

- (void)tearDown
{
    sut = nil;

    [super tearDown];
}

#pragma mark - Tests

- (void)test_applicationDidFinishLaunchingWithOptions_setsRootViewControllerFromAppContext
{
    UIViewController *viewController = [UIViewController new];
    [given([context rootViewController]) willReturn:viewController];

    [sut application:anything() didFinishLaunchingWithOptions:anything()];

    assertThat(sut.window.rootViewController, is(equalTo(viewController)));    
}

@end
