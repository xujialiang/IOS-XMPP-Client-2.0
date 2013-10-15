//
//  RegViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressbar;
- (IBAction)btnReg:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *account;

@end
