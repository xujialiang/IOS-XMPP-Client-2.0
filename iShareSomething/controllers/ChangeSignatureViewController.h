//
//  ChangeSignatureViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSignatureViewController : UIViewController
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtsignature;

@property (strong,nonatomic) NSString *signature;
@property (strong,nonatomic) UILabel *fromlabel;
@end
