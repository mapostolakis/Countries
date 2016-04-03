//
//  Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleValueCountryDetails.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface MGASingleValueCountryDetailsTest : XCTestCase

@end

@implementation MGASingleValueCountryDetailsTest

- (void)test_conformsToMGACountryDetails
{
    assertThat([MGASingleValueCountryDetails new], conformsTo(@protocol(MGACountryDetails)));
}

@end
