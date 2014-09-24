//
//  FridayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "FridayNotification.h"

@implementation FridayNotification
+ (FridayNotification *)sharedInstance
{
    static FridayNotification *fridayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        fridayNotification = [[FridayNotification alloc] init];
    });
    return fridayNotification;
}

- (id)initFridayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [FridayNotification sharedInstance];
}
@end
