//
//  AppDelegate.m
//  ParseChat
//
//  Created by ezietz on 7/10/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    ParseClientConfiguration *configuration = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"parseChatID";
        configuration.server = @"https://blooming-thicket-89345.herokuapp.com/parse";
    }];
    [Parse initializeWithConfiguration:configuration];
    
    if (PFUser.currentUser != nil) {
        NSLog(@"Welcome back %@ 😀", PFUser.currentUser.username);
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *chatNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"ChatNavigationController"];
        self.window.rootViewController = chatNavigationController;
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
