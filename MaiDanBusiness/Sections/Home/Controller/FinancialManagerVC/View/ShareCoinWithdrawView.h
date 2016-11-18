//
//  ShareCoinWithdrawView.h
//  MaiDanSH
//
//  Created by lin on 16/11/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCoinWithdrawView : UIView

/** 提现扣税提示 */
@property (nonatomic, copy) NSString *tips;
/** 文本框内容 */
@property (nonatomic, copy, readonly) NSString *text;
/** 是否需要发票 */
@property (nonatomic, assign, readonly) BOOL needBill;

@end
