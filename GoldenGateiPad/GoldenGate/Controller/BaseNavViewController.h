//
//  BaseNavViewController.h
//  GoldenGate
//
//  Created by Andreas Petrov on 9/12/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import "GGBaseViewController.h"

@class NavAction;

/*!
 @abstract 
 The base view controller for all view controllers that can be navigated to via the 
 top left navigation button or content panels.
 
 It also creates a search bar.
 */
@interface BaseNavViewController : GGBaseViewController


- (id)initWithNavAction:(NavAction*)navAction;


/*!
 @abstract 
 Used by the framework to set a name for the navigation button.
 @note
 Default implementation returns navAction.name. 
 If navButtonText == nil the navigation button will not be displayed.
 */
- (NSString*)navButtonText;

/*!
 @abstract
 The NavAction used to navigate to this view.
 */
@property (weak, nonatomic) NavAction *navAction;

@end
