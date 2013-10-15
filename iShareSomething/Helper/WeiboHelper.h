//
//  WeiboHelper.h
//  iShareSomething
//
//  Created by Elliott on 13-5-22.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WeiboHelper : NSObject<SinaWeiboDelegate>

typedef void (^WBLoginCallBackVoid) (SinaWeibo *sinaweibo);
typedef void (^WBLoginCallBackErr) (NSError *error);

@property (strong,nonatomic) SinaWeibo *sinaweibo;
@property (strong,nonatomic) WBLoginCallBackVoid loginsuccess;
@property (strong,nonatomic) WBLoginCallBackErr loginerror;

+(WeiboHelper *)Instance;

-(void)logIn:(WBLoginCallBackVoid)success fail:(WBLoginCallBackErr)fail;

@end
