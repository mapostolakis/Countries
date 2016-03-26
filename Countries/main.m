//
//  Copyright © 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        BOOL isTesting = NSClassFromString(@"XCTestCase") != Nil;
        NSString *appDelegateClass = isTesting ? nil : NSStringFromClass([AppDelegate class]);
        return UIApplicationMain(argc, argv, nil, appDelegateClass);
    }
}
