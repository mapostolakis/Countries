//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListAPIService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGAFetchCountryListAPIService ()

@property (nonatomic, readonly) NSURLSession *session;
@property (nonatomic, readonly) NSURL *url;

@end

@implementation MGAFetchCountryListAPIService

- (instancetype)initWithSession:(NSURLSession *)session url:(NSURL *)url
{
    self = [super init];
    if (self) {
        _session = session;
        _url = url;
    }
    return self;
}

- (RACSignal *)fetchCountries
{
    NSURLSession *session = self.session;
    NSURL *url = self.url;
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSURLSessionDataTask *task =
        [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:data];
                [subscriber sendCompleted];
            }
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end