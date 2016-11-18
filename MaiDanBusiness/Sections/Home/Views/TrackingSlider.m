//
//  TrackingSlider.m
//  DaJiaZhuanSH
//
//  Created by feng on 16/6/14.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "TrackingSlider.h"

@implementation TrackingSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 23;
    rect.size.width = rect.size.width + 20 + 24;
    rect.origin.y = rect.origin.y + 25;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}
-(CGRect)trackRectForBounds:(CGRect)bounds
{
    bounds.origin.x=10;
    bounds.origin.y= 0;
    bounds.size.height= bounds.size.height/5;
    bounds.size.width= bounds.size.width-30;
    return bounds;
}
@end
