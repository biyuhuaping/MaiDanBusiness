//
//  UseDealVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "UseDealVC.h"
#import "DEMONavigationController.h"

@interface UseDealVC ()

@end

@implementation UseDealVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"使用协议";

    
    [self initUI];
}

- (void)initUI
{
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@businessh5/%@",G_SHARE_URL1,@"agreement.html"];
    
    NSURL *url = [NSURL URLWithString:strUrl];//创建URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
