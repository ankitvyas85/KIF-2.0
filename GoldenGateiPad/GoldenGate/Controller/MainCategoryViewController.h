//
//  MainCategoryViewController.h
//  GoldenGate
//
//  Created by Andreas Petrov on 8/20/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoadingView.h"
#import "BaseNavViewController.h"
#import "GridViewController.h"

@class ContentCategory;

/*!
 @abstract This view controller is used to display featured content for a main category.
 */
@interface MainCategoryViewController : BaseNavViewController <LoadingViewDelegate, GridViewControllerDelegate>

@property (strong, nonatomic) ContentCategory *category;

@end
