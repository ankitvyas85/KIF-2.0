//
//  ShowStore.m
//  GoldenGate
//
//  Created by Satish Basavaraj on 24/05/13.
//  Copyright (c) 2013 Knowit. All rights reserved.
//

#import "ShowStore.h"
#import "SearchResult.h"
#import "ContentCategory.h"
#import "SearchClient.h"
#import "RestPlatform.h"
#import "RestSearchCategoryList.h"
#import "RestSearchCategory.h"
#import "Show.h"
#import "VimondStore.h"
#import "TreeNodeCache.h"

@interface ShowStore()
{
RestPlatform *_platform;
SearchClient *_searchClient;
}

@property (strong) TreeNodeCache *showsCache;
@end


@implementation ShowStore


- (id)initWithBaseURL:(NSString *)baseURL platformName:(NSString *)platformName
{
    if (self = [super init])
    {
        _platform = [RestPlatform platformWithName:platformName];
        _searchClient = [[SearchClient alloc] initWithBaseURL:baseURL];
        _showsCache = [TreeNodeCache new];
        _showsCache.overrideOldNodes = YES;
    }
    
    return self;
}

- (void)clearCache
{
    [_showsCache clearCache];
}

- (void)storeShowInCache:(Show *)show
{
    [self.showsCache storeNode:show withKey:@(show.identifier)];
}

- (void)invalidateCacheForShow:(Show *)show
{
    [self.showsCache deleteNodeWithKey:@(show.identifier)];
}


- (SearchResult *)showsForCategory:(ContentCategory *)category
                            pageIndex:(NSUInteger)pageIndex
                             pageSize:(NSUInteger)pageSize
                               sortBy:(ProgramSortBy)sortBy
                                error:(NSError **)error
{
    NSString *categoryId = [NSString stringWithFormat:@"%d", category.identifier];
    RestProgramSortBy *sort = sortBy != ProgramSortByDefault ? [[RestProgramSortBy alloc] initWithEnum:sortBy] : nil;
    NSNumber *start = [NSNumber numberWithUnsignedInteger:pageIndex];
    NSNumber *size = [NSNumber numberWithUnsignedInteger:pageSize];
    
    SearchResult *showsResult = [self showsForCategory:categoryId query:nil sort:sort start:start size:size text:nil error:error];
    return showsResult;
}

- (SearchResult *)showsForCategory:(NSString *)categoryId
                                query:(NSString *)query
                                 sort:(RestProgramSortBy *)sort
                                start:(NSNumber *)start
                                 size:(NSNumber *)size
                                 text:(NSString *)text
                                error:(NSError **)error
{
    RestSearchCategoryList *searchCategoryList = [_searchClient getCategoriesForPlatform:_platform
                                                                             subCategory:categoryId
                                                                                   query:query
                                                                                    sort:sort
                                                                                   start:start
                                                                                    size:size
                                                                                    text:text
                                                                                   error:error];
    NSMutableArray *shows = [NSMutableArray array];
    for (RestSearchCategory *searchCategory in searchCategoryList.categories)
    {
        [shows addObject:[searchCategory showsObject]];
    }
    
    SearchResult *searchResult = [[SearchResult alloc] init];
    searchResult.totalCount = [searchCategoryList.numberOfHits unsignedIntegerValue];
    searchResult.items = shows;
    
    for (Show *show in shows)
    {
        [self storeShowInCache:show];
    }
    
    return searchResult;
}



- (Show *)showWithId:(NSUInteger)showId error:(NSError **)error
{
    Show *foundShow = [self.showsCache nodeWithKey:@(showId)];
    
    if (foundShow == nil)
    {
        NSString *query = [NSString stringWithFormat:@"categoryId:%d", showId];
        NSString *categoryId = [[[VimondStore categoryStore] rootCategoryID:error] stringValue];
        SearchResult *result = [self showsForCategory:categoryId query:query sort:nil start:@0 size:@1 text:nil error:error];
        if (result.totalCount > 0)
        {
            foundShow = [result.items objectAtIndex:0];
        }
    }
    
    return foundShow;
}


- (NSUInteger)numberOfEpisodesInShow:(Show *)show error:(NSError **)error
{
    NSString *categoryId = [NSString stringWithFormat:@"%d", show.identifier];
    SearchResult *result = [self showsForCategory:categoryId query:nil sort:nil start:@0 size:@0 text:nil error:error];
    return result.totalCount;
}



@end
