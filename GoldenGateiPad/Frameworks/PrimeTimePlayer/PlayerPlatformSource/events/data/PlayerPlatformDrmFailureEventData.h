//
//  PlayerPlatformDrmFailureEventData.h
// PlayerPlatform
//
//  Created by Cory Zachman on 12/27/12.
//
//  Copyright 2013, Comcast Corporation. This software and its contents are
//  Comcast confidential and proprietary. It cannot be used, disclosed, or
//  distributed without Comcast's prior written permission. Modification of this
//  software is only allowed at the direction of Comcast Corporation. All allowed
//  modifications must be provided to Comcast Corporation.

#import <Foundation/Foundation.h>
#import "PlayerPlatformVideoEventData.h"
@interface PlayerPlatformDrmFailureEventData : PlayerPlatformVideoEventData
@property NSNumber* major;
@property NSNumber* minor;
@property NSError* error;

extern NSString* const KEY_FOR_MAJOR;
extern NSString* const KEY_FOR_MINOR;
extern NSString* const KEY_FOR_ERROR;

@end
