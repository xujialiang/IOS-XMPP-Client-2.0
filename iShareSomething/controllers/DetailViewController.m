//
//  DetailViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "DetailViewController.h"
#import "XMPPUserMemoryStorageObject.h"
#import "DetailCell.h"
#import "XmppHelper+XmppVCard.h"
#import "XMPPvCardTemp.h"
#import "ChatSessionViewController.h"
@interface DetailViewController ()
@property (nonatomic,strong) XMPPUserMemoryStorageObject *userinfo;
@property (nonatomic,strong) XMPPvCardTemp *usercard;
@property (strong,nonatomic) ChatSessionViewController *destview;
@end

@implementation DetailViewController

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

-(void)loaddata:(XMPPUserMemoryStorageObject *)userinfo{
    self.userinfo=userinfo;
    self.name.text=userinfo.nickname;
    self.jid.text=userinfo.jid.user;
    self.remarkname.text=userinfo.displayName;
    if(userinfo.photo!=nil){
        self.photo.image=userinfo.photo;
    }
    self.usercard=[[XmppHelper Instance] getvcard:userinfo.jid.user];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendmsg:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.destview=segue.destinationViewController;
    self.destview.userinfo=self.userinfo;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailCell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.title.text=@"性别";
            if(self.usercard.sex==nil){
                cell.content.text=@"未知";
            }else{
                cell.content.text=self.usercard.sex;
            }
            break;
        case 1:
            cell.title.text=@"个性签名";
            if(self.usercard.signature==nil){
                cell.content.text=@"这家伙很懒，什么都没有留下";
            }else{
                cell.content.text=self.usercard.signature;
            }
            break;
        case 2:
            cell.title.text=@"地区";
            if(self.usercard.local==nil){
                cell.content.text=@"火星";
            }else{
                cell.content.text=self.usercard.local;
            }
            break;
        default:
            break;
    }
    
    return cell;
}
@end
