//
//  RegViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "RegViewController.h"
#import "NSDefaultUserInfo.h"
#import "UserHelper.h"
#import "XmppHelper+Register.h"
#import "AppDelegate.h"

@interface RegViewController ()

@end

@implementation RegViewController

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
    //将先前保存的用户名和密码填充到文本框中
    NSDefaultUserInfo *user=[UserHelper UserInfo];
    self.account.text=user.account;
    self.password.text=user.password;
}
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存用户信息
-(void)saveUserInfo{
    NSDefaultUserInfo *user=[self getuserinfo];
    [UserHelper SaveUserInfo:user];
}

-(NSDefaultUserInfo *)getuserinfo{
    NSDefaultUserInfo *userinfo=[[NSDefaultUserInfo alloc] init];
    userinfo.account=self.account.text;
    userinfo.password=self.password.text;
    return userinfo;
}

- (IBAction)btnReg:(id)sender {
    [self.progressbar startAnimating];
    XmppHelper *xmpphelper=[XmppHelper Instance];
    
    NSString *result=[xmpphelper Register:[self getuserinfo] success:^{
        [self saveUserInfo];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self.progressbar stopAnimating];
    } fail:^(NSError *err) {
        NSString *errorinfo=[NSString stringWithFormat:@"错误代码:%d",err.code];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"出错啦~" message:errorinfo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self.progressbar stopAnimating];
    }];
    if(result!=nil){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:result delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self.progressbar stopAnimating];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
