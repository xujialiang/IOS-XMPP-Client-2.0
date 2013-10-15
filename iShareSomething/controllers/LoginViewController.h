//
//  LoginViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtaccount;
@property (strong, nonatomic) IBOutlet UITextField *txtpassword;


- (IBAction)btnLogin:(id)sender;


@end
