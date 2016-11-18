//
//  LoginViewController.h
//  DaJiaZhuan
//
//  Created by Bibo on 14/12/31.
//  Copyright (c) 2014年 Bibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeMessage,HomeViewController;
@protocol LogoInDelegate <NSObject>

@optional

- (void)passValue:(NSString *)strValue;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain)id <LogoInDelegate>loginDegate;
@property (nonatomic,strong)HomeMessage *homeMessage;
@property (nonatomic, strong)HomeViewController *homeVC;
@end
