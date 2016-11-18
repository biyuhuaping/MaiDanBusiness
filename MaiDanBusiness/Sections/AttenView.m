//
//  AttenView.m
//  DaJiaZhuan
//
//  Created by feng on 16/1/25.
//  Copyright © 2016年 Bibo. All rights reserved.
//

#import "AttenView.h"

@implementation AttenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showWithtitle:(NSString *)title1 Content:(NSString *)content1{
    [self createBackgroundView];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(80, 180, self.bounds.size.width-160, self.bounds.size.height-420)];
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];

    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bounced_bg"]];
    image.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-50);
    [view addSubview:image];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 8, view.bounds.size.width, 44)];
    title.text=title1;
    title.textAlignment=NSTextAlignmentCenter;
    [view addSubview:title];
    
    UILabel *content=[[UILabel alloc]initWithFrame:CGRectMake(10, title.frame.origin.y+title.frame.size.height, view.frame.size.width-20, view.frame.size.height-120)];
    content.text=content1;
    content.lineBreakMode = NSLineBreakByWordWrapping;
    content.numberOfLines=0;
    [view addSubview:content];
    
    UIButton *know=[[UIButton alloc]initWithFrame:CGRectMake(0, image.frame.origin.y+image.frame.size.height, view.frame.size.width, 44)];
    [know setTitle:@"“我知道了”" forState:UIControlStateNormal];
    [know setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    know.backgroundColor=[UIColor redColor];
    [know addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:know];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled=YES;
    button.frame=CGRectMake(view.frame.size.width-27-20, 20, 20, 20);
//    button.backgroundColor=[UIColor whiteColor];
    [button setImage:[UIImage imageNamed:@"bounced_close"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bounced_close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    if (iPhone5) {
        view.frame=CGRectMake(40, 100, self.bounds.size.width-80, self.bounds.size.height-300);
        image.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-50);
        title.frame=CGRectMake(0, 8, view.bounds.size.width, 44);
        content.frame=CGRectMake(10, title.frame.origin.y+title.frame.size.height, view.frame.size.width-20, view.frame.size.height-120);
        know.frame=CGRectMake(0, view.frame.origin.y+view.frame.size.height-140, view.frame.size.width, 44);
        button.frame=CGRectMake(view.frame.size.width-22-5, 20, 15, 15);
    }else if (iPhone4){
        view.frame=CGRectMake(40, 80, self.bounds.size.width-80, self.bounds.size.height-230);
        image.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-50);
        title.frame=CGRectMake(0, 8, view.bounds.size.width, 44);
        content.frame=CGRectMake(10, title.frame.origin.y+title.frame.size.height, view.frame.size.width-20, view.frame.size.height-120);
        know.frame=CGRectMake(0, view.frame.origin.y+view.frame.size.height-120, view.frame.size.width, 44);
        button.frame=CGRectMake(view.frame.size.width-22-5, 20, 15, 15);
    
    }
}
-(void)btn{
    
    [UIView animateWithDuration:0.3 animations:^{
//        self.alertBg.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.alpha = 0.3;
    } completion:^(BOOL finished){
        // table alert not shown anymore
        [self removeFromSuperview];
    }];

}
-(void)createBackgroundView
{
    // reset cellSelected value
    
    // adding some styles to background view (behind table alert)
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.opaque = NO;
    
    // adding it as subview of app's UIWindow
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self];
    
    // get background color darker
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}
@end
