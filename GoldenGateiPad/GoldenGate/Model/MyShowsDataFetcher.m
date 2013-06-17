//
//  MyShowsDataFetcher.m
//  GoldenGate
//
//  Created by Satish Basavaraj on 24/05/13.
//  Copyright (c) 2013 Knowit. All rights reserved.
//

#import "MyShowsDataFetcher.h"
#import "VimondStore.h"

@implementation MyShowsDataFetcher

- (void)fetchDataForPage:(NSUInteger)pageNumber
           objectsPrPage:(NSUInteger)objectsPrPage
                  sortBy:(ProgramSortBy)sortBy
          successHandler:(PagedObjectsHandler)onSuccess
            errorHandler:(ErrorHandler)onError
{
    NSError *error;
    NSArray *shows = [[VimondStore sharedStore] myShows:&error];
    
    if (!error)
    {
        onSuccess(shows, shows.count);
    }
    else
    {
        onError(error);
    }
}


- (BOOL)doesSupportPaging
{
    return NO;
}

@end
