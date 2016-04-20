//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGACountryAnnotation;
@protocol MGACountry;

@interface MGACountryAnnotationBuilder : NSObject

- (instancetype)initWithCountry:(id <MGACountry>)country;

- (MGACountryAnnotation *)build;

@end