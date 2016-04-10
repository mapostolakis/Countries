//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAMutableCountryDetails.h"

@implementation MGAMutableCountryDetails

@synthesize name = _name, value = _value;

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (!other || ![[other class] isEqual:[self class]]) {
        return NO;
    }
    return [self isEqualToCountryDetails:other];
}

- (BOOL)isEqualToCountryDetails:(MGAMutableCountryDetails *)details
{
    if (self == details) {
        return YES;
    }
    if (details == nil) {
        return NO;
    }
    if (self.name != details.name && ![self.name isEqualToString:details.name]) {
        return NO;
    }
    if (self.value != details.value && ![self.value isEqualToString:details.value]) {
        return NO;
    }
    return YES;
}

- (NSUInteger)hash
{
    NSUInteger hash = [self.name hash];
    hash = hash * 31u + [self.value hash];
    return hash;
}

@end