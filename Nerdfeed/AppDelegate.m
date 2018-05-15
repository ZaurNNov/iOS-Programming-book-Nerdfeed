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

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"AppDelegate.m - %@", NSStringFromSelector(_cmd));
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    CoursesTableViewController *ctvc = [[CoursesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *masterNC = [[UINavigationController alloc] initWithRootViewController:ctvc];
    WebViewController *wvc = [[WebViewController alloc] init];
    ctvc.webViewController = wvc;
    
    // check to make sure we are on iPad?
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        //webView must be NC!
        UINavigationController *detailNC = [[UINavigationController alloc] initWithRootViewController:wvc];
        UISplitViewController *svc = [[UISplitViewController alloc] init];
        svc.delegate = self;
        svc.viewControllers = @[masterNC, detailNC];
        self.window.rootViewController = svc;
    } else {
        self.window.rootViewController = masterNC;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
