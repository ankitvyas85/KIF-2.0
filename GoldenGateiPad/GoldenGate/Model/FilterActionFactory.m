//
//  Created by Andreas Petrov on 10/24/12.
//  Copyright (c) 2012 Reaktor Magma. All rights reserved.
//


#import "FilterActionFactory.h"
#import "ContentCategory.h"
#import "FilterAction.h"
#import "MainCategoryViewController.h"
#import "SubCategoryViewController.h"
#import "NewInCategoryViewController.h"
#import "ViewAction.h"
#import "ChannelsAToZViewController.h"
#import "NewVideosForUserViewController.h"
#import "PopularInCategoryViewController.h"
#import "FavoritesViewController.h"
#import "CategoryAction.h"
#import "MyChannelsAction.h"
#import "FavoritesAction.h"
#import "RowsSubscriptionViewController.h"
#import "ChannelsSubscriptionViewController.h"
#import "ShowsSubscriptionsViewController.h"

@implementation FilterActionFactory
{

}

+ (NSArray *)createFilterActionsForViewAction:(ViewAction*)viewAction
{
    if ([viewAction isKindOfClass:[CategoryAction class]])
    {
        CategoryAction* action = (CategoryAction*)viewAction;
        return [FilterActionFactory createFilterActionsForCategory:action.category];
    }
    else if ([viewAction isKindOfClass:[MyChannelsAction class]])
    {
        return [FilterActionFactory createFilterActionsForMyChannels];
    }
    else if ([viewAction isKindOfClass:[FavoritesAction class]])
    {
        return [FilterActionFactory createFilterActionsForFavorites];
    }

    return nil;
}

+ (NSArray*)createFilterActionsForFavorites
{
    FilterAction *favorites   = [[FilterAction alloc] initWithName:NSLocalizedString(@"FavoritesLKey", @"") viewControllerClass:[FavoritesViewController class]];
    favorites.cachable = NO;
    return @[favorites];
}

+ (NSArray *)createFilterActionsForMyChannels
{

    //Satish: Filter actions created for Rows, Shows and Channels
    FilterAction *rowsAction   = [[FilterAction alloc] initWithName:NSLocalizedString(@"RowsLKey", @"")   viewControllerClass:[RowsSubscriptionViewController class]];
    rowsAction.cachable = NO;

    FilterAction *showsAction  = [[FilterAction alloc] initWithName:NSLocalizedString(@"ShowsLKey", @"")    viewControllerClass:[ShowsSubscriptionsViewController class]];
    showsAction.cachable = NO;
    
    FilterAction *channelsAction  = [[FilterAction alloc] initWithName:NSLocalizedString(@"ChannelsLKey", @"")    viewControllerClass:[ChannelsSubscriptionViewController class]];
    channelsAction.cachable = NO;
    
    return @[rowsAction, showsAction, channelsAction];
}

+ (NSArray *)createFilterActionsForCategory:(ContentCategory *)category
{
    Class featuredActionVCClass = category.categoryLevel == ContentCategoryLevelSub ? [SubCategoryViewController class] : [MainCategoryViewController class];
    FilterAction *featuredAction  = [[FilterAction alloc] initWithName:NSLocalizedString(@"FeaturedLKey", @"") viewControllerClass:featuredActionVCClass];
    FilterAction *newAction       = [[FilterAction alloc] initWithName:NSLocalizedString(@"NewLKey", @"") viewControllerClass:[NewInCategoryViewController class]];
    FilterAction *popularAction   = [[FilterAction alloc] initWithName:NSLocalizedString(@"PopularLKey", @"") viewControllerClass:[PopularInCategoryViewController class]];
    FilterAction *aToZAction      = [[FilterAction alloc] initWithName:NSLocalizedString(@"AZLKey", @"") viewControllerClass:[ChannelsAToZViewController class]];

    return @[featuredAction, newAction, popularAction, aToZAction];
}

@end