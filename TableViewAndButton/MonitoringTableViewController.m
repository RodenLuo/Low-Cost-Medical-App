//
//  MonitoringTableViewController.m
//  TableViewAndButton
//
//  Created by Roden on 9/26/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "MonitoringTableViewController.h"

@interface MonitoringTableViewController ()
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;

@end

@implementation MonitoringTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //Setting for the drug use graph
    self.myGraph.colorTop = [UIColor whiteColor];
    self.myGraph.colorBottom = [UIColor whiteColor];
    
    //    self.myGraph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    //    self.myGraph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    
    self.myGraph.colorLine = [UIColor blueColor];
    self.myGraph.widthLine = 1.0;
    
    self.myGraph.colorXaxisLabel = [UIColor blackColor];
    self.myGraph.colorYaxisLabel = [UIColor blackColor];
    
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    
    self.myGraph.enableBezierCurve = YES;
    
    self.myGraph.enableYAxisLabel = YES;
    
    self.myGraph.autoScaleYAxis = YES;
    
    self.myGraph.alwaysDisplayDots = YES;
    
    self.myGraph.enableReferenceAxisLines = YES;
    self.myGraph.enableReferenceAxisFrame = YES;
    
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
}

#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 7;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    return index;
}

#pragma mark - SimpleLineGraph Delegate
- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    if (index < 1) {
        return [NSString stringWithFormat:@"  %zd",index+1];
    } else{
        return [NSString stringWithFormat:@"%zd",index+1];
    }
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 0;
}

@end
