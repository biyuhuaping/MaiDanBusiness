//
//  AppDelegate.h
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/8.
//  Copyright © 2015年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@class DEMONavigationController,DEMOMenuViewController,HomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,UIAlertViewDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIView * bgview;
@property (nonatomic, strong) UITextField * txt1;
@property (strong, nonatomic) DEMONavigationController *navigationController;

@property (strong, nonatomic) DEMOMenuViewController *menuController;
@property (strong, nonatomic) HomeViewController *homeVC ;
@property (assign, nonatomic)BOOL lockBool;


@end

