//
//  WeekDayNotificationArray.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "WeekDayNotificationArray.h"

@implementation WeekDayNotificationArray
+ (WeekDayNotificationArray *)sharedInstance
{
    static WeekDayNotificationArray *weekDayNotificationArray;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        weekDayNotificationArray = (WeekDayNotificationArray *)@[[[UILocalNotification alloc] init],
                                     [[UILocalNotification alloc] init],
                                     [[UILocalNotification alloc] init],
                                     [[UILocalNotification alloc] init],
                                     [[UILocalNotification alloc] init],
                                     [[UILocalNotification alloc] init],
                                     [[UILocalNotification alloc] init]];
    });
    return weekDayNotificationArray;
}

- (id)initSundayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [WeekDayNotificationArray sharedInstance];
}
@end