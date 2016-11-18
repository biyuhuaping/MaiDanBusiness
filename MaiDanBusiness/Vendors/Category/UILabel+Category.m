//
//  UILabel+Category.m
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (CGFloat)getHeightByAdjustText {
    
    CGSize size = CGSizeMake(self.width, MAXFLOAT);
    CGRect rect = [self.text boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName : self.font }
                                          context:nil];
    
    return rect.size.height+2;
}

- (CGFloat)xg_getLabelWidthByAdjustText {
    CGSize size = [self.text sizeWithAttributes:@{ NSFontAttributeName : self.font }];
    return size.width + 2;
}

- (CGFloat)xg_getStringHeightByAdjustText {
    CGSize size = [self.text sizeWithAttributes:@{ NSFontAttributeName : self.font }];
    return size.height + 2;
}

- (void)attributedTextWithText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor {
    
    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = [self.text rangeOfString:text];
    // 设置字体颜色
    [richText addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    // 设置字体大小
    [richText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    self.attributedText = richText;
}

@end
