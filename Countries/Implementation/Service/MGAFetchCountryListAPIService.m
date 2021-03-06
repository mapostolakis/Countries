//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListAPIService.h"
#import "MGAResourceMapper.h"
#import "MGAConverter.h"
#import "MGAStore.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGAFetchCountryListAPIService ()

@property (nonatomic, readonly) NSURLSession *session;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) id <MGAResourceMapper> resourceMapper;
@property (nonatomic, readonly) id <MGAConverter> converter;
@property (nonatomic, readonly) id <MGAStore> store;

@end

@implementation MGAFetchCountryListAPIService

- (instancetype)initWithSession:(NSURLSession *)session
                            url:(NSURL *)url
                 resourceMapper:(id <MGAResourceMapper>)mapper
                      converter:(id <MGAConverter>)converter
                          store:(id <MGAStore>)store
{
    self = [super init];
    if (self) {
        _session = session;
        _url = url;
        _resourceMapper = mapper;
        _converter = converter;
        _store = store;
    }
    return self;
}

- (RACSignal *)fetchCountries
{
    NSURLSession *session = self.session;
    NSURL *url = self.url;
    id <MGAConverter> converter = self.converter;
    id <MGAResourceMapper> resourceMapper = self.resourceMapper;
    id <MGAStore> store = self.store;
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSURLSessionDataTask *task =
        [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [[[[converter convert:data]
                    map:^id(id convertedData) {
                        return [resourceMapper mapResource:convertedData];
                    }] doNext:^(id mappedResources) {
                        [store save:mappedResources];
                    }]
                    subscribe:subscriber];
            }
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end