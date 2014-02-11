//
//  TwitterTableViewController.m
//  TwitterFeedUI
//
//  Created by Michael Mühlebach on 4/14/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "TwitterTableViewController.h"
#import "TweetViewController.h"
#import "TweetService.h"
#import "Tweet.h"

@interface TwitterTableViewController ()


@end

@implementation TwitterTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TweetService* ts = [[TweetService alloc] init];
    ts.delegate = self;
    [ts requestTweets];
}

#pragma mark - Tweet service delegate
// Delegate Method of TweetServiceDelegate
- (void)retrievedTweets:(NSArray *)tweets
{
    // Save a pointer to the model (array of tweets)
    
    // Tell the view to refresh itself

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of tweets in our model
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Get the right tweet from the model (array with tweets)
    
    // Write the needed information of the tweet on the cell
    
    return cell;
}


#pragma mark - Table view delegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
//        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
//        Tweet* tweet = [self.tweets objectAtIndex:indexPath.row];
//        TweetViewController* tweetView = segue.destinationViewController;
//        tweetView.tweet = tweet;
    }
}


@end
