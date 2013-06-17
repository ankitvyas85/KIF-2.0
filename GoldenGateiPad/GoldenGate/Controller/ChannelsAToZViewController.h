//
//  ChannelsAToZViewController.h
//  GoldenGate
//
//  Created by Andreas Petrov on 9/23/12.
//  Copyright (c) 2012 Knowit. All rights reserved.
//

#import "BaseNavViewController.h"

#import "LoadingView.h"

/*!
 @abstract
 This view controller is used to show a list of channels alphabetically sorted.
 Each shown channel will show the five most recent videos in that channel.
 */
@interface ChannelsAToZViewController : BaseNavViewController <UITableViewDataSource, UITableViewDelegate, LoadingViewDelegate>

@end
