//
//  BaseNavViewController.m
//  GoldenGate
//
//  Created by Andreas Petrov on 9/12/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import "BaseNavViewController.h"
#import "NavAction.h"

#import "GGSearchDisplayController.h"
#import "GGBarButtonItem.h"
#import "NavigationTableViewController.h"
#import "GGPopoverBackgroundView.h"
#import "Constants.h"
#import "CategoryAction.h"
#import "ContentCategory.h"
#import "GGSegmentedControl.h"
#import "NavActionExecutor.h"
#import "FilterAction.h"
#import "VimondStore.h"
#import "LogoutAction.h"
#import "AppDelegate.h"
#import "GGUsageTracker.h"

#define kSearchBarWidth 180

@interface BaseNavViewController ()

@property (strong, nonatomic) GGSearchDisplayController *customSearchDisplayController;
@property (strong, nonatomic) UIPopoverController *navigationPopover;

@end

@implementation BaseNavViewController

- (id)initWithNavAction:(NavAction *)navAction
{
    if ((self = [super init]))
    {
        _navAction = navAction;
    }

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(self.navAction.parentAction.name, @"");
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    NSArray *leftBarButtonItems = self.navigationItem.leftBarButtonItems;
    
    [self createNavButton];
    [self createSearchBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.customSearchDisplayController.activeSearchDisplayController = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Create it here so it gets re-created every time the view comes back in view.
    [self createFilterSegmentedControl];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissPopover];
    [super viewWillDisappear:animated];
    self.customSearchDisplayController.activeSearchDisplayController = NO;
}

- (UIView *)createSegmentedControllerForAction:(ViewAction *)action
{
    if (action == nil)
    {
        return nil;
    }
    
    NSAssert([action isKindOfClass:[ViewAction class]], @"Must be of ViewAction class");

    NSMutableArray *actionNames = [NSMutableArray new];

    __block int selectedIndex = 0;
    [action.filterActions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NavAction *subAction = obj;
        [actionNames addObject:subAction.name];

        if (subAction == self.navAction)
        {
            selectedIndex = idx;
        }
    }];

    GGSegmentedControl *segmentedControl = nil;

    if (actionNames.count > 1)
    {
        segmentedControl = [[GGSegmentedControl alloc]initWithItems:actionNames];
        segmentedControl.selectedSegmentIndex = selectedIndex;
        segmentedControl.frame = CGRectOffset(segmentedControl.frame, 0, -2);
        [segmentedControl addTarget:self action:@selector(selectedSegmentChanged:) forControlEvents:UIControlEventValueChanged];
        [segmentedControl layoutSubviews];

        //segmentedControl.accessibilityLabel = @"Generic Segment";
        NSArray *subViews = [segmentedControl subviews];
        NSLog(@"SegmentController subViews = %@", [subViews description]);
        for (int i=0; i<[segmentedControl numberOfSegments]; i++) {
            NSString *title = [segmentedControl titleForSegmentAtIndex:i];
            if ([title isEqualToString:@"Rows"]) {
                ((UIImageView *)[[segmentedControl subviews] objectAtIndex:2]).accessibilityLabel = @"Subscriptions RowsBtn";
                
                //segmentedControl.accessibilityLabel = @"Subscriptions RowsBtn";
            }
            else if ([title isEqualToString:@"Shows"]) {
                ((UIImageView *)[[segmentedControl subviews] objectAtIndex:1]).accessibilityLabel = @"Subscriptions ShowsBtn";
                
                //segmentedControl.accessibilityLabel = @"Subscriptions ShowsBtn";
            }
            else if ([title isEqualToString:@"Channels"]) {
                ((UIImageView *)[[segmentedControl subviews] objectAtIndex:0]).accessibilityLabel = @"Subscriptions ChannelsBtn";
                
                //segmentedControl.accessibilityLabel = @"Subscriptions ChannelsBtn";
            }
        }
    }

    // Due to a vertical offset of the layout of the segmentedControl we have to wrap the
    // segmented control in another view to center it vertically
    UIView *containerView = nil;
    
    if (segmentedControl)
    {
        containerView = [[UIView alloc]initWithFrame:segmentedControl.bounds];
        [containerView addSubview:segmentedControl];
    }
    
    return containerView;
}

- (void)createFilterSegmentedControl
{
    UIView *segmentedControl = [self createSegmentedControllerForAction:(ViewAction *) self.navAction.parentAction];
    if (segmentedControl)
    {
        self.navigationItem.titleView = segmentedControl;
    }
}

- (void)selectedSegmentChanged:(UISegmentedControl*)sender
{
    ViewAction *viewAction = (ViewAction *) self.navAction.parentAction;
    FilterAction *navActionToNavigateTo = [viewAction.filterActions objectAtIndex:(NSUInteger) sender.selectedSegmentIndex];
    [NavActionExecutor executeNavAction:navActionToNavigateTo fromViewController:self];
}

- (void)createNavButton
{
    if (self.navButtonText)
    {
        self.navigationItem.leftBarButtonItem = [[GGBarButtonItem alloc] initWithTitle:self.navButtonText
                                                                                                   image:[UIImage imageNamed:@"DownChevrons.png"]
                                                                                                  target:self
                                                                                                  action:@selector(showNavigationTable:)];
        
        NSLog(@"self.navButtonText:%@",self.navButtonText);
        if ([self.navButtonText isEqualToString:@"Animation & Games"]) {
            self.navigationItem.leftBarButtonItem.accessibilityLabel = @"SubCategory";
        }
        else if ([self.navButtonText isEqualToString:@"Favorite Videos"])
        {
            self.navigationItem.leftBarButtonItem.accessibilityLabel = @"FavoriteVideosBtn";
            
        }
        else if ([self.navButtonText isEqualToString:@"My Channels"])
        {
            self.navigationItem.leftBarButtonItem.accessibilityLabel = @"MyChannelsBtn";
            
        }
//        else if ([self.navButtonText isEqualToString:@"Subscriptions"]) {
//            self.navigationItem.leftBarButtonItem.accessibilityLabel = @"SubscriptionsBtn";
//        }
        else
            self.navigationItem.leftBarButtonItem.accessibilityLabel = @"Channels";
    }
}

- (void)dismissPopover
{
    if (_navigationPopover.popoverVisible == YES)
    {
        [_navigationPopover dismissPopoverAnimated:YES];
        _navigationPopover = nil;
    }
}

- (void)showNavigationTable:(UIBarButtonItem *)sender
{
    if (_navigationPopover.isPopoverVisible)
    {
        [self dismissPopover];
    }
    else
    {
        
        // TODO: EXTRACT THIS CLUTTER HERE
        NSMutableArray *viewActionStackToPush = [NSMutableArray new];
        NavAction *traversedAction = self.navAction.parentAction;
        do
        {
            [viewActionStackToPush addObject:traversedAction];
            traversedAction = traversedAction.parentAction;
        } while (traversedAction);
        
        __block UINavigationController *nav = nil;
        [viewActionStackToPush enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            CategoryAction * categoryAction = obj;
            
            if ([categoryAction isKindOfClass:[CategoryAction class]] && categoryAction.category.categoryLevel < ContentCategoryLevelSub)
            {
                NavigationTableViewController *navigationTableViewController = [[NavigationTableViewController alloc] initWithMainViewController:self];
                if (nav == nil)
                {
                    nav = [[UINavigationController alloc]initWithRootViewController:navigationTableViewController];
                }
                else
                {
                    [nav pushViewController:navigationTableViewController animated:NO];
                }
                
                navigationTableViewController.navAction = categoryAction;
                
                // TEMP HACK TO GET LOGIN BUTTON INTO APP BEFORE TESTFLIGHT
                if (idx == viewActionStackToPush.count - 1)
                {
                    navigationTableViewController.navigationItem.rightBarButtonItem = [[GGBarButtonItem alloc]initWithTitle:NSLocalizedString(@"LogOutLKey", @"")
                                                                                                                      image:nil
                                                                                                                     target:self
                                                                                                                     action:@selector(logout)];
                }
            }
        }];

        

        _navigationPopover = [[UIPopoverController alloc]
                            initWithContentViewController:nav];
        _navigationPopover.popoverBackgroundViewClass = [GGPopoverBackgroundView class];


        // There is no easy way to dismiss a popover from within one of its
        // child controllers so a notification has to be sent out instead
        [[NSNotificationCenter defaultCenter] addObserverForName:kNavigationPopoverDismiss
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification *note)
        {
            [_navigationPopover dismissPopoverAnimated:YES];
        }];

        [_navigationPopover presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem
                                 permittedArrowDirections:UIPopoverArrowDirectionUp
                                                 animated:YES];
    }
}

// TODO MOVE THIS FROM HERE!!!
- (void)logout
{
//    [NavActionExecutor navigateToLogin]
    // Have the logout operation happen on
    // main queue regardless of where logout was called from
    [[NSOperationQueue mainQueue]addOperationWithBlock:^
    {
        [[VimondStore sessionManager] logout:^(BOOL success, NSString *message)
        {
            if (success)
            {
                [self showLoginScreen];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not log out"
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }];
}

- (void)showLoginScreen
{
    [[NSOperationQueue mainQueue]addOperationWithBlock:^
    {
        [NavActionExecutor executeNavAction:[LogoutAction new] fromViewController:self];
    }];
}

- (void)showLoginScreenImmediately
{
    [[NSOperationQueue mainQueue]addOperationWithBlock:^
     {
         AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
         [delegate showLoginWindow];
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have been logged out"
                                                         message:@""
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}

- (void)createSearchBar
{
    UISearchBar *searchBar  = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kSearchBarWidth, 40)];
    searchBar.placeholder   = NSLocalizedString(@"SearchChannelsLKey", @"");

    searchBar.accessibilityLabel= @"searchbar";
    
    
    //    Rajeev Start
	UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
	tempButton.frame =CGRectMake(0.0, 0.0, 1.0, 1.0);
	tempButton.accessibilityLabel = @"tempButton";
	tempButton.isAccessibilityElement = YES;
	[searchBar addSubview:tempButton];
    //    Rajeev End
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.rightBarButtonItem = barButtonItem;

    self.customSearchDisplayController = [[GGSearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];

    searchBar.delegate = self.customSearchDisplayController;
    
    //    Rajeev Start
	[tempButton addTarget:self.customSearchDisplayController action:@selector(tempButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    Rajeev End
    
    self.customSearchDisplayController.delegate = self.customSearchDisplayController;
}

- (NSString *)navButtonText
{
    return self.navAction.parentAction.name;
}

- (NSString *)generateTrackingPath
{
    NSString *trackingPath = @"";

    NavAction *traversedAction = self.navAction;
    while (traversedAction)
    {
        NSString * underScoredActionName = [traversedAction.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        trackingPath = [NSString stringWithFormat:@"/%@%@",underScoredActionName,trackingPath];
        traversedAction = traversedAction.parentAction;
    }

    return trackingPath;
}

@end
