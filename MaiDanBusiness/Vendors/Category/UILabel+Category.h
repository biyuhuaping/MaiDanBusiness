//
//  UILabel+Category.h
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

/**
 *  根据label文本返回label的高度
 */
- (CGFloat)getHeightByAdjustText;

/**
 *  根据label文本返回label的宽度
 */
- (CGFloat)xg_getLabelWidthByAdjustText;

/**
 *  根据label文本返回label的高度
 */
- (CGFloat)xg_getLabelHeightByAdjustText;

/**
 *  给Label添加富文本
 *
 *  @param text      需要添加属性的文本
 *  @param font      富文本的字体
 *  @param textColor 富文本的颜色
 */
- (void)attributedTextWithText:(NSString *)text
                          font:(CGFloat)font
                     textColor:(UIColor *)textColor;

@end
