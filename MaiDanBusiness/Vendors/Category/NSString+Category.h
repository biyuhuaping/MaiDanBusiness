//
//  NSString+Category.h
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)


/**
 *  @brief  根据文字弹出提示框
 */
- (void)alertShow;

/**
 *  @brief  判断字符串是否为空
 */
- (BOOL)isNull;

/**
 *  @brief 判断字符串是否是邮箱
 */
- (BOOL)isEmail;

/**
 *  @brief 判断字符串是否是手机号码
 */
- (BOOL)isPhoneNumber;

/**
 *  @brief 根据身份证前两位进行区域验证
 */
- (BOOL)isAreaCode;

/**
 *  @brief 根据手机号前三位判断运营商
 */
- (NSString *)judgeOperator;

/**
 *  @brief  返回一个html格式的string
 */
- (NSString *)htmlString;

/**
 *  @brief  给手机号加密
 */
- (NSString *)encryptionPhoneNumber;

/**
 *  @brief  过滤字符串中的html标签
 */
- (NSString *)removeHTMLLabel;

/**
 *  @brief  获取当前文本的高度
 *
 *  @param  width : 文本的最大宽度
 *  @param  font  : 文本的字体大小
 */
- (CGFloat)getStringHeightWithWidth:(CGFloat)width font:(NSInteger)font;

/**
 *  @brief  获取当前文本的宽度
 *
 *  @param  height: 文本的最大高度
 *  @param  font  : 文本的字体大小
 */
- (CGFloat)getStringWidthWithHeight:(CGFloat)height font:(NSInteger)font;

@end
