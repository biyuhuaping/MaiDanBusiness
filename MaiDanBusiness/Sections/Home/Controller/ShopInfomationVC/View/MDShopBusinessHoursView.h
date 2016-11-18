//
//  MDShopBusinessHoursView.h
//  MaiDanBusiness
//
//  Created by 潇哥 on 2016/11/18.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDShopBusinessHoursView : UIView

/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;

+ (instancetype)shopBusinessHoursView;

@end
