//
//  WednesdayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "WednesdayNotification.h"

@implementation WednesdayNotification
+ (WednesdayNotification *)sharedInstance
{
    static WednesdayNotification *wednesdayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        wednesdayNotification = [[WednesdayNotification alloc] init];
    });
    return wednesdayNotification;
}

- (id)initWednesdayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [WednesdayNotification sharedInstance];
}
@end

