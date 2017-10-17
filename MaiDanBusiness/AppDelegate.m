//
//  AppDelegate.m
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/8.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "AppDelegate.h"
#import "DEMONavigationController.h"
#import "HomeViewController.h"
#import "CLLockVC.h"

//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Create content and menu controllers
    //
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self buildSrandom];

    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //改变状态栏颜色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        [[UINavigationBar appearance] setTranslucent:YES];
    }
    // 隐藏返回文字
    [[UIBarButtonItem appearance]
     setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0)
     forBarMetrics:UIBarMetricsDefault];
    [UMSocialData setAppKey:UmengAppkey];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:G_WX_KEY appSecret:APP_SECRET url:@"http://91maidan.com"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105375850" appKey:@"ijILtzqCpR4J2GWo" url:@"http://91maidan.com"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"脉单";//微信
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"脉单";//微信朋友圈
    [UMSocialData defaultData].extConfig.emailData.title = @"脉单";//邮箱
    [UMSocialData defaultData].extConfig.tencentData.title = @"脉单";//腾讯微博
    [UMSocialData defaultData].extConfig.qqData.title = @"脉单";//QQ
    [UMSocialData defaultData].extConfig.qzoneData.title = @"脉单";//QQ 空间
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  
    _lockBool= YES;
    
    //进去
    self.homeVC = [[HomeViewController alloc] init];
    self.navigationController = [[DEMONavigationController alloc] initWithRootViewController:_homeVC];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming"] forBarMetrics:UIBarMetricsDefault];
    self.window.rootViewController = _navigationController;
    
    [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_YES];
//    NSString *strIsLogin = [[API shareAPI] getLocalData:G_IS_LOGIN];
//
//    if ([strIsLogin isEqualToString:G_YES] ) {
//        
//
//    }else{
//        
//    }
  
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.    printf("按理说是重新进来后响4应\n");
    
//    NSString *login = [[API shareAPI] getLocalData:G_IS_LOGIN];
//    NSString *gestures= [[API shareAPI] getLocalData:G_IS_GESTURES];
//
//    if ([login isEqualToString:G_YES] &&[gestures isEqualToString:G_NO]) {
//        //判断是否已经存在密码
//        BOOL hasPwd = [CLLockVC hasPwd];
//        [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_YES];
//        if (hasPwd) {
//            [CLLockVC showVerifyLockVCInVC:self.homeVC forgetPwdBlock:^{
//                [[API shareAPI] saveLocalData:G_IS_LOGIN value:G_NO];
//                [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_NO];
//
//                NSLog(@"忘记密码");
//                _lockBool = NO;
//
//                
//            } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
//                NSLog(@"密码正确");
//                [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_NO];
//
//            }];
//        }else{
//            [CLLockVC showSettingLockVCInVC:self.homeVC  successBlock:^(CLLockVC *lockVC, NSString *pwd) {
//                NSLog(@"密码设置成功");
//                [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_NO];
//
//            }];
//        }
//    }


    
}
#pragma mark - Weibo Delegate


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == NO) {
        if ([url.host isEqualToString:@"safepay"])
        {
            [[AlipaySDK defaultService] processOderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                
                if([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"])//支付成功
                {
                    [SVProgressHUD showSuccessWithStatus:@"充值成功！"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:G_FULLFILL_SUCCESS object:nil userInfo:nil];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"充值失败！"];
                    
                    NSLog(@"支付不成功");
                }
                
            }];
        }
        else  if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                
                if([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"])
                {
                    [SVProgressHUD showSuccessWithStatus:@"充值成功！"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:G_FULLFILL_SUCCESS object:nil userInfo:nil];
                }
                else
                {
                    [SVProgressHUD showSuccessWithStatus:@"充值失败！"];
                    
                    NSLog(@"支付不成功");
                }
                
            }];
        }
        
        else //微信回调
        {
            return  [WXApi handleOpenURL:url delegate:self];
        }

    }
    
    return result;
}

- (void) UserClicked:(id)sender

{
    NSString *strPwd = [[API shareAPI] getLocalData:G_WORKER_PWD];
    
    if ([_txt1.text isEqualToString:strPwd])
    {
        NSLog(@"%@",@"1");
        [SVProgressHUD showSuccessWithStatus:@"输入正确"];
        _bgview.hidden=YES;
        
        [_txt1 resignFirstResponder]; //隐藏键盘
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"输入错误"];
        return;
    }
    
    
    
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode == 0)
        {
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"未分享"];
        }
    }
    else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if(resp.errCode == 0)//分享成功
        {
            //            NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
            //            NSString *strUserID = [setting objectForKey:@"UserID"];
            //            if(strUserID == nil ||[strUserID isEqualToString:@""])
            //                return;
            //            NSString *strPro = [setting objectForKey:@"ShareProductID"];
            //            if(strPro == nil || [strPro isEqualToString:@""])
            //                strPro = @"0";
            //            NSString *strPageUrl = [NSString stringWithFormat:@"ShareProduct&userid=%@&productid=%@",strUserID,strPro];
            //            strPageUrl = [kServerUrl stringByAppendingString:strPageUrl];
            //
            //            NSLog(@"%@",strPageUrl);
            //
            //            [setting removeObjectForKey:@"ShareProductID"];
            //
            //            HttpClient *http = [HttpClient httpClientWithDelegate:self];
            //            http.needTipsNetError = YES;
            //            [http LoadDataFromNet:strPageUrl code:HttpRequestPathForShareProduct];
        }
    }
    else if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode)
        {
            case WXSuccess: {
                NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
                [setting setObject:@"0" forKey:@"RedPoint"];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeCartRedPoint" object:nil];
                
                //                NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
                NSString *strFrom = [setting objectForKey:@"AliFrom"];  // 1为从充值那边返回     2为从购物车订单返回      3为从礼卡返回     4从订单详情返回
                
                //                PaySuccessedViewController *controller = [[PaySuccessedViewController alloc]init];
                if([strFrom isEqualToString:@"1"])//从充值那边反馈过来
                {
                    //                    PayOKViewController *controller2 = [[PayOKViewController alloc]init];
                    //                    controller2.strFrom = @"ReCharge";
                    //                    controller2.strAliFrom = @"2";
                    //                    [_xmController.currentVC.navigationController popToRootViewControllerAnimated:YES];
                    //                    [_xmController.currentVC presentViewController:controller2 animated:YES completion:nil];
                }
                else if ([strFrom isEqualToString:@"2"])//从购物车订单返回
                {
                    //                    controller.strType = @"CartAlip";
                    //                    [_xmController presentViewController:controller animated:YES completion:Nil];
                }
                else if ([strFrom isEqualToString:@"3"])//从礼卡返回
                {
                    //                    GiftCardViewController *controller3 = [[GiftCardViewController alloc]init];
                    //                    [_xmController.currentVC.navigationController pushViewController:controller3 animated:YES];
                    //
                    //                    PayOKViewController *controller2 = [[PayOKViewController alloc]init];
                    //                    controller2.strFrom = @"GiftCard";
                    //                    controller2.strAliFrom = @"2";
                    //                    [_xmController.currentVC presentViewController:controller2 animated:YES completion:nil];
                }
                else if ([strFrom isEqualToString:@"4"])//从订单详情返回
                {
                    //                    controller.strType = @"OrderDetailAlip";
                    //                    [_xmController presentViewController:controller animated:YES completion:Nil];
                }
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];

                [setting removeObjectForKey:@"AliFrom"];
                [setting setObject:@"0" forKey:@"AliFrom"];
                
            }
                break;
            default: {
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                NSLog(@"不成功");
                break;
            }
        }
    }
}

- (void)buildSrandom
{
//    取值
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strDeviceID = [config objectForKey:G_DEVICE_ID];
    
    if (strDeviceID == nil)
    {
        [[API shareAPI] saveLocalData:G_IS_LOGIN value:G_NO];

        //    创建随机数
        int iCount1 = arc4random() % 5 ;
        int iCount2 = arc4random() % 5 ;
        int iCount3 = arc4random() % 5 ;
        int iCount4 = arc4random() % 5 ;
        int iCount5 = arc4random() % 5 ;
        int iCount6 = arc4random() % 5 ;
        int iCount7 = arc4random() % 5 ;
        int iCount8 = arc4random() % 5 ;
        
        
        NSString *strTemp = [NSString stringWithFormat:@"%d%d%d%d%d%d%d%d",iCount1,iCount2,iCount3,iCount4,iCount5,iCount6,iCount7,iCount8];
        [config setObject:strTemp forKey:G_DEVICE_ID];
        [config synchronize];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
