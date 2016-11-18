//
//  FulfillCardVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/2/1.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "FulfillCardVC.h"//充值页面
#import "aliOrder.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "SHTableView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "payRequsestHandler.h"

#import "WXApi.h"
#import "WXApiObject.h"
#define TAG_TXT_COUNT 0x001
#define TAG_BUTTON_FULLFILL 0x002
#define TAG_CELL_IMAGEV 1111

@interface FulfillCardVC ()

{
    UITextField *_txt1;
    NSString *_strOrderNo;
    UIButton *btnTake;
}
@property (nonatomic, strong) SHTableView *tableView;
@property (nonatomic, strong) NSString *paytype;//3 支付宝 4 是微信


@end

@implementation FulfillCardVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //监听充值状态
    _paytype = @"4";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToHomePage) name:G_FULLFILL_SUCCESS object:nil];
    
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"充值";
//    [self initPayWay];
    _iPayWay = 1;
    [self addTableView];
//    [self tapBackground];
    
}
- (void)addTableView{
    
    self.tableView = [[SHTableView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, G_SCREEN_HEIGHT) andCompletionBlock:^NSInteger{
        return 1;
        
    } numberOfRows:^NSInteger(NSInteger section) {
        return 7;
    } andCells:^UITableViewCell *(SHTableView *tableView, NSIndexPath *indexPath) {
        
        NSString *CellIdentifier1 = @"CellIdentifier1";
        NSString *CellIdentifier2 = @"CellIdentifier2";
        NSString *CellIdentifier3 = @"CellIdentifier3";
        NSString *CellIdentifier4 = @"CellIdentifier4";
        UITableViewCell *cell;
        if ( indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5){
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.backgroundColor = RGBCOLOR(245, 245, 245);
                cell.textLabel.textColor = RGBCOLOR(51, 51, 51);
                [self tapBackground:cell];
                
            }
            if (indexPath.row == 0) {
                cell.textLabel.text = @"请输入充值金额";
                
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"请选择支付方式";
                
            }else{
                cell.textLabel.text = @"";
                
            }
            
        }
        else if (indexPath.section == 0 && indexPath.row == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
                
                cell.backgroundColor = RGBCOLOR(245, 245, 245);
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                //视图1
                UIView *view1 = [self createViewWithFrame:CGRectMake(15, 0 , G_SCREEN_WIDTH - 30, 35) image:@"icon_jifenshu"];
                view1.backgroundColor = [UIColor whiteColor];
                [cell addSubview:view1];
                //
                //充值金额
                _txt1 = [[UITextField alloc] initWithFrame:CGRectMake(30, 7.5, 200, 20)];
                _txt1.tag = TAG_TXT_COUNT;
                _txt1.keyboardType = UIKeyboardTypeNumberPad;
                _txt1.placeholder = @"请输入充值金额，单位是元";
                _txt1.font = [UIFont systemFontOfSize:14];
                [view1 addSubview:_txt1];
                
                
            }
        }
        
        else if(indexPath.section == 0 && indexPath.row == 6){
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                btnTake = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, G_SCREEN_WIDTH - 30,40)];
                btnTake.tag = TAG_BUTTON_FULLFILL;
                [btnTake addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
                [btnTake setTitle:@"充  值" forState:UIControlStateNormal];
                [btnTake setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btnTake.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                btnTake .layer.masksToBounds    = YES;
                btnTake.layer.cornerRadius     = 5;
                btnTake.backgroundColor = RGBCOLOR(234, 85, 20);
                [cell addSubview:btnTake];
            }
        }
        else if (indexPath.section == 0 && indexPath.row > 2){
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = RGBCOLOR(51, 51, 51);
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH - 40, 7.5, 18, 18)];
                imgView1.tag = TAG_CELL_IMAGEV;
                imgView1.image = [UIImage imageNamed:@"btn_zhifu_selected"];
                [cell addSubview:imgView1];
            }
            
            UIImageView *imgV = (UIImageView *)[cell viewWithTag:TAG_CELL_IMAGEV];
            
            if (indexPath.row == 4) {
                cell.imageView.image = [UIImage imageNamed:@"icon_zhifu_zhifubao"];
                cell.textLabel.text = @"支付宝支付";
                if ([_paytype intValue] == 3) {
                    imgV.image = [UIImage imageNamed:@"btn_zhifu_selected"];
                }else{
                    imgV.image = [UIImage imageNamed:@"btn_zhifu_unselected"];
                }
            }else{
                cell.imageView.image = [UIImage imageNamed:@"icon_zhifu_weixin"];
                cell.textLabel.text = @"微信支付";
                if ([_paytype intValue] == 4) {
                    imgV.image = [UIImage imageNamed:@"btn_zhifu_selected"];
                }else{
                    imgV.image = [UIImage imageNamed:@"btn_zhifu_unselected"];
                }
            }
        }
        
        return cell;
    }];
    [_tableView configureSelectionBlock:^(NSIndexPath *selectedIndex) {
        
        if (selectedIndex.section == 0 && selectedIndex.row == 3) //选中微信支付
        {
            _paytype = @"4";
            
            [_tableView reloadData];
            
        }
        else if (selectedIndex.section == 0 && selectedIndex.row == 4) //选中支付宝支付
        {
            _paytype = @"3";
            [_tableView reloadData];
            
        }
    }];
    _tableView.backgroundColor = RGBCOLOR(245, 245, 245);
    _tableView.cellHeight = 40;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 0.0001;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark alipay method


- (void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == TAG_BUTTON_FULLFILL) //充值
    {
        if (_txt1.text.length == 0 || _txt1.text == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入金额" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else
        {
            [SVProgressHUD show];
            [self requestFullFill];

        }
    }

}

/**
 *  自定义视图
 *
 *  @param frame       视图大小
 *  @param image       图片
 *  @param placeholder 默认字体
 *
 *  @return view
 */
- (UIView *)createViewWithFrame:(CGRect)frame image:(NSString *)image
{
    //视图
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.borderWidth  = 1;
    view.layer.cornerRadius = 3;
    view.layer.borderColor  = RGBCOLOR(221, 221, 221).CGColor;
    
    //图标
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7.5, 20, 20)];
    imgView.image = [UIImage imageNamed:image];
    [view addSubview:imgView];
    
    return view;
}
- (void)requestFullFill{
  
    [[API shareAPI] getAPI:API_AddRemit money:_txt1.text payType:_paytype completion:^(id responseData) {
        if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
            _strOrderNo =responseData[@"json_val"];
            if ([_paytype intValue] == 3) {
                [self generateOrder:_strOrderNo];
            }else{
                [self sendPay];
            }
            
        } else
        {
            
        }
        
        [SVProgressHUD dismiss];
    }];
    
}
//支付宝
-(void)generateOrder:(NSString *)strOrderNo
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    aliOrder *order = [[aliOrder alloc] init];
    order.partner = G_PartnerID;
    order.seller = G_SellerID;
    order.tradeNO = strOrderNo; //订单ID（由商家自行制定）
    order.productName = @"脉单消费"; //商品标题
    order.productDescription = @"1"; //商品描述
    //    order.amount = _strFee; //商品价格
    
    order.amount = [NSString stringWithFormat:@"%.2f",[_txt1.text floatValue]]; //商品价格
    order.notifyURL =  G_Notify_Url; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.MaiDan.Shop";
    
    NSUserDefaults *setting = [[NSUserDefaults alloc]init];
    [setting removeObjectForKey:@"AliFrom"];
    [setting setObject:@"3" forKey:@"AliFrom"];
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(G_PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            if([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"])//支付成功
            {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                NSLog(@"支付成功！");
                btnTake.userInteractionEnabled = YES;
            }
            else
            {
                btnTake.userInteractionEnabled = YES;

                [SVProgressHUD showErrorWithStatus:@"支付不成功"];
                NSLog(@"支付不成功");
            }
            
        }];
        
    }
}
//微信
- (void)sendPay
{
    payRequsestHandler *payRequest = [[payRequsestHandler alloc]init:APP_ID mch_id:MCH_ID];
    //    [[payRequsestHandler alloc]init:APP_ID mch_id:MCH_ID];
    
    NSString *ORDER_NAME    = @"脉单消费";
    //订单金额，单位（分）
    //    NSString *ORDER_PRICE   = @"1";
    
    NSString *ORDER_PRICE = [NSString stringWithFormat:@"%.0f",[_txt1.text floatValue]*100];
    
    //================================
    //预付单参数订单设置
    //================================
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    
    [packageParams setObject: APP_ID             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: MCH_ID             forKey:@"mch_id"];      //商户号
    //       [packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: ORDER_NAME        forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: NOTIFY_URL        forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: _strOrderNo       forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: @"192.168.1.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: ORDER_PRICE       forKey:@"total_fee"];       //订单金额，单位为分
    
        
    NSString *prePayid;
    prePayid            = [payRequest sendPrepay:packageParams];
    
    if ( prePayid != nil) {
        //获取到prepayid后进行第二次签名
        
        NSString    *package, *time_stamp, *nonce_str;
        //设置支付参数
        time_t now;
        time(&now);
        time_stamp  = [NSString stringWithFormat:@"%ld", now];
        nonce_str	= [WXUtil md5:time_stamp];
        //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
        //package       = [NSString stringWithFormat:@"Sign=%@",package];
        package         = @"Sign=WXPay";
        //第二次签名参数列表
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: APP_ID        forKey:@"appid"];
        [signParams setObject: noncestr    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: MCH_ID        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prePayid     forKey:@"prepayid"];
        //生成签名
        NSString *sign  = [payRequest createMd5Sign:signParams];
        
        //添加签名
        [signParams setObject: sign         forKey:@"sign"];
        
        //           [debugInfo appendFormat:@"第二步签名成功，sign＝%@\n",sign];
        
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = APP_ID;
        req.partnerId           = PARTNER_ID;
        req.prepayId            = prePayid;
        req.nonceStr            = noncestr;
        req.timeStamp           = time_stamp.intValue;
        req.package             = package;
        req.sign                = sign;
        [WXApi sendReq:req];
        
        
        
    }
}

- (void)backToHomePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  关闭键盘，在ViewDidLoad中调用
 */
- (void)tapBackground:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce)];//定义一个手势
    [tap setNumberOfTouchesRequired:1];//触击次数这里设为1
    [cell addGestureRecognizer:tap];//添加手势到View中
}
/**
 *  手势方法
 */
- (void)tapOnce
{
    [_txt1 resignFirstResponder];
}
@end
