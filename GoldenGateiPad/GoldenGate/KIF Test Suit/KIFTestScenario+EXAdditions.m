//
//  KIFTestScenario+EXAdditions.m
//  Testable
//
//  Created by Eric Firestone on 6/12/11.
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.

#import "KIFTestScenario+EXAdditions.h"
#import "KIFTestStep.h"
#import "KIFTestStep+EXAdditions.h"


#if TARGET_IPHONE_SIMULATOR
NSString * const DeviceMode = @"Simulator";
#else
NSString * const DeviceMode = @"Device";
#endif

#define kUserName @"test_151"
#define kPassword @"Demo1111"

@implementation KIFTestScenario (EXAdditions)

/* ------------------------------ Test Cases ------------------------------ */

#pragma mark Common Function


+ (id)scenarioToClearTextField
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to clear field"];
       //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:@"" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"" intoViewWithAccessibilityLabel:@"password"]];
        
     return scenario;
}
+ (id)scenarioToLogout
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to Logout"];
    
//    Channel Click & logOut
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Logout"]];

    
    return scenario;
}
#pragma mark -
#pragma mark Signing Out of the Xidio application.

+ (id)Signing_Out_of_the_Xidio_application
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a user can successfully log Out."];
//    Login 
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
//    Channel Click & logOut
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];    
     [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Logout"]];
    
    return scenario;
}
#pragma mark -

#pragma mark Logging into the Xidio application using valid credentials.

+ (id)scenarioToValidCredential
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test Valid Credential"];
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    return scenario;
}
#pragma mark -

#pragma mark Logging into the Xidio application using invalid username

+ (id)scenarioToInValidUserName
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that InValid UserName."];
    [scenario addStep:[KIFTestStep stepToEnterText:@"test_151234" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];

     [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:2.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToDismissAlertWithLabel:@"OK"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    return scenario;
}
#pragma mark -


#pragma mark Complete Scenario from End to End
+ (id) scenarioFromEndToEnd
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test Valid Credential"];
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    //    Tap on Favorite Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"favoriteButton"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
    
    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"editButton"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"deleteButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    //    searchBarButton
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Life" intoViewWithAccessibilityLabel:@"searchbar"]];
    
	// Rajeev Start
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"tempButton" traits:UIAccessibilityTraitButton]];
	// Rajeev End
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"RelatedContent"]];
    //    SegmentZeros
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SegmentZeros"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"A-Z" traits:UIAccessibilityTraitButton]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    [scenario addStep:[KIFTestStep stepToScrollViewWithAccessibilityLabel:@"A-ZTbl" byFractionOfSizeHorizontal:-0.5 vertical:0.0]];
    
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    return scenario;
}

#pragma mark Logging into the Xidio application using invalid password

+ (id)scenarioToInValidPassword
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that Invalid Password."];
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Demo1111236" intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:2.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToDismissAlertWithLabel:@"OK"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
    return scenario;
}
#pragma mark -

#pragma mark Verify "You haven't favorited…" message is displayed under FAVORITES.
+ (id)scenarioToMessageDisplayUnderFavorites
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:@"test_151" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Demo1111" intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    //[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubscriptionsCell"]];
    //[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FavoriteVideosBtn"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
     return scenario;

}
#pragma mark -
#pragma mark Check Favorites Option feature.
+ (id)scenarioToCheckFavoritesOptionFeature
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:@"test_151" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Demo1111" intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]]; 
    
//    Tap on Feature Cell 
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

//    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
//    Tap on Favorite Button
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"favoriteButton"]];
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];

    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:3.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
//    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    //[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:3.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubscriptionsCell"]];
//    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:4.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
//    //    Channel Click
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Subscriptions ChannelsBtn"]];
    
    return scenario;
}
#pragma mark -
#pragma mark Check Un-Favorites Option feature.
+ (id)scenarioToCheckUn_FavoritesOptionFeature
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:@"test_151" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Demo1111" intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    //[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:3.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubscriptionsCell"]];
    //
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Subscriptions RowsBtn"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:4.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Subscriptions ShowsBtn"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:4.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Subscriptions ChannelsBtn"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:4.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
//    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
//    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"editButton"]];
//
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"deleteButton"]];
//    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    return scenario;

    
}
#pragma mark-

#pragma mark Ensuring Search Channel Store is working fine.

+ (id)scenarioToCheckBlankSearchChannelStore
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    searchBarButton
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"" intoViewWithAccessibilityLabel:@"searchbar"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    return scenario;
    
}

+ (id)scenarioToCheckSearchChannelStoreFeature
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    searchBarButton
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Life" intoViewWithAccessibilityLabel:@"searchbar"]];
    
	// Rajeev Start
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"tempButton" traits:UIAccessibilityTraitButton]];
	// Rajeev End
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    
    
    
    return scenario;
}


+ (id)scenarioToCheckInvalidSearchChannelStoreFeature
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    searchBarButton
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Valtech" intoViewWithAccessibilityLabel:@"searchbar"]];
    
	// Rajeev Start
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"tempButton" traits:UIAccessibilityTraitButton]];
	// Rajeev End
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    
    
    
    return scenario;

}


#pragma mark-

#pragma mark Verify Publisher link displays all the video's published by them.

+ (id)scenarioToDisplayPublisherLink
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"RelatedContent"]];
//    SegmentZeros
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SegmentZeros"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];


    return scenario;
}

#pragma mark-

#pragma mark Verify subscribed, most recent viewed, favorites and notewothy video's are displayed.
+ (id)scenarioToDisplayMyChannels
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    //[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:3.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubscriptionsCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:4.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubscriptionsBtn"]];
    
//    //    Channel Click
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
//    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"My Channels"]];
//    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
//
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"MyChannelsBtn"]];
    return scenario;
}

#pragma mark-

#pragma mark Verify selected category and sub-category video's are displayed.
+ (id)scenarioToDisplayCategoryAndSubCategory
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Animation & Games"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubCategory"]];
     [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"2D"]];
     [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
     

    return scenario;
}

#pragma mark-

#pragma mark Verify selected category  video's are displayed on the page.


+ (id)scenarioToDisplayCategoryAndSubCategoryfromUI
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"subCategoryTblView" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    return scenario;
}
#pragma mark-

#pragma mark Verify Sort by- A-Z link and Sorted order.

+ (id)scenarioToDisplaySortedByAToZLink
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"A-Z" traits:UIAccessibilityTraitNone]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
//    [scenario addStep:[KIFTestStep stepToScrollViewWithAccessibilityLabel:@"A-ZTbl" byFractionOfSizeHorizontal:-0.5 vertical:0.0]];
    
     [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    


     return scenario;
}
#pragma mark-
#pragma mark Verify selected video's are playing.

+ (id)scenarioToDisplayVideoPlaying
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    //    Tap on Favorite Button
    //    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"favoriteButton"]];
    //    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:3.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
//    //    Tap on videoTableCell
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
//    
////    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:20.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
////    
////        
////    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"ResumeBtn"]];
//    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:20.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
//    
//    if (!TARGET_IPHONE_SIMULATOR) {
//        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
//    }
//    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
//    
//    //    Tap on Close Button
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
//    
//    [scenario addStep:[KIFTestStep stepToDismissPopover]];


    return scenario;
}


#pragma mark-

#pragma mark Verify video's are displayed from My Channels list.

+(id)scenarioToDisplayVideoPlayingfromMyChannels
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:20.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

//    ResumeBtn    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"ResumeBtn"]];
 
    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Subscriptions Tray"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];

    
     return scenario;

}

#pragma mark-

#pragma mark  Check Pause button works fine.

+ (id)scenarioToPlayPauseButton
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:@"test_151" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Demo1111" intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:15.0 description:@"An arbitrary wait "]];
    
    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
//    Pause the Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

//    Play the Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton" traits:UIAccessibilityTraitButton]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
//    pause Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton" traits:UIAccessibilityTraitButton]];

    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    
    return scenario;

    
}
#pragma mark-

#pragma mark  Verify all the icons are displaying in video plays area.

+ (id)scenarioToDisplayVideoPlayingAreaWithFullScreen
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
//    
//      [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"ResumeBtn"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:15.0 description:@"An arbitrary wait "]];
    
    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
        //[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Watching Next Tray"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    //}
    //    pause Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton" traits:UIAccessibilityTraitButton]];
    
    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    
    return scenario;
    
    
}
#pragma mark-
#pragma mark Verify sound increases.

+ (id)scenarioToDisplaySoundIncrese
{

    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait "]];
    
    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }
//    volumeSlider
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"volumeSlider"]];


    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait "]];
    
    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];

   
    return scenario;
}
#pragma mark-

#pragma mark Resuming video in the same user session in iPad.
+ (id)scenarioToDisplayResumingVideo
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a Message Display Under Favorites"];
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Feature Cell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell2"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:20.0 description:@"An arbitrary wait "]];

    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }
    //    Pause the Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    //    searchBarButton
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"African Cats" intoViewWithAccessibilityLabel:@"searchbar"]];
    
	// Rajeev Start
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"tempButton" traits:UIAccessibilityTraitButton]];
	// Rajeev End
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];


    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchVedioCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell, Below commented becouse video not exist currently.
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
//    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:20.0 description:@"An arbitrary wait "]];
//
//    if (!TARGET_IPHONE_SIMULATOR) {
//        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
//    }
//    //    Tap on Close Button
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    return scenario;
}

#pragma mark-

#pragma mark Display Full WorkFlow
+ (id)scenarioToDisplayFullWorkFlow
{
    
  //  KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test Full Work Flow"];
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test Valid Credential"];
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

// Favoraite Message
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];


    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
//    Favoraite Add 
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"favoriteButton"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
//   Unfavorite
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Videos"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"editButton"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"deleteButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

//    Valid Search
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Life" intoViewWithAccessibilityLabel:@"searchbar"]];
    

	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"tempButton" traits:UIAccessibilityTraitButton]];

    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    
//Invalid Search
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"searchbar"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"Valtech" intoViewWithAccessibilityLabel:@"searchbar"]];

	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"tempButton" traits:UIAccessibilityTraitButton]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    
//    Publisher Link
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"RelatedContent"]];
    //    SegmentZeros
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SegmentZeros"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
// My Channel List
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
//    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"My Channels"]];
//    
//    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
//    
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
//
// Category & Sub Category From Table
   
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Animation & Games"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"SubCategory"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"2D"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Animation & Games"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
//    Category & Sub category From UI
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"subCategoryTblView" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];

//    Sorted A-Z Link
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"A-Z" traits:UIAccessibilityTraitButton]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    [scenario addStep:[KIFTestStep stepToSwipeViewWithAccessibilityLabel:@"A-ZTbl" inDirection:KIFSwipeDirectionUp]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:5.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Featured" traits:UIAccessibilityTraitButton]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
//    Video Activity
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"FeaturedContentCell"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Tap on videoTableCell
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"videoTableCell"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:15.0 description:@"An arbitrary wait "]];
    
    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }
//    Pause the Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
//    Play the Video
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"PauseButton" traits:UIAccessibilityTraitButton]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }

//    volumeSlider
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"volumeSlider"]];
    
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait "]];


    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }

    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"myChannelsTray"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    if (!TARGET_IPHONE_SIMULATOR) {
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"playerLayerView"]];
    }
    
    //    Tap on Close Button
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"closeVideoPlay"]];
    
    [scenario addStep:[KIFTestStep stepToDismissPopover]];
    


    
    return scenario;
}

#pragma mark-

#pragma mark
+ (id)scenarioToOrientation
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test Orientation"];
    
    //    Login
    [scenario addStep:[KIFTestStep stepToEnterText:kUserName intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToEnterText:kPassword intoViewWithAccessibilityLabel:@"password"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"signInButton"]];
    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];
    
    //    Channel Click
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Animation & Games"]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:10.0 description:@"An arbitrary wait just to demonstrate adding an additional step"]];

    
    // Orientation Check
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"orientLeft"] isEqualToString:@"Yes"]){
        [scenario addStep:[KIFTestStep stepToInterfaceOrientation:UIDeviceOrientationLandscapeRight]];
        [[NSUserDefaults standardUserDefaults] setValue:@"No" forKey:@"orientLeft"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else  if (![[NSUserDefaults standardUserDefaults] valueForKey:@"orientLeft"] ||[[[NSUserDefaults standardUserDefaults] valueForKey:@"orientLeft"] isEqualToString:@"No"]){
        [scenario addStep:[KIFTestStep stepToInterfaceOrientation:UIDeviceOrientationLandscapeLeft]];
        [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:@"orientLeft"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Channels"]];
   return scenario;
}


#pragma mark-

@end
