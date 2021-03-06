//
//  EndingDateViewController.m
//  TableViewAndButton
//
//  Created by Roden on 9/24/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "EndingDateViewController.h"

@interface EndingDateViewController ()
@property (strong, nonatomic) UIDatePicker *timeOfDayPicker;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@end

@implementation EndingDateViewController

- (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

- (UIDatePicker *)timeOfDayPicker
{
    if (!_timeOfDayPicker) {
        _timeOfDayPicker = [[UIDatePicker alloc] init];
        [_timeOfDayPicker setDatePickerMode:UIDatePickerModeDate];
    }
    [_timeOfDayPicker setMinimumDate:[NSDate date]];
    return _timeOfDayPicker;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(1, 0, 298, 36)];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(saveTime)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    toolBar.items = [[NSArray alloc] initWithObjects:spaceItem, barButtonDone, nil];
    [self.view addSubview:toolBar];
    
    CGRect pickerFrame = CGRectMake(0, 30, 0, 0);
    [self.timeOfDayPicker setFrame:pickerFrame];
    [self.view addSubview:self.timeOfDayPicker];
    
    //Set default time
    NSDate *savedTime = [self.userDefaults objectForKey:@"timer_ending_date"];
    if (savedTime) {
        self.timeOfDayPicker.date = savedTime;
    }else{
        self.timeOfDayPicker.date = [NSDate date];
    }
}

- (void)saveTime
{
    [self.userDefaults setObject:self.timeOfDayPicker.date forKey:@"timer_ending_date"];
    [self.delegate savedTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
