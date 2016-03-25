//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListService.h"

@protocol MGAResourceMapper, MGAConverter;

@interface MGAFetchCountryListAPIService : NSObject <MGAFetchCountryListService>

- (instancetype)initWithSession:(NSURLSession *)session
                            url:(NSURL *)url
                 resourceMapper:(id <MGAResourceMapper>)mapper
                      converter:(id <MGAConverter>)converter;

@end