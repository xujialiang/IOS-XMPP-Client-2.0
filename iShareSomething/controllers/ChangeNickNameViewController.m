//
//  ChangeNickNameViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ChangeNickNameViewController.h"
#import "XmppHelper+XmppVCard.h"
#import "XMPPvCardTemp.h"
@interface ChangeNickNameViewController ()

@end

@implementation ChangeNickNameViewController

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
    self.txtnickname.text=self.nickname;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    XMPPvCardTemp *card=[[XmppHelper Instance] getmyvcard];
    card.nickname=self.txtnickname.text;
    [[XmppHelper Instance] updateVCard:card success:^{
        self.fromlabel.text=self.txtnickname.text;
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *err) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
}
@end
