//
//  Created by Andreas Petrov on 10/31/12.
//  Copyright (c) 2012 Reaktor Magma. All rights reserved.
//


#import "FeaturedContentNavigator.h"
#import "FeaturedContent.h"
#import "GGBaseViewController.h"
#import "VideoPlaybackViewController.h"
#import "CategoryStore.h"
#import "VimondStore.h"
#import "ContentCategory.h"
#import "CategoryNavigator.h"
#import "ChannelModalViewController.h"


@implementation FeaturedContentNavigator
{

}
+ (void)navigateToFeaturedContent:(FeaturedContent *)featuredContent
               fromViewController:(GGBaseViewController *)viewController
                completionHandler:(VoidHandler)onComplete
{
    [viewController runOnBackgroundThread:^
    {
        switch (featuredContent.contentType)
        {
            case FeaturedContentTypeCategory:
                [self handleFeaturedCategory:featuredContent withViewController:viewController];
                break;
            case FeaturedContentTypeChannel:
                [self handleFeaturedChannel:featuredContent withViewController:viewController];
                break;
            case FeaturedContentTypeAsset:
                [self handleFeaturedAsset:featuredContent withViewController:viewController];
                break;
            default:
                break;
        }

        [[NSOperationQueue mainQueue] addOperationWithBlock:^
        {
            if (onComplete)
            {
                onComplete();
            }
        }];
    }];
}

+ (void)handleFeaturedAsset:(FeaturedContent *)featuredContent
         withViewController:(GGBaseViewController *)viewController
{
    Video *featuredVideo = featuredContent.video ? : [[VimondStore videoStore] videoWithId:featuredContent.contentKey error:nil];
    if (featuredVideo)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
        {
            [VideoPlaybackViewController presentVideo:featuredVideo fromChannel:nil withNavigationController:viewController.navigationController];
        }];
    }
}

+ (void)handleFeaturedCategory:(FeaturedContent *)featuredContent withViewController:(GGBaseViewController *)viewController
{
    // TODO: Clean up this method.  It's a royal mess
    ContentCategory *category = featuredContent.category ? : [[VimondStore categoryStore] categoryWithId:featuredContent.contentKey error:nil];
    if (category)
    {
        if (category.categoryLevel <= ContentCategoryLevelSub)
        {
            [CategoryNavigator navigateToCategoryWithId:category.identifier fromViewController:viewController completionHandler:nil];
        }
        else if (category.categoryLevel == ContentCategoryLevelChannel)
        {
            Channel *channel = [[VimondStore channelStore] channelWithId:category.identifier error:nil];
            if (channel)
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                {
                    [ChannelModalViewController showFromView:nil withChannel:channel navController:viewController.navigationController];
                }];
            }
        }
    }
}

+ (void)handleFeaturedChannel:(FeaturedContent *)featuredContent withViewController:(GGBaseViewController *)viewController
{

    Channel *channel = featuredContent.channel ? : [[VimondStore channelStore] channelWithId:featuredContent.contentKey error:nil];
    if (channel)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
        {
            [ChannelModalViewController showFromView:nil withChannel:channel navController:viewController.navigationController];
        }];
    }
}

@end