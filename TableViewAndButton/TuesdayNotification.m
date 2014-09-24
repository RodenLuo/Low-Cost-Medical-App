//
//  TuesdayNotification.m
//  SimpleClock2
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "TuesdayNotification.h"

@implementation TuesdayNotification
+ (TuesdayNotification *)sharedInstance
{
    static TuesdayNotification *tuesdayNotification;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        tuesdayNotification = [[TuesdayNotification alloc] init];
    });
    return tuesdayNotification;
}

- (id)initTuesdayNotification
{
    self = [super init];
    if (self) {
        // Do some initializing works
    }
    return self;
}

-(id)init
{
    return [TuesdayNotification sharedInstance];
}
@end
