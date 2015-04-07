//
//  Zuoxin_comAppDelegate.m
//  ZuoxinApp
//
//  Created by 杨海鹏 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "Zuoxin_comAppDelegate.h"
#import "TabBarController.h"
//#import "WeiboSK.h"
#import "CUConfig.h"
#import "CUShareCenter.h"
#import "CUSinaShareClient.h"
#define LOGIN_DATA_FILEPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"loginData.plist"]



@implementation Zuoxin_comAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kOAuthConsumerKey_sina];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabBarController = [[TabBarController alloc] init];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
    
    [self registerForRemoteNotificationToGetToken];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    CUSinaShareClient *sinaClient =
    (CUSinaShareClient *)[CUShareCenter sharedInstanceWithType:SINACLIENT].shareClient;
    
    return [ WeiboSDK handleOpenURL:url delegate:sinaClient ];
}

- (void)registerForRemoteNotificationToGetToken
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72) ] substringWithRange:NSMakeRange(1, 71)];
    NSLog(@"deviceTokenStr = %@",deviceTokenStr);
    
    //save DeviceToken on the NSUserDefault

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"TokenKey"];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *str = [NSString stringWithFormat:@"%@",error];
    NSLog(@"获取指令失败：%@",str);
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
