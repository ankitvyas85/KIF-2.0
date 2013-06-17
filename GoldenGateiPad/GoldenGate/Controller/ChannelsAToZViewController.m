//
//  ChannelsAToZViewController.m
//  GoldenGate
//
//  Created by Andreas Petrov on 9/23/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import "ChannelsAToZViewController.h"
#import "ChannelSummaryCell.h"
#import "MyChannelsDataFetcher.h"
#import "Channel.h"
#import "PrefetchingDataSource.h"
#import "CategoryAction.h"
#import "MyChannelsAction.h"
#import "ChannelsForCategoryDataFetcher.h"
#import "VideoCache.h"

#define kMaxVidsPrChannel 5
#define kNumberOfRowsPrPage 4

@interface ChannelsAToZViewController ()

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) PrefetchingDataSource *prefetchingDataSource;
@property(weak, nonatomic) IBOutlet LoadingView *loadingView;
@property(weak, nonatomic) IBOutlet UIView *contentView;
@property(weak, nonatomic) IBOutlet UILabel *tableHeaderLabel;

@property(strong, nonatomic) ChannelSummaryCell *prototypeCell;

@property(weak, nonatomic) ContentCategory *category;
@property(strong, nonatomic) VideoCache *videoCache;

@property (strong, nonatomic) NSMutableDictionary *alternateColorDict;

@end

static NSString *cellID;

@implementation ChannelsAToZViewController

+ (void)initialize
{
    if (cellID == nil)
    {
        cellID = NSStringFromClass([ChannelSummaryCell class]);
    }
}

- (id)initWithNavAction:(NavAction *)navAction
{
    if ((self = [super initWithNavAction:navAction]))
    {
        NavAction *parentNavAction = navAction.parentAction;
        if ([parentNavAction isKindOfClass:[CategoryAction class]])
        {
            CategoryAction *categoryAction = (CategoryAction *) parentNavAction;
            self.category = categoryAction.category;
        }
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    
    [self setupTableView];
    [self loadData];
    [self updateHeaderLabel];
    
    self.tableView.accessibilityLabel= @"A-ZTbl";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [self.videoCache clearCache];
}

#pragma mark - Private methods

- (void)setupTableView
{
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)loadData
{
    self.alternateColorDict = [NSMutableDictionary new];
    self.contentView.hidden = YES;
    [self.loadingView startLoadingWithText:NSLocalizedString(@"LoadingContentLKey", @"")];
    self.prefetchingDataSource = [self createPrefetchingDataSource];
    [self.prefetchingDataSource updateTotalObjectCount:^
    {
        if (self.prefetchingDataSource.cachedTotalItemCount > 0)
        {
            [self.loadingView endLoading];
            self.contentView.hidden = NO;
            [self.tableView reloadData];
        }
        else
        {
            [self.loadingView showMessage: [self noContentString]];
        }
    }
    errorHandler:^(NSError *error)
    {
        [self.loadingView showRetryWithMessage:NSLocalizedString(@"ErrorLoadingContentLKey", @"")];
    }];
}

- (NSString*)noContentString
{
    return self.category ? NSLocalizedString(@"CategoryHasNoChannelsLKey", @"") : NSLocalizedString(@"UserHasNoChannelsLKey", @"");
}

- (id<DataFetching>)dataFetcherForNavAction:(NavAction*)navAction
{
    id<DataFetching> dataFetcher = nil;
    if ([navAction.parentAction isKindOfClass:[CategoryAction class]])
    {
        ChannelsForCategoryDataFetcher *channelsForCategoryDataFetcher = [ChannelsForCategoryDataFetcher new];
        channelsForCategoryDataFetcher.sourceObject = self.category;
        dataFetcher = channelsForCategoryDataFetcher;
    }
    else if ([navAction.parentAction isKindOfClass:[MyChannelsAction class]])
    {
        dataFetcher = [MyChannelsDataFetcher new];
    }
    
    NSAssert(dataFetcher != nil, @"Should have a datafetcher by now.");
    
    return dataFetcher;
}

- (PrefetchingDataSource *)createPrefetchingDataSource
{
    PrefetchingDataSource *dataSource = [PrefetchingDataSource createWithDataFetcher:[self dataFetcherForNavAction:self.navAction]];
    dataSource.sortBy = ProgramSortByCategoryNameAsc;
    dataSource.objectsPrPage = kNumberOfRowsPrPage;
    return dataSource;
}

- (void)updateHeaderLabel
{
    NSString *labelText = NSLocalizedString(@"MyChannelsLKey", @"");
    if (self.category)
    {
        labelText = [NSString stringWithFormat:NSLocalizedString(@"AllOfCategoryLKey", @""), self.navAction.parentAction.name];
    }
    
    self.tableHeaderLabel.text = labelText;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.prototypeCell.bounds.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.prefetchingDataSource.cachedTotalItemCount;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.navController = self.navigationController;
    cell.videoCache = self.videoCache;
    [cell hideAllVideoCells];

    [self.prefetchingDataSource fetchDataObjectAtIndex:indexPath.row
                                        successHandler:^(NSObject *dataObject)
    {
        cell.channel = (Channel*)dataObject;        
    } errorHandler:nil];

    return cell;
}

#pragma mark - LoadingViewDelegate

- (void)retryButtonWasPressedInLoadingView:(LoadingView *)loadingView
{
    [self loadData];
}

#pragma mark - Properties

- (ChannelSummaryCell *)prototypeCell
{
    if (_prototypeCell == nil)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    }

    return _prototypeCell;
}

- (VideoCache *)videoCache
{
    if (_videoCache == nil)
    {
        _videoCache = [[VideoCache alloc] initWithVideosPrChannel:kMaxVidsPrChannel sortBy:ProgramSortByPublishedDateDesc];
    }

    return _videoCache;
}

@end
