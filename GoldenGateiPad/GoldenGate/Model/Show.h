//
//  Shows.h
//  GoldenGate
//
//  Created by Satish Basavaraj on 24/05/13.
//  Copyright (c) 2013 Knowit. All rights reserved.
//

#import "Entity.h"
#import "Constants.h"
#import "SearchResultInfoDelivering.h"

// Model for Shows

@interface Show : Entity<SearchResultInfoDelivering>

@property (copy, nonatomic) NSString *publisher;
@property (copy, nonatomic) NSString *imagePack;
@property (assign, nonatomic) PGRating pgRating;
@property (assign, nonatomic) int likeCount;

- (id)initWithId:(int)identifier;
- (NSString *)logoURLStringForSize:(CGSize)size;

@end
