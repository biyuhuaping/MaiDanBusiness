//
//  MDShopInfoModel.h
//  MaiDanBusiness
//
//  Created by 潇哥 on 2016/11/17.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDShopInfoModel : NSObject

/** 登录名 */
@property (nonatomic, copy) NSString *loginName;
/** 邀请码 */
@property (nonatomic, copy) NSString *inviteCode;
/** 消费利润 */
@property (nonatomic, copy) NSString *discountRate;
/** 商户名称 */
@property (nonatomic, copy) NSString *shopName;
/** 商户一级分类 */
@property (nonatomic, copy) NSString *shopType;
/** 商户二级分类 */
@property (nonatomic, copy) NSString *shopType2;
/** 联系人 */
@property (nonatomic, copy) NSString *linkMan;
/** 手机号 */
@property (nonatomic, copy) NSString *phone;
/** 电话 */
@property (nonatomic, copy) NSString *tel;
/** QQ号 */
@property (nonatomic, copy) NSString *qq;
/** 邮箱 */
@property (nonatomic, copy) NSString *email;
/** 省 */
@property (nonatomic, copy) NSString *province;
/** 市 */
@property (nonatomic, copy) NSString *city;
/** 区 */
@property (nonatomic, copy) NSString *region;
/** 详细地址 */
@property (nonatomic, copy) NSString *address;
/** 人均消费 */
@property (nonatomic, copy) NSString *perFee;
/** 消费金额 */
@property (nonatomic, copy) NSString *xiaofei;
/** 赠送金额 */
@property (nonatomic, copy) NSString *zs_score;
/** 活动说明 */
@property (nonatomic, copy) NSString *memo;
/** 使用说明 */
@property (nonatomic, copy) NSString *content;
/** 优惠起始 */
@property (nonatomic, copy) NSString *useStartTime;
/** 优惠结束 */
@property (nonatomic, copy) NSString *useEndTime;
/** 营业开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 营业结束时间 */
@property (nonatomic, copy) NSString *endTime;


@end
