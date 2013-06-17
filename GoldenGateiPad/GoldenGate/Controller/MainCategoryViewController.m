//
//  MainCategoryViewController.m
//  GoldenGate
//
//  Created by Andreas Petrov on 8/20/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import "MainCategoryViewController.h"
#import "ContentCategory.h"
#import "FeaturedContent.h"
#import "CellView.h"
#import "FeaturedContentCellView.h"
#import "Channel.h"
#import "ChannelCellView.h"
#import "ChannelModalViewController.h"
#import "VimondStore.h"
#import "ContentPanelStore.h"
#import "FeaturedContentNavigator.h"
#import "CategoryAction.h"
#import "KITGridLayoutView.h"
#import "CellViewFactory.h"
#import "PopularChannelsForCategoryDataFetcher.h"
#import "GMGridViewLayoutStrategies.h"
#import "GridCellWrapper.h"

#define kMaxItemsPrRow 6
#define kMaxFeaturedItems 3

@interface MainCategoryViewController ()
{
    //Satish: data fetched added to obtain popular channels
    PopularChannelsForCategoryDataFetcher* _popularChannelsForCategoryFetcher;
}


@property(weak, nonatomic) IBOutlet UIView *featuredContainer;
@property(weak, nonatomic) IBOutlet UIView *contentView;
@property(weak, nonatomic) IBOutlet LoadingView *loadingView;

//Satish: Views and controller for double rowed popular channels
@property(weak, nonatomic) IBOutlet GMGridView* popularView;
@property(strong, nonatomic)GridViewController* popularGridViewController;
@property(weak, nonatomic) IBOutlet LoadingView *popularLoadingView;





@property(strong, nonatomic) NSArray *featuredContent;
@property(strong, nonatomic) NSArray *popularChannels;


@end

@implementation MainCategoryViewController

- (id)initWithNavAction:(NavAction *)navAction
{
    if ((self = [super initWithNavAction:navAction]))
    {
        CategoryAction *categoryAction = (CategoryAction *)navAction.parentAction;
        self.category = categoryAction.category;
    }
    
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadingView.delegate = self;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    //Satish: initialize popular grid view
    [self initializePopularGridView];
    
    [self updateFromCategory:self.category];
}

- (void)showLoadingIndicator
{
    self.contentView.hidden = YES;
    [self.loadingView startLoadingWithText:NSLocalizedString(@"LoadingContentLKey", @"")];
}

- (void)hideLoadingIndicator
{
    self.contentView.hidden = NO;
    [self.loadingView endLoading];
}

- (void)channelCellSelected:(ChannelCellView *)channelCellView
{
    [ChannelModalViewController showFromView:channelCellView withChannel:channelCellView.channel navController:self.navigationController];
}

- (void)featuredCellSelected:(FeaturedContentCellView *)featuredCellView
{
    FeaturedContent *featuredContent = featuredCellView.featuredContent;
    
    [featuredCellView showLoadingIndicator];
    [FeaturedContentNavigator navigateToFeaturedContent:featuredContent
                                     fromViewController:self
                                      completionHandler:^
     {
         [featuredCellView hideLoadingIndicator];
     }];
}

- (void)updateFromFeaturedContent:(NSArray *)featuredContentArray
{
    for (int i = 0; i < featuredContentArray.count && i < kMaxFeaturedItems; ++i)
    {
        FeaturedContent *featuredContent = [featuredContentArray objectAtIndex:i];
        
        CellSize size = (i == 0 && featuredContentArray.count == 2) ? CellSizeLarge : CellSizeSmall;
        FeaturedContentCellView *cellView = [[FeaturedContentCellView alloc] initWithCellSize:size];
        
        if (i == 0) {
            cellView.accessibilityLabel = @"FeaturedContentCell";
        }
        else if ( i == 1)
            cellView.accessibilityLabel = @"FeaturedContentCell2";
        
        [cellView addTarget:self action:@selector(featuredCellSelected:) forControlEvents:UIControlEventTouchUpInside];
        cellView.featuredContent = featuredContent;
        [self.featuredContainer addSubview:cellView];
    }
}

- (UIView *)viewForChannel:(Channel *)channel
{
    ChannelCellView *channelCellView = [[ChannelCellView alloc] initWithCellSize:CellSizeSmall];
    channelCellView.channel = channel;
    [channelCellView addTarget:self action:@selector(channelCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    return channelCellView;
}

- (void)updateFromCategory:(ContentCategory *)category
{
    [self showLoadingIndicator];
    
    __block int numberOfErrors = 0;
    
    NSOperation *updatePopular = [NSBlockOperation blockOperationWithBlock:^{
        
        //Satish: loading data to popular grid view
        [self reloadDataInPopularView:category];
        
        
    }];
    
    
    NSOperation *updateFeatured = [NSBlockOperation blockOperationWithBlock:^{
        NSError *error = nil;
        self.featuredContent = [[VimondStore contentPanelStore] featuredContentPanelForCategory:category error:&error];
        if (error)
        {
            numberOfErrors++;
        }
    }];
    

    
    NSOperation *updateUI = [NSBlockOperation blockOperationWithBlock:^{
        if (numberOfErrors == 0)
        {
            [self hideLoadingIndicator];
            
            [self updateFromFeaturedContent:self.featuredContent];
            
            
        }
        else
        {
            [self.loadingView showRetryWithMessage:NSLocalizedString(@"ErrorLoadingContentLKey", @"")];
        }
    }];
    
    [updateUI addDependency:updateFeatured];
    [updateUI addDependency:updatePopular];
    
    [self.viewControllerOperationQueue addOperation:updateFeatured];
    [self.viewControllerOperationQueue addOperation:updatePopular];
    
    [[NSOperationQueue mainQueue] addOperation:updateUI];
}

- (void)addChannels:(NSArray *)channelArray toView:(UIView *)view
{
    [channelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         UIView *channelCell = [self viewForChannel:obj];
         [view addSubview:channelCell];
     }];
}


- (void)retryButtonWasPressedInLoadingView:(LoadingView *)loadingView
{
    //Satish: checks the view for which retry was clicked
    if (loadingView == self.loadingView) {
        [self updateFromCategory:self.category];
    }else if(loadingView == self.popularLoadingView)
    {
        [self reloadDataInPopularView:self.category];
    }
    
}

#pragma mark - Properties

- (void)setCategory:(ContentCategory *)category
{
    _category = category;
    
    self.title = self.category.title;
    
    if (self.isViewLoaded)
    {
        [self updateFromCategory:category];
    }
    
    //Satish: setting category for fetching data
    _popularChannelsForCategoryFetcher.sourceObject = category;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}

- (void)setContentSizeForScrollView:(UIScrollView *)scrollView fromContainer:(KITGridLayoutView *)container
{
    [container layoutSubviews];
    scrollView.contentSize = container.frame.size;
    
}


#pragma mark - Popular GridView functions

//Satish: setup the two rowed popular channels grid
- (void)setupPopularGrid
{
    
    self.popularView.layoutStrategy                      = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
    self.popularView.horizontalItemSpacing               = kHorizontalGridSpacing;
    self.popularView.verticalItemSpacing                 = kVerticalGridSpacing;
    self.popularView.centerGrid                    = NO;
    self.popularView.showsHorizontalScrollIndicator      = NO;
    self.popularView.minEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    
}

-(void)initializePopularGridView
{
    [self setupPopularGrid];
    
    CellViewFactory *channelCellFactory = [[CellViewFactory alloc] initWithWantedCellSize:CellSizeSmall cellViewClass:[ChannelCellView class]];
    
    _popularChannelsForCategoryFetcher = [PopularChannelsForCategoryDataFetcher new];
    PrefetchingDataSource *dataSource = [PrefetchingDataSource createWithDataFetcher:_popularChannelsForCategoryFetcher];
    dataSource.sortBy = ProgramSortByRatingCount;
    
    self.popularGridViewController = [[GridViewController alloc] initWithGridView:self.popularView gridCellFactory:channelCellFactory dataSource:dataSource];
    self.popularGridViewController.delegate = self;
    
}


- (void)showLoadingIndicatorForPopularView
{
   
    [self.popularLoadingView startLoadingWithText:NSLocalizedString(@"LoadingContentLKey", @"")];
}

- (void)hideLoadingIndicatorForPopularView
{
    [self.popularLoadingView endLoading];
}

-(void)reloadDataInPopularView:(ContentCategory *)category
{
    _popularChannelsForCategoryFetcher.sourceObject = category;
    [self showLoadingIndicatorForPopularView];
    [self.popularGridViewController reloadData:^{
        [self hideLoadingIndicatorForPopularView];
        
    } errorHandler:^(NSError *error){
        [self.popularLoadingView showRetryWithMessage:NSLocalizedString(@"ErrorLoadingContentLKey", @"")];
    }];
}


//gridview controller delegate
- (void)gridViewController:(GridViewController *)gridViewController didTapCell:(GridCellWrapper *)gridCell
{
    if ([gridCell.cellView isKindOfClass:[ChannelCellView class]])
    {
        [self channelCellSelected:((ChannelCellView*)[gridCell cellView])];
    }
}

@end
