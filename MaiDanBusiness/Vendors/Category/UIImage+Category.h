//
//  UIImage+Category.h
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 *  @brief  根据颜色创建对应的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size;

@end
