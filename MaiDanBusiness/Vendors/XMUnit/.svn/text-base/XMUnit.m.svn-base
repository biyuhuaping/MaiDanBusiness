//
//  XMUnit.m
//  DaJiaZhuan
//
//  Created by Bibo on 15/1/15.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "XMUnit.h"

@implementation XMUnit

/**
 * UITextField实现左侧空出一定的边距
 */
+ (UITextField *)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
    
    return textField;
}

/**
 *  Unicode转成汉字
 *
 *  @param aUnicodeString
 *
 *  @return 汉字
 */
+ (NSString*)replaceUnicode:(NSString*)aUnicodeString
{
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

/**
 *  获取验证码
 *
 *  @return 验证码
 */
+ (NSString *)getVerifCode
{
    NSString *strCode = [NSString stringWithFormat:@"%d%d%d%d",arc4random()%5 ,arc4random()%5,arc4random()%5,arc4random()%5];
    return strCode;
}

/**
 *  计算文本高度
 *
 *  @param value    文本内容
 *  @param fontSize 字体大小
 *  @param width    文本框宽度
 *
 *  @return 高度
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}

/**
 *  获取当前版本号
 *
 *  @return 版本号
 */
+ (NSString *)getCurrentVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    return appVersion;
}


/**
 *  获取城市ID
 *
 *  @param strRegionID 地区IDparentid
 */
+ (NSString *)getCityID:(NSString *)strRegionID
{
    NSString *strCityPath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"plist"]; ;
    NSMutableArray *mutarrCity = [[NSMutableArray alloc] initWithContentsOfFile:strCityPath];
    
    NSString *strCityID;
    
    for (int i = 0; i < mutarrCity.count; i++)
    {
        NSDictionary *dicItem = mutarrCity[i];
        if ([[dicItem objectForKey:@"regionid"] isEqualToString:strRegionID])
        {
            strCityID = [dicItem objectForKey:@"parentid"];
            
            return strCityID;
        }
    }
    
    return strCityID;
}

/**
 *  过滤html标签
 *
 *  @param html
 *
 *  @return
 */
+ (NSString *)removeHTML:(NSString *)html
{
    html = [html stringByReplacingOccurrencesOfString:@"<(.[^>]*)>" withString:@""];
    //html = [html stringByReplacingOccurrencesOfString:@"([\r\n])[\\s]+" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@"\\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@"\\n"];
    
    return html;
}



@end
