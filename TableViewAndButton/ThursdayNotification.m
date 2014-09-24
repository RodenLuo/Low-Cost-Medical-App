//
//  ThursdayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "ThursdayNotification.h"

@implementation ThursdayNotification
+ (ThursdayNotification *)sharedInstance
{
    static ThursdayNotification *thursdayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        thursdayNotification = [[ThursdayNotification alloc] init];
    });
    return thursdayNotification;
}

- (id)initThursdayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [ThursdayNotification sharedInstance];
}
@end