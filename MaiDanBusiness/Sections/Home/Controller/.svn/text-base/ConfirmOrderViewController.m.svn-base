//
//  ConfirmOrderViewController.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "ConfirmOrderViewController.h"

@interface ConfirmOrderViewController ()
{
    UIButton *btn1;
}
@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    [self initUI];
}

- (void)initUI
{
    float fY = 64;
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, fY + 20, P_SCREEN_WIDTH - 30, 20)];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.font = [UIFont systemFontOfSize:14];
    lbl1.text = @"扫描出的订单号是";
    [self.view addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, fY + 40, P_SCREEN_WIDTH - 30, 20)];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.font = [UIFont systemFontOfSize:14];
    lbl2.text = _strOrderID;
    [self.view addSubview:lbl2];
    
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, fY + 60, P_SCREEN_WIDTH - 30, 20)];
    lbl3.textAlignment = NSTextAlignmentCenter;
    lbl3.font = [UIFont systemFontOfSize:14];
    lbl3.text = @"是否确认?";
    [self.view addSubview:lbl3];
    
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(30, fY + 100, P_SCREEN_WIDTH - 60, 45)];
    [btn1 addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"确   认" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    btn1 .layer.masksToBounds    = YES;
    btn1.layer.cornerRadius     = 5;
    btn1.backgroundColor = RGBCOLOR(234, 85, 20);
    [self.view addSubview:btn1];
}

- (void)confirmOrder
{
    btn1.userInteractionEnabled = NO;
    
    [self requestDataFromNet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  订单确认
 */
- (void)requestDataFromNet
{
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strShopID = [config objectForKey:G_SHOP_ID];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",G_SERVER_URL];
    strUrl = [strUrl stringByAppendingFormat:@"%@",@"Business-WebService/order/orderFinish"];
    
    
    strUrl = [strUrl stringByAppendingFormat:@"/%@",_strOrderID];
    strUrl = [strUrl stringByAppendingFormat:@"/%@",strShopID];

    
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@""]; //字符串去空
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: strUrl]];
    NSLog(@"%@",strUrl);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) //成功
     {
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         
         if ([dicData[@"json_res"] isEqualToString: @"json_ok"]) //通讯成功
         {
            [SVProgressHUD showSuccessWithStatus:@"订单确认成功！"];
            [self.navigationController popToRootViewControllerAnimated:YES];
         }
         else
         {
             NSString *strResult = [dicData objectForKey:@"json_error"];
             [SVProgressHUD showErrorWithStatus:strResult];
             btn1.userInteractionEnabled = YES;

         }

     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         btn1.userInteractionEnabled = YES;

         NSLog(@"Failure == %@", error);
     }];
    
    [operation start];
}




@end
