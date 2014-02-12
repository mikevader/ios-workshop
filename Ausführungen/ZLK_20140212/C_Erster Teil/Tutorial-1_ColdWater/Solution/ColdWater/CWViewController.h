//
//  CWViewController.h
//  ColdWater
//
//  Created by Michael Mühlebach on 10/02/14.
//  Copyright (c) 2014 Zühlke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CWHelloWorld.h"

@interface CWViewController : UIViewController

@property IBOutlet UILabel* label;
@property CWHelloWorld* model;

@end
