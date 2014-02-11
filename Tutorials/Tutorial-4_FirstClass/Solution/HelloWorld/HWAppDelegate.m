//
//  HWAppDelegate.m
//  HelloWorld
//
//  Created by Michael Mühlebach on 10/02/14.
//  Copyright (c) 2014 Zühlke. All rights reserved.
//

#import "HWAppDelegate.h"
#import "Message.h"

@implementation HWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self sayHello:@"Michael"];
    
    
    [self printMessages];
    
    
    return YES;
}


- (void)sayHello:(NSString*)name
{
    NSLog(@"Hello %@!", name);
}

- (void)printMessages
{
    Message* msg1 = [[Message alloc] init];
    Message* msg2 = [[Message alloc] init];
    
    msg1.author = @"Tim";
    msg1.text = @"Objective-C is a nice language";
    
    msg2.author = @"Marissa";
    msg2.text = @"Excited about blocks aka closures in Objective-C";
    
    
    NSDictionary* dict = @{msg1.author: msg1, msg2.author: msg2};
    
    NSLog(@"String representation of this dictionary: %@", dict);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
