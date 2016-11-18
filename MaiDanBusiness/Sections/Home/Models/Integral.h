//
//  Integral.h
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/10.
//  Copyright © 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Integral : NSObject
@property(nonatomic,strong) NSString *recid;//单号
@property(nonatomic,strong) NSString *source;//动态
@property(nonatomic,strong) NSString *score;//积分
@property(nonatomic,strong) NSString *createtime;//时间

@property(nonatomic,strong) NSString *paytypename;//支付方式简介
@property(nonatomic,strong) NSString *memo;//利润来源
@property(nonatomic,strong) NSString *paytype;//支付方式
@end
