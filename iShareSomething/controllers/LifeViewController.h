//
//  LifeViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-31.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wait;

- (IBAction)publish:(id)sender;


@end
