//
//  GetPasswordViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-23.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "GetPasswordViewController.h"

@interface GetPasswordViewController ()

@end

@implementation GetPasswordViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GetPassword:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"未完成" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
