//
//  MyTableViewController.m
//  TableViewAndButton
//
//  Created by Roden on 9/21/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "MyTableViewController.h"
//Audio Handling header
#import "MCSoundBoard.h"


@interface MyTableViewController ()
{
    int timerCount;
}
@property (weak, nonatomic) IBOutlet UITextField *strength;
@property (weak, nonatomic) IBOutlet UITextField *repetitions;
@property (weak, nonatomic) IBOutlet UITextField *intervals;
@property (weak, nonatomic) IBOutlet UILabel *drugConsumingLabel;
@property (strong, nonatomic) NSTimer * oneTimer;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *powerButton;
@property (strong, nonatomic) NSString *powerState;
@property (strong, nonatomic) NSString *onOffState;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
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
    [self setDrugConsuming];
    [self setButtonDefaults];
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
    [self setDrugConsuming];
    [self presentMessage:@"Saved drug settings successfully!"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setDefaultSettings];
    self.powerState = @"POWER_OFF";
    self.onOffState = @"STOP";
    [self setAudioPath];
    self.stateLabel.text = @"Prepared to Go.";
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
    [self setDrugConsuming];
}

- (void)setDrugConsuming
{
    NSInteger strengthTemp = [self.strength.text integerValue];
    NSInteger repetitionsTemp = [self.repetitions.text integerValue];
    self.drugConsumingLabel.text = [NSString stringWithFormat:@"%d", (int)strengthTemp*(int)repetitionsTemp];
}

- (void)presentMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


//Audio handling
-(void)setAudioPath
{
    [MCSoundBoard addAudioAtPath:[[NSBundle mainBundle] pathForResource:@"0xFFFF.wav" ofType:nil] forKey:@"play"];
    [MCSoundBoard addAudioAtPath:[[NSBundle mainBundle] pathForResource:@"Power.wav" ofType:nil] forKey:@"loop"];
//    [MCSoundBoard addAudioAtPath:[[NSBundle mainBundle] pathForResource:@"Power.wav" ofType:nil] forKey:@"loop"];
    AVAudioPlayer *player = [MCSoundBoard audioPlayerForKey:@"loop"];
    player.numberOfLoops = -1;  // Endless
}

- (void)startTimer
{
    [_oneTimer invalidate];
    _oneTimer = [NSTimer scheduledTimerWithTimeInterval:[self.intervals.text intValue] target:self selector:@selector(play0xFFFF) userInfo:nil repeats:YES];
}

- (IBAction)playAudio:(id)sender
{
    self.stateLabel.text = [NSString stringWithFormat:@"Go at %d ml. Times: %d", [self.strength.text intValue], timerCount];
    [self startTimer];
    self.onOffState = @"GO";
    [self setButtonDefaults];
}

- (void)play0xFFFF
{
    if (timerCount < [self.repetitions.text intValue]) {
        [MCSoundBoard playAudioForKey:@"play"];
        timerCount++;
        self.stateLabel.text = [NSString stringWithFormat:@"Go at %d ml. Times: %d", [self.strength.text intValue], timerCount];
    }else{
        [_oneTimer invalidate];
        _oneTimer = nil;
        self.onOffState = @"STOP";
        [self setButtonDefaults];
        self.stateLabel.text = [NSString stringWithFormat:@"Go at %d ml. Times: %d. Finished!", [self.strength.text intValue], timerCount];
        timerCount = 0;
    }
}

- (IBAction)pauseAudio:(id)sender
{
    [_oneTimer invalidate];
    [self setButtonDefaults];
    self.onOffState = @"PAUSE";
    [self setButtonDefaults];
    self.stateLabel.text = [NSString stringWithFormat:@"Go at %d ml. Times: %d. Paused!", [self.strength.text intValue], timerCount];
}

- (IBAction)stopAudio:(id)sender
{
    [_oneTimer invalidate];
    self.stateLabel.text = [NSString stringWithFormat:@"Go at %d ml. Times: %d. Stopped!", [self.strength.text intValue], timerCount];
    timerCount = 0;
    self.onOffState = @"STOP";
    [self setButtonDefaults];

}

- (void)loopPowerAudio
{
    AVAudioPlayer *player = [MCSoundBoard audioPlayerForKey:@"loop"];
    if (player.playing) {
        [MCSoundBoard pauseAudioForKey:@"loop"];
//        [MCSoundBoard pauseAudioForKey:@"loop" fadeOutInterval:2.0];
    } else {
        [MCSoundBoard playAudioForKey:@"loop"];
    }
}

- (void)canSave
{
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton sizeToFit];
    [self.saveButton setEnabled:YES];
    self.strength.enabled = YES;
    self.repetitions.enabled = YES;
    self.intervals.enabled = YES;
}
- (void)canNotSave
{
    [self.saveButton setTitle:@"Stop and Power Off to Save" forState:UIControlStateNormal];
    [self.saveButton sizeToFit];
    [self.saveButton setEnabled:NO];
    self.strength.enabled = NO;
    self.repetitions.enabled = NO;
    self.intervals.enabled = NO;
}
- (void)setButtonDefaults
{
    if ([self.powerState isEqualToString:@"POWER_ON"]) {
        [self canNotSave];
        if ([self.onOffState isEqualToString:@"GO"]) {
            [self.goButton setEnabled:NO];
            [self.pauseButton setEnabled:YES];
            [self.stopButton setEnabled:YES];
            [self.powerButton setEnabled:NO];
        }else if ([self.onOffState isEqualToString:@"PAUSE"]){
            [self.goButton setEnabled:YES];
            [self.pauseButton setEnabled:NO];
            [self.stopButton setEnabled:YES];
            [self.powerButton setEnabled:YES];
        }else if ([self.onOffState isEqualToString:@"STOP"]){
            [self.goButton setEnabled:YES];
            [self.pauseButton setEnabled:NO];
            [self.stopButton setEnabled:NO];
            [self.powerButton setEnabled:YES];
        }
    }else if ([self.powerState isEqualToString:@"POWER_OFF"]){
        if ([self.onOffState isEqualToString:@"PAUSE"]){
            [self.goButton setEnabled:NO];
            [self.pauseButton setEnabled:NO];
            [self.stopButton setEnabled:YES];
            [self.powerButton setEnabled:YES];
            [self canNotSave];
        }else if ([self.onOffState isEqualToString:@"STOP"]){
            [self.goButton setEnabled:NO];
            [self.pauseButton setEnabled:NO];
            [self.stopButton setEnabled:NO];
            [self.powerButton setEnabled:YES];
            [self canSave];
        }
    }
    
}
- (IBAction)powerButtonTapped:(id)sender {
    if ([self.powerState isEqualToString:@"POWER_ON"]) {
        [self loopPowerAudio];
        [self.powerButton setTitle:@"Power On" forState:UIControlStateNormal];
        self.powerState = @"POWER_OFF";
        [self setButtonDefaults];
    }else if ([self.powerState isEqualToString:@"POWER_OFF"]){
        [self loopPowerAudio];
        [self.powerButton setTitle:@"Power Off" forState:UIControlStateNormal];
        self.powerState = @"POWER_ON";
        [self setButtonDefaults];
    }
}
@end
