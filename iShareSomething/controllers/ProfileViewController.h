//
//  ProfileViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *account;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *area;
@property (strong, nonatomic) IBOutlet UILabel *signature;


-(void)ChangePhoto;
@end
