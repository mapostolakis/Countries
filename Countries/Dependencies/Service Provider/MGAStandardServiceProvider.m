//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardServiceProvider.h"
#import "MGAFetchCountryListAPIService.h"
#import "MGAListResourceMapper.h"
#import "MGACountryMapper.h"
#import "MGAStore.h"
#import "MGAInMemoryStoreGateway.h"
#import "MGADataToJSONConverter.h"
#import "MGAInMemoryStore.h"
#import "MGAPartialCountryMapper.h"

@interface MGAStandardServiceProvider ()

@property (nonatomic, readonly) id <MGAStore> store;

@end

@implementation MGAStandardServiceProvider

- (instancetype)initWithStore:(id <MGAStore>)store
{
    self = [super init];
    if (self) {
        _store = store;
    }
    return self;
}

- (id <MGAFetchCountryListService>)createFetchCountryListService
{
    MGADataToJSONConverter *converter = [MGADataToJSONConverter new];
    MGAInMemoryStoreGateway *gateway = [[MGAInMemoryStoreGateway alloc] initWithStore:self.store];
    MGAPartialCountryMapper *partialCountryMapper = [[MGAPartialCountryMapper alloc] initWithGateway:gateway];
    MGAListResourceMapper *partialCountryListMapper = [[MGAListResourceMapper alloc] initWithResourceMapper:partialCountryMapper];
    MGACountryMapper *countryMapper = [[MGACountryMapper alloc] initWithGateway:gateway listMapper:partialCountryListMapper];
    NSURL *url = [NSURL URLWithString:@"https://restcountries.eu/rest/v1/all"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    MGAListResourceMapper *countryListMapper = [[MGAListResourceMapper alloc] initWithResourceMapper:countryMapper];
    return [[MGAFetchCountryListAPIService alloc] initWithSession:session
                                                              url:url
                                                   resourceMapper:countryListMapper
                                                        converter:converter
                                                            store:self.store];
}

@end