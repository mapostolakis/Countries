//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "UITabBarItem+MGAFactory.h"

@implementation UITabBarItem (MGAFactory)

+ (instancetype)countryList
{
    UIImage *image = [UIImage imageNamed:@"globe"];
    UIImage *selectedImage = [UIImage imageNamed:@"globe_filled"];
    return [[self alloc] initWithTitle:@"Country List" image:image selectedImage:selectedImage];
}

+ (instancetype)map
{
    UIImage *image = [UIImage imageNamed:@"map_pin"];
    UIImage *selectedImage = [UIImage imageNamed:@"map_pin_filled"];
    return [[self alloc] initWithTitle:@"Map" image:image selectedImage:selectedImage];
}

@end