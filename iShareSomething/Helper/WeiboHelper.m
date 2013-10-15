//
//  WeiboHelper.m
//  iShareSomething
//
//  Created by Elliott on 13-5-22.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "WeiboHelper.h"
#import "AppDelegate.h"
@implementation WeiboHelper

-(id)init{
    if(self=[super init]){
        self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
        if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
        {
            self.sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
            self.sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
            self.sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
        }
    }
    return self;
}

+(WeiboHelper *)Instance{
    AppDelegate *appdel= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appdel.weiboHepler==nil){
        appdel.weiboHepler=[[WeiboHelper alloc] init];
    }
    return appdel.weiboHepler;
}

-(void)logIn:(WBLoginCallBackVoid)success fail:(WBLoginCallBackErr)fail{
    self.loginsuccess=success;
    self.loginerror=fail;
    [self.sinaweibo logIn];
}


-(void)TimeLine{
    [self.sinaweibo ];
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSUserDefaults *userinfo=[NSUserDefaults standardUserDefaults];
    [userinfo setObject:sinaweibo.accessToken forKey:@"access_token"];
    [userinfo setObject:sinaweibo.expirationDate forKey:@"expire_date"];
    [userinfo setObject:sinaweibo.userID forKey:@"uid"];
    [userinfo synchronize];
    self.loginsuccess(sinaweibo);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    self.loginerror(error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    NSLog(@"access token invalid");
}


@end
