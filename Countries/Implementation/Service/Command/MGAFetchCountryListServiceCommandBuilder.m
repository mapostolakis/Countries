//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListServiceCommandBuilder.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MGAFetchCountryListService.h"

@interface MGAFetchCountryListServiceCommandBuilder ()

@property (nonatomic, readonly) id <MGAFetchCountryListService> service;

@end

@implementation MGAFetchCountryListServiceCommandBuilder

- (instancetype)initWithService:(id <MGAFetchCountryListService>)service
{
    self = [super init];
    if (self) {
        _service = service;
    }
    return self;
}

- (RACCommand *)build
{
    id <MGAFetchCountryListService> service = self.service;
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[service fetchCountries] deliverOn:[RACScheduler mainThreadScheduler]];
    }];
}

@end