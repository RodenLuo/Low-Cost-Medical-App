//
//  WeatherViewController.m
//  TableViewAndButton
//
//  Created by Roden on 9/26/14.
//  Copyright (c) 2014 Roden. All rights reserved.
//

#import "WeatherViewController.h"
#import "PageControl.h"

@interface WeatherViewController ()
@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) PageControl * pageControl;
@property (strong, nonatomic) UILabel *viewFirstLabel;
@property (strong, nonatomic) UILabel *viewSecondLabel;
@property (strong, nonatomic) UILabel *viewThirdLabel;

@property (strong, nonatomic) BEMSimpleLineGraphView *firstGraph;
@property (strong, nonatomic) BEMSimpleLineGraphView *secondGraph;
@property (strong, nonatomic) BEMSimpleLineGraphView *thirdGraph;

@end

@implementation WeatherViewController

- (BEMSimpleLineGraphView *)firstGraph
{
    if (!_firstGraph) {
         _firstGraph = [self createAGraph];
    }
    return _firstGraph;
}
- (BEMSimpleLineGraphView *)secondGraph
{
    if (!_secondGraph) {
        _secondGraph = [self createAGraph];
    }
    return _secondGraph;
}
- (BEMSimpleLineGraphView *)thirdGraph
{
    if (!_thirdGraph) {
        _thirdGraph = [self createAGraph];
    }
    return _thirdGraph;
}
- (BEMSimpleLineGraphView *)createAGraph
{
    BEMSimpleLineGraphView * aGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(8, 26, 305, 177)];
    aGraph.dataSource = self;
    aGraph.delegate = self;

    aGraph.colorTop = [UIColor whiteColor];
    aGraph.colorBottom = [UIColor whiteColor];

    aGraph.colorLine = [UIColor blueColor];
    aGraph.widthLine = 1.0;

    aGraph.colorXaxisLabel = [UIColor blackColor];
    aGraph.colorYaxisLabel = [UIColor blackColor];

    aGraph.enableTouchReport = YES;
    aGraph.enablePopUpReport = YES;

    aGraph.enableBezierCurve = YES;

    aGraph.enableYAxisLabel = YES;

    aGraph.autoScaleYAxis = YES;

    aGraph.alwaysDisplayDots = YES;

    aGraph.enableReferenceAxisLines = YES;
    aGraph.enableReferenceAxisFrame = YES;

    aGraph.animationGraphStyle = BEMLineAnimationDraw;

    return aGraph;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    CGRect frame = self.view.frame;
    frame.origin.y = 0.0f;
    UIView* viewFirst = [[UIView alloc] initWithFrame:frame];

    
    frame.origin.x += self.view.frame.size.width;
    UIView* viewSecond = [[UIView alloc] initWithFrame:frame];

    
    frame.origin.x += self.view.frame.size.width;
    UIView* viewThird = [[UIView alloc] initWithFrame:frame];

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    [_scrollView addSubview:viewFirst];
    [_scrollView addSubview:viewSecond];
    [_scrollView addSubview:viewThird];

    CGSize sizeViewFirstLabel = CGSizeMake(120, 32);
    CGRect frameViewFirstLabel = CGRectMake(58, 0, sizeViewFirstLabel.width, sizeViewFirstLabel.height);
    _viewFirstLabel = [[UILabel alloc] initWithFrame:frameViewFirstLabel];
    _viewFirstLabel.text = @"Temperature:";
    [viewFirst addSubview:_viewFirstLabel];
    [viewFirst addSubview:self.firstGraph];
    
    CGSize sizeViewSecondLabel = CGSizeMake(120, 32);
    CGRect frameViewSecondLabel = CGRectMake(58, 0, sizeViewSecondLabel.width, sizeViewSecondLabel.height);
    _viewSecondLabel = [[UILabel alloc] initWithFrame:frameViewSecondLabel];
    _viewSecondLabel.text = @"Second:";
    [viewSecond addSubview:_viewSecondLabel];
    [viewSecond addSubview:self.secondGraph];
    
    CGSize sizeViewThirdLabel = CGSizeMake(120, 32);
    CGRect frameViewThirdLabel = CGRectMake(58, 0, sizeViewThirdLabel.width, sizeViewThirdLabel.height);
    _viewThirdLabel = [[UILabel alloc] initWithFrame:frameViewThirdLabel];
    _viewThirdLabel.text = @"Third:";
    [viewThird addSubview:_viewThirdLabel];
    [viewThird addSubview:self.thirdGraph];
    
    CGSize sizePageControl = CGSizeMake(70, 36);
    CGRect framePageControl = CGRectMake(0, 0, sizePageControl.width, sizePageControl.height);
    _pageControl = [[PageControl alloc] initWithFrame:framePageControl];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 3;
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControl];
    
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(_scrollView.contentOffset.x)/self.view.frame.size.width;
    
    _pageControl.currentPage = index;
}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    int i = 7;
    if (graph == self.firstGraph) {
        i = 5;
        
    }else if (graph == self.secondGraph) {
        i = 6;
        
    }else if (graph == self.thirdGraph){
        i = 7;
        
    }
    
    return i;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    int i = (int)index;
    if (graph == self.firstGraph) {
        i = (int)index + 1;
        
    }else if (graph == self.secondGraph) {
        i = (int)index + 2;
        
    }else if (graph == self.thirdGraph){
        i = (int)index + 1000;
        
    }
    
    return i;
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
