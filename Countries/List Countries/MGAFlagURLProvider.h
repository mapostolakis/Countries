//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGAFlagURLProvider <NSObject>

- (NSURL *)URLForCountryCode:(NSString *)code;

@end