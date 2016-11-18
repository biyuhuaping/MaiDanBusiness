//
//  FulfillCardVC.h
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/2/1.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "FulfillCardVC.h"

@interface FulfillCardVC : UIViewController
@property (nonatomic, retain) UIView *vwPayWay;              //支付方式块背景
@property (nonatomic,assign) NSInteger iPayWay;                           //支付方式 1为支付宝 2为微信 3为余额 4为礼卡

@end
