//
//  IntegralManageViewController.h
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "BaseViewController.h"

@class Integral;
@interface IntegralManageViewController : BaseViewController
{
  
    BOOL _reloading;
}

@property (nonatomic, strong) NSString *strLogoUrl;//logo

@property (nonatomic, strong) NSString *totalRevenue; //总收入
@property (nonatomic, strong) NSString *operatingIncome;//营业收入
@property (nonatomic, strong) NSString *benefitSharing;//分享收益


@property (nonatomic, strong) Integral *integral;
@property (nonatomic, strong) NSMutableArray *marrList;//存取积分类数据


@end
