//
//  SundayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "SundayNotification.h"

@implementation SundayNotification
+ (SundayNotification *)sharedInstance
{
    static SundayNotification *sundayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        sundayNotification = [[SundayNotification alloc] init];
    });
    return sundayNotification;
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
    return [SundayNotification sharedInstance];
}
@end