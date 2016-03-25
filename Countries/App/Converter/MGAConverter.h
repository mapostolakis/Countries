//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol MGAConverter <NSObject>

- (RACSignal *)convert:(id)object;

@end