//
//  ChangeSignatureViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ChangeSignatureViewController.h"
#import "XmppHelper+XmppVCard.h"
#import "XMPPvCardTemp.h"
@interface ChangeSignatureViewController ()

@end

@implementation ChangeSignatureViewController

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
    self.txtsignature.text=self.signature;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    XMPPvCardTemp *card=[[XmppHelper Instance] getmyvcard];
    card.signature=self.txtsignature.text;
    [[XmppHelper Instance] updateVCard:card success:^{
        self.fromlabel.text=self.txtsignature.text;
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *err) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
}
@end
