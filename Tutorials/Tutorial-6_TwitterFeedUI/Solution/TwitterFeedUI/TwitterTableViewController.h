//
//  TwitterTableViewController.h
//  TwitterFeedUI
//
//  Created by Michael Mühlebach on 4/14/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetService.h"


@interface TwitterTableViewController : UITableViewController<TweetServiceDelegate>

@end
