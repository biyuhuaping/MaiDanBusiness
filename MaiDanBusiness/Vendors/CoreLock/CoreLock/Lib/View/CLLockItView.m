//
//  CLLockItView.m
//  DaJiaZhuanSH
//
//  Created by feng on 16/6/3.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "CLLockItView.h"

@implementation CLLockItView

//
///*
//*  外环：选中
//*/
//-(void)circleSelected:(CGContextRef)ctx rect:(CGRect)rect{
//    
//    //新建路径：外环
//    CGMutablePathRef circlePath = CGPathCreateMutable();
//    
////    //绘制一个圆形
////    CGPathAddEllipseInRect(circlePath, NULL, self.selectedRect);
////    
////    [CoreLockCircleLineSelectedCircleColor set];
//    
//    //将路径添加到上下文中
//    CGContextAddPath(ctx, circlePath);
//    
//    //绘制圆环
//    CGContextFillPath(ctx);
//    
//    //释放路径
//    CGPathRelease(circlePath);
//}
///*
// *  三角形：方向标识
// */
//-(void)directFlag:(CGContextRef)ctx rect:(CGRect)rect{
//    
//    if(self.direct == 0) return;
//
//    //新建路径：三角形
//    CGMutablePathRef trianglePathM = CGPathCreateMutable();
//    
//    CGFloat marginSelectedCirclev = 4.0f;
//    CGFloat w =8.0f;
//    CGFloat h =5.0f;
//    CGFloat topX = rect.origin.x + rect.size.width * .5f;
//    CGFloat topY = rect.origin.y + rect.size.height * .5f;
//    
//    CGPathMoveToPoint(trianglePathM, NULL, topX, topY);
//    
//    //添加左边点
//    CGFloat leftPointX = topX - w *.5f;
//    CGFloat leftPointY =topY + h;
//    CGPathAddLineToPoint(trianglePathM, NULL, leftPointX, leftPointY);
//    
//    //右边的点
//    CGFloat rightPointX = topX + w *.5f;
//    CGPathAddLineToPoint(trianglePathM, NULL, rightPointX, leftPointY);
//    
//    //将路径添加到上下文中
//    CGContextAddPath(ctx, trianglePathM);
//    
//    //绘制圆环
//    CGContextFillPath(ctx);
//    
//    //释放路径
//    CGPathRelease(trianglePathM);
//}
@end
