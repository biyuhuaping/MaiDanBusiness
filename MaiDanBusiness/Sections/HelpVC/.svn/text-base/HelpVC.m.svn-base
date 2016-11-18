//
//  HelpVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "HelpVC.h"
#import "DEMONavigationController.h"

@interface HelpVC ()

@end

@implementation HelpVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"使用说明";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

- (void)initUI
{
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@businessh5/%@",G_SHARE_URL1,@"shopFunction.html"];
    NSURL *url = [NSURL URLWithString:strUrl];//创建URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
