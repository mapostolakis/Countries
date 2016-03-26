//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAInMemoryStoreGateway.h"
#import "MGAInMemoryStore.h"
#import "MGAFlattenCountry.h"

@interface MGAInMemoryStoreGateway ()

@property (nonatomic, readonly) MGAInMemoryStore *store;

@end

@implementation MGAInMemoryStoreGateway

- (instancetype)initWithStore:(MGAInMemoryStore *)store
{
    self = [super init];
    if (self) {
        _store = store;
    }
    return self;
}

- (id <MGACountry>)countryWithAlpha3Code:(NSString *)code
{
    NSArray *countries = self.store.cachedObject;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"alpha3Code = %@", code];
    NSArray *filteredArray = [countries filteredArrayUsingPredicate:predicate];
    return filteredArray.count > 0 ? filteredArray.firstObject : [self createCountryForCode:code];
}

- (id <MGACountry>)createCountryForCode:(NSString *)code
{
    id <MGACountry> country = [[MGAFlattenCountry alloc] init];
    country.alpha3Code = code;
    return country;
}

@end