//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAResourceMapper.h"

@protocol MGACountryGateway;

@interface MGAPartialToFullCountryListMapper : NSObject <MGAResourceMapper>

- (instancetype)initWithGateway:(id <MGACountryGateway>)gateway;

@end