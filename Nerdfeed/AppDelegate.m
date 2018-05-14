//
//  AppDelegate.m
//  Nerdfeed
//
//  Created by Zaur Giyasov on 14/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "AppDelegate.h"
#import "CoursesTableViewController.h"
#import "WebViewController.h"

@interface CoursesTableViewController()

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"AppDelegate.m - %@", NSStringFromSelector(_cmd));
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    CoursesTableViewController *ctvc = [[CoursesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:ctvc];
    WebViewController *wvc = [[WebViewController alloc] init];
    ctvc.webViewController = wvc;
    
    self.window.rootViewController = masterNavigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
