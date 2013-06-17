//
//  KIFTestScenario+EXAdditions.h
//  Testable
//
//  Created by Eric Firestone on 6/12/11.
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.

#import <Foundation/Foundation.h>
#import "KIFTestScenario.h"

@interface KIFTestScenario (EXAdditions)


+ (id)scenarioToSelectDifferentChannels;
+ (id)scenarioToSelectDifferentChannelsback;

#pragma mark Common Method
+ (id)scenarioToClearTextField;
+ (id)scenarioToLogout;


#pragma mark TestCases
+ (id) scenarioFromEndToEnd;
+ (id)Signing_Out_of_the_Xidio_application;
+ (id)scenarioToValidCredential;
+ (id)scenarioToInValidUserName;
+ (id)scenarioToInValidPassword;
+ (id)scenarioToMessageDisplayUnderFavorites;
+ (id)scenarioToCheckFavoritesOptionFeature;
+ (id)scenarioToCheckUn_FavoritesOptionFeature;
+ (id)scenarioToCheckSearchChannelStoreFeature;
+ (id)scenarioToCheckInvalidSearchChannelStoreFeature;
+ (id)scenarioToDisplayPublisherLink;
+ (id)scenarioToDisplayMyChannels;
+ (id)scenarioToDisplayCategoryAndSubCategory;
+ (id)scenarioToDisplayCategoryAndSubCategoryfromUI;
+ (id)scenarioToDisplaySortedByAToZLink;
+ (id)scenarioToDisplayVideoPlaying;
+ (id)scenarioToDisplayVideoPlayingfromMyChannels;
+ (id)scenarioToPlayPauseButton;
+ (id)scenarioToDisplayVideoPlayingAreaWithFullScreen;
+ (id)scenarioToDisplaySoundIncrese;
+ (id)scenarioToCheckBlankSearchChannelStore;
+ (id)scenarioToDisplayResumingVideo;
+ (id)scenarioToDisplayFullWorkFlow;
+ (id)scenarioToOrientation;


@end
