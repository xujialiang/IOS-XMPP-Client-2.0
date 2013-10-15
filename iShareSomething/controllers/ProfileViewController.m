//
//  ProfileViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ProfileViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XMPPvCardTemp.h"
#import "XmppHelper+XmppVCard.h"
#import "ChangeNickNameViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "UIImage+withRoundedRectImage.h"
#import "ChangeSignatureViewController.h"
#import "ChangeLocal1ViewController.h"
@interface ProfileViewController ()
@property (nonatomic,strong) XMPPvCardTemp *vcard;

@property (nonatomic,strong) UIActionSheet *actionsheetsex;
@property (nonatomic,strong) UIActionSheet *actionsheetphoto;
@end

@implementation ProfileViewController

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
    
    //读取xmppVCard
    self.vcard=[[XmppHelper Instance] getmyvcard];
    if(self.vcard.photo==nil){
        self.photo.image=[UIImage imageNamed:@"photo.png"];
    }else{
        self.photo.image=[UIImage imageWithData:self.vcard.photo];
    }
    self.nickname.text=self.vcard.nickname;
    self.account.text=self.vcard.jid.user;
    self.sex.text=self.vcard.sex;
    self.area.text=self.vcard.local;
    self.signature.text=self.vcard.signature;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"changenickname"]){
        ChangeNickNameViewController *destview = segue.destinationViewController;
        destview.nickname=self.vcard.nickname;
        destview.fromlabel=self.nickname;
    }else if([segue.identifier isEqualToString:@"changesignature"]){
        ChangeSignatureViewController *destview=segue.destinationViewController;
        destview.signature=self.vcard.signature;
        destview.fromlabel=self.signature;
    }
    else if([segue.identifier isEqualToString:@"changelocal"]){
        ChangeLocal1ViewController *destview=segue.destinationViewController;
        destview.locallabel=self.area;
        destview.viewcontroller=self;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if(indexPath.row==0){
            [self ChangePhoto];
        }
    }else if(indexPath.section==1){
        if(indexPath.row==0){
            [self ChangeSex];
        }
    }
    
}

-(void)ChangePhoto{
    UIActionSheet* mySheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"拍照", @"选择本地图片",nil];
    self.actionsheetphoto=mySheet;
    [mySheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)ChangeSex{
    UIActionSheet* mySheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"男", @"女",@"人妖",nil];
    self.actionsheetsex=mySheet;
    [mySheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet==self.actionsheetphoto){
        if(buttonIndex==0){
            [self takePictureButtonClick:self];
        }
        if(buttonIndex==1){
            [self selectphotofromloca];
        }
    }else if(actionSheet==self.actionsheetsex){
        [self selectsex:buttonIndex];
    }
}

-(void)selectsex:(NSInteger)index{
    NSString *sex=@"未填写";
    switch (index) {
        case 0:
            sex=@"男";
            break;
        case 1:
            sex=@"女";break;
        case 2:
            sex=@"人妖";break;
        default:
            break;
    }
    self.vcard.sex=sex;
    [[XmppHelper Instance] updateVCard:self.vcard success:^{
        self.sex.text=sex;
    } fail:^(NSError *err) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
}

-(void)selectphotofromloca{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
        
    }
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)takePictureButtonClick:(id)sender{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到相机或者当前相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakePicture = NO;
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    //检查是否支持拍照
    if (!canTakePicture) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到相机或者当前相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取用户编辑之后的图像
        UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //更新vcard
        CGSize size = CGSizeMake(100,100);  // 设置尺寸
        
        editedImage=[UIImage createRoundedRectImage:editedImage size:size radius:10];
        self.vcard.photo=UIImagePNGRepresentation(editedImage);
        [[XmppHelper Instance] updateVCard:self.vcard success:^{
            self.photo.image=editedImage;
        } fail:^(NSError *err) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"更新头像失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"不支持视屏操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}



@end
