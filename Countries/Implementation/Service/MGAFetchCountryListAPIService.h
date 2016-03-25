//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAFetchCountryListService.h"

@interface MGAFetchCountryListAPIService : NSObject <MGAFetchCountryListService>

- (instancetype)initWithSession:(NSURLSession *)session url:(NSURL *)url;

@end