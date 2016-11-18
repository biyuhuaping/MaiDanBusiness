//
//  ScanViewController.m
//  IphoneScanTest
//
//  Created by wangyangyang on 14/8/21.
//  Copyright (c) 2014年 wangyangyang. All rights reserved.
//

#import "ScanViewController.h"
#import "MnualViewController.h"
#import "ConfirmOrderViewController.h"
@interface ScanViewController ()
{
    UITextField *_txt;
    UIButton *btn1;
    
}
@property (nonatomic,strong)UIImageView *imagV;

@end

@implementation ScanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"订单扫描";

    self.view.backgroundColor = RGBCOLOR(251, 250, 248);

    NSLog(@"view的原点：%f",self.view.frame.origin.y);
    
    scanBarCodeView = [[ScanBarCodeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scanBarCodeView.scanDelegate = self;

    surfaceView = [[ScanSurfaceView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

    [scanBarCodeView setScanRect:surfaceView.scanRect];
    [scanBarCodeView addSubview:surfaceView];
    
    [scanBarCodeView addSubview:surfaceView];
    [self.view addSubview:scanBarCodeView];
    //添加UIImageV
    self.imagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (surfaceView.frame.size.width*16.0/16.0) + 100, 73, 61)];
    self.imagV.centerX =surfaceView.centerX;
    _imagV.image = [UIImage imageNamed:@"manual"];
    _imagV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_imagV addGestureRecognizer:tap];
    
    [surfaceView addSubview:_imagV];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    //手动订单走起
    MnualViewController *controller = [[MnualViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)selfBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [scanBarCodeView scanStart];
    [surfaceView startBaseLineAnimation];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming64"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [scanBarCodeView scanStop];
    [surfaceView stopBaseLineAnimation];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scanCompleteCallBack:(NSString *)stringValue
{
    NSLog(@"扫描值是：%@",stringValue);
//    [self selfBack:nil];
    
    ConfirmOrderViewController *controller = [[ConfirmOrderViewController alloc] init];
    controller.strOrderID = stringValue;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)confirmOrder
{
    
    
    if (_txt.text.length == 0 || _txt.text == nil)
    {
        [SVProgressHUD showSuccessWithStatus:@"订单号不能为空！"];

    }
    else{
        btn1.userInteractionEnabled = NO;
        //订单确认
        [[API shareAPI] getOrderconf:_txt.text completion:^(id responseData) {
            if ([responseData[@"json_res"] isEqualToString: @"json_ok"]) //通讯成功
            {
                [SVProgressHUD showSuccessWithStatus:@"订单确认成功！"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                btn1.userInteractionEnabled = YES;
                NSString *strResult = [responseData objectForKey:@"json_error"];
                [SVProgressHUD showErrorWithStatus:strResult];
            }
 
        }];
    }
}



/**
 *  当用户按下return键或者按回车键，keyboard消失
 *
 *  @return
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


/**
 *  回收键盘，在ViewDidLoad中调用
 */
- (void)tapBackground
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce)];//定义一个手势
    [tap setNumberOfTouchesRequired:1];//触击次数这里设为1
    [self.inputView addGestureRecognizer:tap];//添加手势到View中
}


/**
 *  手势方法
 */
- (void)tapOnce
{
    [_txt resignFirstResponder];
}


@end
