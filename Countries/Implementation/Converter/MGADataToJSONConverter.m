//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataToJSONConverter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation MGADataToJSONConverter

- (RACSignal *)convert:(NSData *)data
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            [subscriber sendError:error];
        } else {
            [subscriber sendNext:json];
            [subscriber sendCompleted];
        }
        return nil;
    }];
}

@end