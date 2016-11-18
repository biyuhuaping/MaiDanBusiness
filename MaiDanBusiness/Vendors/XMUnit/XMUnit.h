//
//  XMUnit.h
//  DaJiaZhuan
//
//  Created by Bibo on 15/1/15.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XMUnit : NSObject

/**
 * UITextField实现左侧空出一定的边距
 */
+ (UITextField *)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;

/**
 *  Unicode转成汉字
 *
 *  @param aUnicodeString
 *
 *  @return 汉字
 */
+ (NSString*)replaceUnicode:(NSString*)aUnicodeString;

/**
 *  获取验证码
 *
 *  @return 验证码
 */
+ (NSString *)getVerifCode;

/**
 *  计算文本高度
 *
 *  @param value    文本内容
 *  @param fontSize 字体大小
 *  @param width    文本框宽度
 *
 *  @return 高度
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

/**
 *  获取当前版本号
 *
 *  @return 版本号
 */
+ (NSString *)getCurrentVersion;

/**
 *  获取城市ID
 *
 *  @param strRegionID 地区ID
 */
+ (NSString *)getCityID:(NSString *)strRegionID;

/**
 *  过滤html标签
 *
 *  @param html
 *
 *  @return
 */
+ (NSString *)removeHTML:(NSString *)html;

@end
