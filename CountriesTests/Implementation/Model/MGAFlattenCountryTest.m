//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFlattenCountry.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGAFlattenCountryTest : XCTestCase

@end

@implementation MGAFlattenCountryTest

- (void)test_conformsToMGACountry
{
    assertThat([MGAFlattenCountry new], conformsTo(@protocol(MGACountry)));
}

@end
