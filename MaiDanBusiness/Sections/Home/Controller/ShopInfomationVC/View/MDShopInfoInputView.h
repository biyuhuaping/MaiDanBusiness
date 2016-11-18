//
//  MDShopInfoInputView.h
//  MaiDanBusiness
//
//  Created by lin on 16/11/17.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDShopInfoInputView : UIView

/** 输入框的文本 */
@property (nonatomic, copy) NSString *text;
/** 键盘类型 */
@property (nonatomic, assign) UIKeyboardType keyboardType;
/** 是否有开关 */
@property (nonatomic, assign) BOOL hasSwitch;
/* 开关状态 */
@property (nonatomic, assign) BOOL switchOn;

/**
 *  实例化方法
 *
 *  @param  title           标题
 *  @param  placeholder     提示语
 *  @param  required        是否必填
 */
+ (instancetype)shopInfoInputViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder required:(BOOL)required;

@end
