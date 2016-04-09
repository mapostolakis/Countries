//
//  Copyright © 2016 Mike Apostolakis. All rights reserved.
//

#import "AppDelegate.h"
#import "MGAContext.h"

@implementation AppDelegate

- (MGAContext *)appContext
{
    if (_appContext == nil) {
        _appContext = [MGAContext new];
        [_appContext start];
    }
    return _appContext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:frame];
    self.window.rootViewController = [self.appContext rootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
