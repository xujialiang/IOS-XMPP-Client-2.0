//
//  LoginViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "LoginViewController.h"
#import "WeiboHelper.h"
#import "UserHelper.h"
#import "NSDefaultUserInfo.h"
#import "XmppHelper+Login.h"
#import "XmppHelper+XmppVCard.h"
#import "XMPPvCardTemp.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.txtaccount.text=[[UserHelper UserInfo] account];
    self.txtpassword.text=[[UserHelper UserInfo] password];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDefaultUserInfo *)getUserInfo{
    NSDefaultUserInfo *user=[[NSDefaultUserInfo alloc] init];
    user.account=self.txtaccount.text;
    user.password=self.txtpassword.text;
    return user;
}

- (IBAction)btnLogin:(id)sender {
    XmppHelper *helper=[XmppHelper Instance];
    NSDefaultUserInfo *user=[self getUserInfo];
    NSString *islogin=[helper Login:user success:^{
        [UserHelper SaveUserInfo:user];
        [self dismissViewControllerAnimated:YES completion:nil];
    } fail:^(NSError *err) {
        //登陆失败
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:err.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
    if(islogin!=nil){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:islogin delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
@end
