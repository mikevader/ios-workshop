//
//  TweetService.h
//  TwitterFeedUI
//
//  Created by Michael Mühlebach on 4/12/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TweetServiceDelegate <NSObject>

- (void)retrievedTweets:(NSArray*)tweets;

@end


@interface TweetService : NSObject
@property id<TweetServiceDelegate> delegate;

- (void)requestTweets;

@end
