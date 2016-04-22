//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "UITabBarItem+MGAFactory.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface UITabBarItem_MGAFactoryTest : XCTestCase

@end

@implementation UITabBarItem_MGAFactoryTest

- (void)test_countryList_title
{
    UITabBarItem *sut = [UITabBarItem countryList];

    assertThat(sut.title, is(equalTo(@"Country List")));
}

- (void)test_map_title
{
    UITabBarItem *sut = [UITabBarItem map];

    assertThat(sut.title, is(equalTo(@"Map")));
}

@end
