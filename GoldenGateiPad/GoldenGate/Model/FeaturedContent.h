//
//  FeaturedContentInfo.h
//  GoldenGate
//
//  Created by Andreas Petrov on 8/20/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Entity.h"

@class ContentCategory;
@class Channel;
@class Video;

@interface FeaturedContent : Entity

typedef enum {
  FeaturedContentTypeUnknown,
  FeaturedContentTypeCategory,
  FeaturedContentTypeChannel,
  FeaturedContentTypeAsset,
} FeaturedContentType;

@property (copy, nonatomic) NSString *imagePack;
@property (copy, nonatomic) NSString *imageURL;

@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) FeaturedContentType contentType;
@property (assign, nonatomic) NSUInteger contentKey;

@property (nonatomic) ContentCategory *category;
@property (nonatomic) Channel *channel;
@property (nonatomic) Video *video;

- (void)setContentTypeFromString:(NSString *)contentType;

@end
