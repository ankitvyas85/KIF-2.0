#import <Foundation/Foundation.h>

typedef enum {
    ContentPanelTypeNoteworthy,
    ContentPanelTypePopular,
    ContentPanelTypeFeatured
} ContentPanelType;

@class ContentCategory;

@interface ContentPanelStore : NSObject

- (id)initWithBaseURL:(NSString *)baseURL platformName:(NSString *)platformName;
- (NSArray *)contentPanel:(ContentPanelType)type forCategory:(ContentCategory *)category error:(NSError **)error;
- (NSArray *)featuredContentPanelForCategory:(ContentCategory *)category error:(NSError **)error;

@end