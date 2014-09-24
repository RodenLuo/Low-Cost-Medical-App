//
//  EndingDateViewController.h
//  TableViewAndButton
//
//  Created by Roden on 9/24/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedProtocol.h"

@interface EndingDateViewController : UIViewController
@property (nonatomic, assign) id <SavedProtocol> delegate;
@end