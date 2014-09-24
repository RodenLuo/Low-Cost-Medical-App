//
//  MondayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "MondayNotification.h"

@implementation MondayNotification

+ (MondayNotification *)sharedInstance
{
    static MondayNotification *mondayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        mondayNotification = [[MondayNotification alloc] init];
    });
    return mondayNotification;
}

- (id)initMondayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [MondayNotification sharedInstance];
}
@end
