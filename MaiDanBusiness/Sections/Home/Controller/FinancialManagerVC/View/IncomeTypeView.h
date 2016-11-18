//
//  IncomeTypeView.h
//  MaiDanSH
//
//  Created by lin on 16/11/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeTypeView : UIView

/** 收入金额 */
@property (nonatomic, copy) NSString *income;
/** 收入类型 */
@property (nonatomic, copy) NSString *incomeType;
/** 选中状态 */
@property (nonatomic, assign) BOOL selected;

@end
