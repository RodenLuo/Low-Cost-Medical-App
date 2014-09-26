//
//  TimerTableViewController.m
//  TableViewAndButton
//
//  Created by Roden on 9/22/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "TimerTableViewController.h"
#import <WYPopoverController.h>

#import "TimeOfDayViewController.h"
#import "DaysOfWeekPopoverViewController.h"
#import "StartingDateViewController.h"
#import "EndingDateViewController.h"

#import "SundayNotification.h"
#import "MondayNotification.h"
#import "TuesdayNotification.h"
#import "WednesdayNotification.h"
#import "ThursdayNotification.h"
#import "FridayNotification.h"
#import "SaturdayNotification.h"

@interface TimerTableViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController *timePopoverController;
    WYPopoverController *daysOfWeekPopoverController;
    WYPopoverController *startingDatePopoverController;
    WYPopoverController *endingDatePopoverController;
}


@property (strong, nonatomic) NSUserDefaults * userDefaults;
@property (strong, nonatomic) TimeOfDayViewController *timeOfDayViewController;
@property (strong, nonatomic) DaysOfWeekPopoverViewController * daysOfWeekViewController;
@property (strong, nonatomic) StartingDateViewController * startingDateViewController;
@property (strong, nonatomic) EndingDateViewController * endingDateViewController;

@property (weak, nonatomic) IBOutlet UIButton *timeOfDayLabel;
@property (weak, nonatomic) IBOutlet UIButton *dayOfWeekLabel;
@property (weak, nonatomic) IBOutlet UIButton *startingDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *endingDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timerSituationLabel;
@property (weak, nonatomic) IBOutlet UILabel *drugWillBeUsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *drugRemainingLabel;


//Property for alarm
@property (strong, nonatomic) NSArray * weekDayNotification;
@property (nonatomic, strong) NSMutableArray *weekDayCheckValue;

@end

@implementation TimerTableViewController

- (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

- (TimeOfDayViewController *)timeOfDayViewController
{
    if (!_timeOfDayViewController) {
        _timeOfDayViewController = [[TimeOfDayViewController alloc] init];
        _timeOfDayViewController.preferredContentSize = CGSizeMake(300, 240);
        _timeOfDayViewController.delegate = self;
    }
    return _timeOfDayViewController;
}

- (IBAction)showPopover:(id)sender
{
    timePopoverController = [[WYPopoverController alloc] initWithContentViewController:self.timeOfDayViewController];
    timePopoverController.delegate = self;
    [timePopoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:NO];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDefaults
{
    //Set time
    NSDate *time = [self.userDefaults objectForKey:@"timer_time"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.dateFormat = @"HH : mm";
    if (time) {
        NSString *timeString = [dateFormatter stringFromDate:time];
        [self.timeOfDayLabel setTitle:timeString forState:UIControlStateNormal];
    }
    
    
    //Set starting date
    NSDate *startingDate = [self.userDefaults objectForKey:@"timer_starting_date"];
    NSDateFormatter *startingDateFormatter = [[NSDateFormatter alloc] init];
    startingDateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    startingDateFormatter.dateFormat = @"MMM-dd-yyyy";
    if (startingDate) {
        NSString *startingDateString = [startingDateFormatter stringFromDate:startingDate];
        [self.startingDateLabel setTitle:startingDateString forState:UIControlStateNormal];
    }
    
    //Set ending date
    NSDate *endingDate = [self.userDefaults objectForKey:@"timer_ending_date"];
    if (endingDate) {
        NSString *endingDateString = [startingDateFormatter stringFromDate:endingDate];
        [self.endingDateLabel setTitle:endingDateString forState:UIControlStateNormal];
    }
    //Set Timer situation
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *notificationArray = [application scheduledLocalNotifications];
    if ([notificationArray count] > 0) {
        self.timerSituationLabel.text = @"Timer has already been set.";
    }else{
        self.timerSituationLabel.text = @"Timer has not been set.";
    }
    
    //Set drug will be used
    NSInteger days = [TimerTableViewController daysBetweenDate:[self.userDefaults objectForKey:@"timer_starting_date"] andDate:[self.userDefaults objectForKey:@"timer_ending_date"]];
    self.drugWillBeUsedLabel.text = [NSString stringWithFormat:@"%d", (int)days * (int)[self.userDefaults integerForKey:@"drug_strength"] * (int)[self.userDefaults integerForKey:@"drug_repetitions"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Days of week handling
- (IBAction)daysOfWeekTapped:(id)sender {
    daysOfWeekPopoverController = [[WYPopoverController alloc] initWithContentViewController:self.daysOfWeekViewController];
    [daysOfWeekPopoverController presentPopoverFromRect:self.dayOfWeekLabel.bounds inView:self.dayOfWeekLabel permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES
     ];
}

-(DaysOfWeekPopoverViewController *)daysOfWeekViewController
{
    if (!_daysOfWeekViewController) {
        _daysOfWeekViewController = [[DaysOfWeekPopoverViewController alloc] init];
        _daysOfWeekViewController.preferredContentSize = CGSizeMake(126, 310);
    }
    return _daysOfWeekViewController;
}


//Starting date handling
- (StartingDateViewController *)startingDateViewController
{
    if (!_startingDateViewController) {
        _startingDateViewController = [[StartingDateViewController alloc] init];
        _startingDateViewController.preferredContentSize = CGSizeMake(300, 240);
        _startingDateViewController.delegate = self;
    }
    return _startingDateViewController;
}

- (IBAction)startingDateTapped:(id)sender {
    startingDatePopoverController = [[WYPopoverController alloc] initWithContentViewController:self.startingDateViewController];
    startingDatePopoverController.delegate = self;
    [startingDatePopoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:NO];
}

//Ending date handling
- (EndingDateViewController *)endingDateViewController
{
    if (!_endingDateViewController) {
        _endingDateViewController = [[EndingDateViewController alloc] init];
        _endingDateViewController.preferredContentSize = CGSizeMake(300, 240);
        _endingDateViewController.delegate = self;
    }
    return _endingDateViewController;
}

- (IBAction)endingDateTapped:(id)sender {
    endingDatePopoverController = [[WYPopoverController alloc] initWithContentViewController:self.endingDateViewController];
    endingDatePopoverController.delegate = self;
    [endingDatePopoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:NO];
}


//Start alarm handling

- (NSArray *)weekDayNotification
{
    if (!_weekDayNotification) {
        _weekDayNotification = @[[SundayNotification sharedInstance],
                                 [MondayNotification sharedInstance],
                                 [TuesdayNotification sharedInstance],
                                 [WednesdayNotification sharedInstance],
                                 [ThursdayNotification sharedInstance],
                                 [FridayNotification sharedInstance],
                                 [SaturdayNotification sharedInstance]];
    }
    return _weekDayNotification;
}
- (NSMutableArray *)weekDayCheckValue
{
    if (!_weekDayCheckValue) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *tempCheck = [userDefaults objectForKey:@"weekDayCheckValue"];
        if (!tempCheck) {
            _weekDayCheckValue = [[NSMutableArray alloc] initWithArray:@[@0, @0, @0, @0, @0, @0, @0]];
        }else{
            _weekDayCheckValue = tempCheck;
        }
    }
    return _weekDayCheckValue;
}
-(void) weekEndNotificationOnWeekday: (int)weekday :(UILocalNotification *)notification : (NSDate*) alramTime :(NSDate *) startingDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsForFireTime = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate: startingDate];
    
    NSDateComponents *componentsForAlarmTime = [calendar components:(NSYearCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate: alramTime];
    
    [componentsForFireTime setHour:[componentsForAlarmTime hour]];
    [componentsForFireTime setMinute:[componentsForAlarmTime minute]];
    [componentsForFireTime setSecond:0];
    [componentsForFireTime setWeekday:weekday];

    notification.repeatInterval = NSWeekCalendarUnit;
    notification.fireDate=[calendar dateFromComponents:componentsForFireTime];
    notification.alertBody = @"It is time to take medicine!";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    //Output date set in NSLog.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    NSString *dateString = [dateFormatter stringFromDate:[calendar dateFromComponents:componentsForFireTime]];
    NSLog(@"Alarm set at: %@ !!!",dateString);
}
- (IBAction)setTimerTapped:(id)sender {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    for (int i = 0; i < 7; i++) {
        if (((NSNumber *)self.weekDayCheckValue[i]).intValue == 1) {
            [self weekEndNotificationOnWeekday:i+1 :self.weekDayNotification[i] :[self.userDefaults objectForKey:@"timer_time"] : [self.userDefaults objectForKey:@"timer_starting_date"]];
        }
    }
    [self setDefaults];
    [self presentMessage:@"Set alarm!"];
}

- (IBAction)cancelTimerTapped:(id)sender {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [self presentMessage:@"Timer cancelled!"];
    [self setDefaults];
}
//End alarm handling

- (void)presentMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Timer alarm" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
//Protocol
- (void)savedTime
{
    [timePopoverController dismissPopoverAnimated:NO];
    [startingDatePopoverController dismissPopoverAnimated:NO];
    [endingDatePopoverController dismissPopoverAnimated:NO];
    [self setDefaults];
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}
@end
