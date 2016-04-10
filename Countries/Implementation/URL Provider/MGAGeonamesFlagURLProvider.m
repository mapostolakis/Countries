//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAGeonamesFlagURLProvider.h"

@implementation MGAGeonamesFlagURLProvider

- (NSURL *)URLForCountryCode:(NSString *)alpha2Code
{
    if (alpha2Code.length == 0) { return nil; }
    NSString *urlString = [NSString stringWithFormat:@"http://www.geonames.org/flags/x/%@.gif", alpha2Code.lowercaseString];
    return [NSURL URLWithString:urlString];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end