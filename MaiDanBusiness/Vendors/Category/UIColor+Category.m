//
//  UIColor+Category.m
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)colorWithHexStr:(NSString *)hex {
    
    NSRange range;
    range.location = 0;
    range.length = 1;
    NSString *first = [hex substringWithRange:range];
    if ([first isEqualToString:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    range.length = 2;
    NSString *rStr = [hex substringWithRange:range];
    range.location = 2;
    NSString *gStr = [hex substringWithRange:range];
    range.location = 4;
    NSString *bStr = [hex substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)r/255
                           green:(float)g/255
                            blue:(float)b/255
                           alpha:1];
}

+ (UIColor *)randomColor {
    
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.3f];
}

@end
