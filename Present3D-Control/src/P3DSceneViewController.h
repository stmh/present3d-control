//
//  P3DSceneViewController.h
//  Present3D-Control
//
//  Created by Stephan Huber on 14.10.13.
//  Copyright (c) 2013 Stephan Huber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface P3DSceneViewController : UIViewController {

    IBOutlet UIButton* toggleButton;
    IBOutlet UIView* loadingView;

}

- (IBAction)toggleButtonTapped:(id)sender;
- (void)startReadingSequence;
- (void)stopReadingSequence;
- (void)initCommon;
- (void)guidedAccessChanged;

@end
