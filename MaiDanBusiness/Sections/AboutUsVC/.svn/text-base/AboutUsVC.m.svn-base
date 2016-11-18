//
//  AboutUsVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "AboutUsVC.h"
#import "DEMONavigationController.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    
    [self initUI];
}

- (void)initUI
{
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@businessh5/%@",G_SHARE_URL1,@"aboutUS.html"];

    NSLog(@"%@",strUrl);

    NSURL *url = [NSURL URLWithString:strUrl];//创建URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
