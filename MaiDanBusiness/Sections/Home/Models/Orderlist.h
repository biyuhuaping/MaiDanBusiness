//
//  Orderlist.h
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/10.
//  Copyright © 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Orderlist : NSObject

@property(nonatomic,strong) NSString *totalFee;//消费金额
@property(nonatomic,strong) NSString *orderstatusname;//消费状态的名字
@property(nonatomic,strong) NSString *shoplogo;//消费商店的logo
@property(nonatomic,strong) NSString *shopName;//消费商店的名字
@property(nonatomic,strong) NSString *terminal;//获得积分
@property(nonatomic,strong) NSString *userName;//用户名字
@property(nonatomic,strong) NSString *orderNo;//订单号
@property(nonatomic,strong) NSString *createTime;//创建时间
@property(nonatomic,strong) NSString *confirmTime;//确认时间
@property(nonatomic,strong) NSString *qrcodeimg;//二维码图片路径
@property(nonatomic,strong) NSString *payType;//支付方式
@property(nonatomic,strong) NSString *orderid;//订单id
@property(nonatomic,strong) NSString *orderStatus;//消费状态
@property(nonatomic,strong) NSString *discount;//分别比例



@end
