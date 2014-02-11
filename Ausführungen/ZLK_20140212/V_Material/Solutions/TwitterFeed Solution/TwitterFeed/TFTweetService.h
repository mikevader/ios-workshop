//
//  TFTweetService.h
//  TwitterFeed
//
//  Created by Michael Mühlebach on 10/02/14.
//
//

#import <Foundation/Foundation.h>

#import "TFTweet.h"

@protocol TFTweetServiceDelegate <NSObject>

- (void)retrievedTweets:(NSArray*)tweets;

@end

@interface TFTweetService : NSObject
@property id<TFTweetServiceDelegate> delegate;

- (void)requestTweets;

@end
