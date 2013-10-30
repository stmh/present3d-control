//
//  P3DSceneViewController.m
//  Present3D-Control
//
//  Created by Stephan Huber on 14.10.13.
//  Copyright (c) 2013 Stephan Huber. All rights reserved.
//

#import "P3DSceneViewController.h"
#import "P3DMenuViewController.h"

@interface P3DSceneViewController ()

@end

@implementation P3DSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initCommon];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder ];
    if (self) {
        [self initCommon];
    }
    return self;

}

- (void)initCommon
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(guidedAccessChanged) name:UIAccessibilityGuidedAccessStatusDidChangeNotification object:nil];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)guidedAccessChanged
{
    bool toggle_btn_enabled = !(UIAccessibilityIsGuidedAccessEnabled());
    
    [UIView animateWithDuration:0.25 animations:^{ toggleButton.alpha = toggle_btn_enabled ? 1 : 0;}];
    
    if (!toggle_btn_enabled) {
        [self.slidingViewController resetTopView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (![self.slidingViewController.underLeftViewController isKindOfClass:[P3DMenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }

    // TODO
    //[self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout = ECFixedRevealWidth;


    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleButtonTapped:(id)sender
{
    if([self.slidingViewController underLeftShowing])
        [self.slidingViewController resetTopView];
    else
        [self.slidingViewController anchorTopViewTo: ECRight animations:nil onComplete:nil];
}

- (void)startReadingSequence
{
    [self.slidingViewController resetTopView];
    
    loadingView.hidden = FALSE;
    loadingView.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{ loadingView.alpha = 1.0;}];
}

- (void)stopReadingSequence
{
    [UIView animateWithDuration:0.25 animations:^{ loadingView.alpha = 0.0;}];
}

@end
