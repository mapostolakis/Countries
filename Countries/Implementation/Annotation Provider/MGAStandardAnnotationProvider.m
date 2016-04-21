//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardAnnotationProvider.h"
#import "MGASingleSectionDataSource.h"
#import "MGACountry.h"
#import "MGACountryAnnotationBuilder.h"

@interface MGAStandardAnnotationProvider ()

@property (nonatomic, readonly) id <MGADataSource> dataSource;

@end

@implementation MGAStandardAnnotationProvider

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource
{
    self = [super init];
    if (self) {
        _dataSource = dataSource;
    }
    return self;
}

- (NSArray <id <MKAnnotation>> *)createCountryListAnnotations
{
    NSMutableArray *annotations = [NSMutableArray array];
    for (NSInteger index=0; index<[self.dataSource numberOfObjectsInSection:0]; index++) {
        id <MGACountry> country = [self.dataSource objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        MGACountryAnnotation *annotation = [[[MGACountryAnnotationBuilder alloc] initWithCountry:country] build];
        [annotations addObject:annotation];
    }
    return [annotations copy];
}

@end