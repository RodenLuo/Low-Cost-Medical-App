//
//  TimeOfDayViewController.h
//  TableViewAndButton
//
//  Created by Roden on 9/22/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedProtocol.h"

@interface TimeOfDayViewController : UIViewController
@property (nonatomic, assign) id <SavedProtocol> delegate;
@end