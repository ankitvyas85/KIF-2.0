#import "ContentPanelStore.h"
#import "ContentCategory.h"
#import "ContentPanelClient.h"
#import "RestPlatform.h"
#import "RestContentPanel.h"
#import "RestContentPanelElement.h"
#import "RestSearchCategory.h"

@implementation ContentPanelStore {
    RestPlatform *_platform;
    ContentPanelClient *_contentPanelClient;
    NSDictionary *_contentPanelTypeToNameDict;
}
- (id)initWithBaseURL:(NSString *)baseURL platformName:(NSString *)platformName
{
    if (self = [super init])
    {
        _contentPanelClient = [[ContentPanelClient alloc] initWithBaseURL:baseURL];
        _platform = [RestPlatform platformWithName:platformName];
        _contentPanelTypeToNameDict =
        @{
            @(ContentPanelTypeNoteworthy)   : @"noteworthy",
            @(ContentPanelTypePopular)      : @"popular",
            @(ContentPanelTypeFeatured)     : @"featured"
        };
    }
    return self;
}

- (NSArray *)contentPanel:(ContentPanelType)type forCategory:(ContentCategory *)category error:(NSError **)error
{
    
    NSString *contentPanelName = [NSString stringWithFormat:@"%d_%@", category.identifier, [_contentPanelTypeToNameDict objectForKey:@(type)]];
    
    RestContentPanel *contentPanel = [_contentPanelClient getExpandableContentPanelByName:contentPanelName platform:_platform expand:@"content" error:error];
    NSMutableArray *result = [NSMutableArray array];
    for (RestContentPanelElement *element in contentPanel.contentPanelElements)
    {
        if ([element.category channelObject])
        {
            [result addObject:[element.category channelObject]];
        }
    }
    return result;
}



- (NSArray *)featuredContentPanelForCategory:(ContentCategory *)category error:(NSError **)error
{
    NSString *contentPanelName = [NSString stringWithFormat:@"%d_%@", category.identifier, @"featured"];
    RestContentPanel *contentPanel = [_contentPanelClient getExpandableContentPanelByName:contentPanelName platform:_platform expand:@"content" error:error];
    NSMutableArray *result = [NSMutableArray array];
    for (RestContentPanelElement *element in contentPanel.contentPanelElements)
    {
        FeaturedContent *item = [FeaturedContent new];
        item.title = element.title;
        item.text = element.text;
        item.contentKey = [element.contentKey intValue];
        [item setContentTypeFromString:element.contentType];
        item.imagePack = element.imagePack;
        item.imageURL = element.imageURL;
        
        switch (item.contentType)
        {
            case FeaturedContentTypeCategory:
                item.category = [element.category categoryObject];
                break;
            case FeaturedContentTypeChannel:
                item.channel = [element.category channelObject];
                break;
            default:
                break;
        }
        [result addObject:item];
    }
    return result;
}

@end