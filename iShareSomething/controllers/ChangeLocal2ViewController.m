//
//  ChangeLocal2ViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ChangeLocal2ViewController.h"
#import "DDXML.h"
#import "XMPPvCardTemp.h"
#import "XmppHelper+XmppVCard.h"
@interface ChangeLocal2ViewController ()

@property (nonatomic,strong) NSMutableArray *subdata;

@end

@implementation ChangeLocal2ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)loaddata:(NSString *)cid {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Districts" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    [self parseXMLSub:xmlData withID:cid];
    [self.tableview reloadData];
}

-(NSArray *)parseXMLSub:(NSData *) data withID:(NSString *)cityid{
    //文档开始（KissXML和GDataXML一样也是基于DOM的解析方式）
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
    
    //利用XPath来定位节点（XPath是XML语言中的定位语法，类似于数据库中的SQL功能）
    NSArray *Districts = [xmlDoc nodesForXPath:@"//Districts//District" error:nil];
    self.subdata=[[NSMutableArray alloc] init];
    for (DDXMLElement *province in Districts) {
        NSString *id = [[province attributeForName:@"CID"] stringValue];
        if([id isEqualToString:cityid])
        {
            NSString *DistrictName=[[province attributeForName:@"DistrictName"] stringValue];
            [self.subdata addObject:DistrictName];
        }
    }
    return self.subdata;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //文本
    cell.textLabel.text = [self.subdata objectAtIndex:[indexPath row]];
    //标记
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *address=[self.subdata objectAtIndex:indexPath.row];
    XMPPvCardTemp *card=[[XmppHelper Instance] getmyvcard];
    card.local=[self.cname stringByAppendingFormat:@",%@",address];
    [[XmppHelper Instance] updateVCard:card success:^{
        self.arealabel.text=card.local;
        [self.navigationController popToViewController:(UIViewController *)self.viewcontroller animated:YES];
    } fail:^(NSError *err) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
}

@end
