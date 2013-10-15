//
//  ChangeNickNameViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeNickNameViewController : UIViewController
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtnickname;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) UILabel *fromlabel;
@end
