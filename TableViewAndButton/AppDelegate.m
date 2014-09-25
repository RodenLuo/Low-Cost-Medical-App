//
//  AppDelegate.m
//  TableViewAndButton
//
//  Created by Roden on 9/21/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    NSArray *notificationArray = [application scheduledLocalNotifications];
    if ([notificationArray count] > 0) {
        for (UILocalNotification * notification in notificationArray){
            
            //Output date in NSLog.
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
            dateFormatter.dateStyle = NSDateFormatterShortStyle;
            dateFormatter.timeStyle = NSDateFormatterShortStyle;
            NSString *dateString = [dateFormatter stringFromDate:notification.fireDate];
            
            NSDate *endingDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"timer_ending_date"];
            NSString *endingDateString = [dateFormatter stringFromDate:endingDate];
            NSLog(@"Ending date is at %@.",endingDateString);
            NSLog(@"Notification date is at %@", dateString);
            
            if ([notification.fireDate compare:endingDate] == NSOrderedDescending) {
                [application cancelLocalNotification:notification];
                NSLog(@"The notification at %@ has been cancelled!\n\n",dateString);
            }else{
                NSLog(@"We have notification at %@.\n\n",dateString);
            }
        }
    }else{
        NSLog(@"We do not have any UILocalNotification!");
    }
    return YES;
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
