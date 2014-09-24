//
//  MyTableViewController.m
//  TableViewAndButton
//
//  Created by Roden on 9/21/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *strength;
@property (weak, nonatomic) IBOutlet UITextField *repetitions;
@property (weak, nonatomic) IBOutlet UITextField *intervals;
@property (weak, nonatomic) IBOutlet UILabel *drugConsumingLabel;

@end

@implementation MyTableViewController
- (IBAction)saveButtonTapped:(id)sender {
    [self.tableView endEditing:YES];
    [self saveDefaultSettings];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-  (void)setDefaultSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger *strength = (NSInteger *)[userDefaults integerForKey:@"drug_strength"];
    NSInteger *repetitions = (NSInteger *)[userDefaults integerForKey:@"drug_repetitions"];
    NSInteger *intervals = (NSInteger *)[userDefaults integerForKey:@"drug_intervals"];
    if (strength) {
        [self.strength setText:[NSString stringWithFormat:@"%zd",strength]];
    }
    if (repetitions) {
        [self.repetitions setText:[NSString stringWithFormat:@"%zd",repetitions]];
    }
    if (intervals) {
        [self.intervals setText:[NSString stringWithFormat:@"%zd",intervals]];
    }
    self.drugConsumingLabel.text = [NSString stringWithFormat:@"%d", (int)strength*(int)repetitions];
}

-  (void)saveDefaultSettings
{
    NSInteger strength = [self.strength.text integerValue];
    NSInteger repetitions = [self.repetitions.text integerValue];
    NSInteger intervals = [self.intervals.text integerValue];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:strength forKey:@"drug_strength"];
    [userDefaults setInteger:repetitions forKey:@"drug_repetitions"];
    [userDefaults setInteger:intervals forKey:@"drug_intervals"];
    [self presentMessage:@"Saved drug settings successfully!"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setDefaultSettings];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Hide keyboard
    [self.tableView endEditing:YES];
    
    //Set drug consuming
    NSInteger strength = [self.strength.text integerValue];
    NSInteger repetitions = [self.repetitions.text integerValue];
    self.drugConsumingLabel.text = [NSString stringWithFormat:@"%d", (int)strength*(int)repetitions];
}

- (void)presentMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
