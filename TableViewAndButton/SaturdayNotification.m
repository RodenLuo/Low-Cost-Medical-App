//
//  SaturdayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "SaturdayNotification.h"

@implementation SaturdayNotification
+ (SaturdayNotification *)sharedInstance
{
    static SaturdayNotification *saturdayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        saturdayNotification = [[SaturdayNotification alloc] init];
    });
    return saturdayNotification;
}

- (id)initSaturdayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [SaturdayNotification sharedInstance];
}
@end