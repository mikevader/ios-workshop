//
//  CustomerDetailViewCell.m
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 2/22/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "CustomerDetailViewCell.h"

@implementation CustomerDetailViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState:state];
    
    if (state & UITableViewCellStateEditingMask) {
        self.textfield.enabled = YES;
    }
    
    
}

- (void)didTransitionToState:(UITableViewCellStateMask)state
{
    [super didTransitionToState:state];
    
    if (!(state & UITableViewCellStateEditingMask)) {
        self.textfield.enabled = NO;
    }
    
}


@end
