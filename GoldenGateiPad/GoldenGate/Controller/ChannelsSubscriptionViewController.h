//
//  ChannelsSubscriptionViewController.h
//  GoldenGate
//
//  Created by Satish Basavaraj on 13/05/13.
//  Copyright (c) 2013 Valtech. All rights reserved.
//

#import "BaseNavViewController.h"
#import "LoadingView.h"

//Controller to show Subscribed channels grouped gy Genre

@interface ChannelsSubscriptionViewController : BaseNavViewController<UITableViewDataSource, UITableViewDelegate, LoadingViewDelegate>

@end
