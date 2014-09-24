//
//  PopoverViewController.m
//  PopoverViewIniPhone
//
//  Created by Roden on 9/16/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "DaysOfWeekPopoverViewController.h"

@interface DaysOfWeekPopoverViewController ()
@property(nonatomic,strong)NSArray *menus;
@property(nonatomic, strong)NSMutableArray *weekDayCheckValue;
@end

@implementation DaysOfWeekPopoverViewController

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

-(NSArray *)menus
{
    if (_menus==nil) {
        _menus=@[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    }
    return _menus;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menus.count;
}

// The checkmark will be removed when another row is selected
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil )
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (((NSNumber *)self.weekDayCheckValue[(int)indexPath.row]).intValue == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (((NSNumber *)self.weekDayCheckValue[(int)indexPath.row]).intValue == 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text=self.menus[indexPath.row];
    return cell;
}

// UITableView Delegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (((NSNumber *)self.weekDayCheckValue[indexPath.row]).intValue == 0) {
        [self.weekDayCheckValue replaceObjectAtIndex:indexPath.row withObject:@1];
    }else{
        [self.weekDayCheckValue replaceObjectAtIndex:indexPath.row withObject:@0];
    }
    [tableView reloadData];
    
    // Save weekDayCheckValue into standardUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.weekDayCheckValue forKey:@"weekDayCheckValue"];
}

@end
