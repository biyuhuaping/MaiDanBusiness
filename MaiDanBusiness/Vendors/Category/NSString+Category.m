//
//  NSString+Category.m
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (void)alertShow {
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:self
                               delegate:nil
                      cancelButtonTitle:@"我知道了"
                      otherButtonTitles:nil] show];
}

- (BOOL)isNull {
    if ([self isEqualToString:@""] || !self.length) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isEmail {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if([emailTest evaluateWithObject:self] == YES){
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isPhoneNumber {
    
    //正则表达 ［］内表示单个数字，如：2［089］表示20 28 29，3［1-5］表示31，32，33，34，35.
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //@"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|45|81)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)) {
        
        return YES;
    } else {
        return NO;
    }
}

//身份证区域验证
- (BOOL)isAreaCode
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:self] == nil) {
        
        return NO;
    }
    return YES;
}

//运营商判断
- (NSString *)judgeOperator {
    
    NSString *operator;
    if ([self isEqualToString:@"133"] ||
        [self isEqualToString:@"153"] ||
        [self isEqualToString:@"189"] ||
        [self isEqualToString:@"180"] ||
        [self isEqualToString:@"181"] ||
        [self isEqualToString:@"177"] ) {
        
        operator = @"电信";
        
    } else if ([self isEqualToString:@"130"] ||
               [self isEqualToString:@"131"] ||
               [self isEqualToString:@"132"] ||
               [self isEqualToString:@"155"] ||
               [self isEqualToString:@"156"] ||
               [self isEqualToString:@"186"] ||
               [self isEqualToString:@"145"] ||
               [self isEqualToString:@"185"] ||
               [self isEqualToString:@"176"] ) {
        
        operator = @"联通";
        
    } else if ([self isEqualToString:@"134"] ||
               [self isEqualToString:@"135"] ||
               [self isEqualToString:@"136"] ||
               [self isEqualToString:@"137"] ||
               [self isEqualToString:@"138"] ||
               [self isEqualToString:@"139"] ||
               [self isEqualToString:@"150"] ||
               [self isEqualToString:@"151"] ||
               [self isEqualToString:@"152"] ||
               [self isEqualToString:@"157"] ||
               [self isEqualToString:@"158"] ||
               [self isEqualToString:@"159"] ||
               [self isEqualToString:@"182"] ||
               [self isEqualToString:@"187"] ||
               [self isEqualToString:@"188"] ||
               [self isEqualToString:@"147"] ||
               [self isEqualToString:@"183"] ||
               [self isEqualToString:@"184"] ||
               [self isEqualToString:@"178"] ) {
        
        operator = @"移动";
        
    }
    return operator;
}

- (NSString *)encryptionPhoneNumber {
    
    NSString *tempA = [self substringWithRange:NSMakeRange(0,3)];
    NSString *tempB = [self substringFromIndex:7];
    NSString *encryption = [NSString stringWithFormat:@"%@****%@",tempA,tempB];
    
    return encryption;
}

- (CGFloat)getStringHeightWithWidth:(CGFloat)width font:(NSInteger)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height+2;
}

- (CGFloat)getStringWidthWithHeight:(CGFloat)height font:(NSInteger)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+2;
}

- (NSString *)htmlString {
    NSString *strHTML = [NSString stringWithFormat:@"<html> \n"
                                                    "<head> \n"
                                                    "<style type=\"text/css\"> \n"
                                                    "body {font-size: %f; line-height: %f; "
                                                    "font-family: \"%@\"; color: %@;}\n"
                                                    "</style> \n"
                                                    "</head> \n"
                                                    "<body>%@</body> \n"
                                                    "</html>",
                                                    12.0, 1.5, @"Arial", @"#000000", self];
    return strHTML;
}

- (NSString *)removeHTMLLabel {
    
    NSArray *components = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        
        [componentsToKeep addObject:[components objectAtIndex:i]];
        
    }
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    return plainText; 
}

@end
