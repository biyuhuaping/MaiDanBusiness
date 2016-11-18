//
//  GlobalVariable.h
//  DaJiaZhuan
//
//  Created by Bibo on 15/1/22.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#ifndef DaJiaZhuan_GlobalVariable_h
#define DaJiaZhuan_GlobalVariable_h

//调试 代码的宏
#ifdef DEBUG
/**
 *  测试服务器地址
 */
#define G_SERVER_URL  @"http://bizapi.91maidan.com/"
//#define G_SERVER_URL  @"http://192.168.11.42:8082/" //测试
//#define G_SERVER_URL  @"http://192.168.11.21:8083/" //罗青本地测试

#define NSLog(...) NSLog(__VA_ARGS__)
#else

#define G_SERVER_URL  @"http://bizapi.91maidan.com/"

#define NSLog(...)

#endif


//#define G_SHARE_URL  @"http://web.91maidan.com/www/#/tabs"//分享连接
#define G_SHARE_URL  @"http://web.91maidan.com/businessh5/businessShare.html?id="

#define G_SHARE_URL1  @"http://web.91maidan.com/"//网页


#define G_IS_LOGIN  @"gIsLogin"
#define G_YES       @"gYes"
#define G_NO        @"gNo"
#define G_TIME        @"TIME"
#define G_IS_GESTURES  @"gIsGestures"

/**
 *  商家ID
 */
#define G_SHOP_ID   @"gShopID"

// 字体
#define FONT_WITH_SIZE(s)   [UIFont systemFontOfSize:s]

// 主题颜色
#define kThemeColor  RGBCOLOR(251, 89, 40)
// 背景色
#define kBackgroundColor RGBCOLOR(244, 244, 244)
// 突出文本色(color7)
#define kTextColor1  RGBCOLOR(51, 51, 51)
// 文本色
#define kTextColor2  RGBCOLOR(102, 102, 102)
// 标注文本色
#define kTextColor3  RGBCOLOR(153, 153, 153)
// 最弱文本色
#define kTextColor4  RGBCOLOR(238, 238, 238)
// 描边色
#define kTextColor5  RGBCOLOR(221, 221, 221)
// 白色
#define kWhiteColor [UIColor whiteColor]

//调试 代码的宏
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]



#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)



/**
 *  屏幕宽
 */
#define P_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  屏幕高
 */
#define P_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  判断是否为IOS7的系统
 */
#define IOS7 (([UIDevice currentDevice].systemVersion.intValue) >= 7)

/**
 *  IOS 7导航条高度
 */
#define P_NAVBAR_7_HEIGHT   64

/**
 *  IOS 6导航条高度
 */
#define P_NAVBAR_6_HEIGHT   44

/**
 *  导航条状态栏高度
 */
#define P_STATUSBAR_HEIGHT  20

/**
 *  操作员ID
 */
#define G_WORKER_ID   @"gWorkerID"

/**
 *  操作员密码
 */
#define G_WORKER_PWD   @"gWorkerPwd"

/**
 *  设备码
 */
#define G_DEVICE_ID @"gDeviceID"


/**
 *  头像
 */
#define G_HeadUrl  @"gHeadUrlID"

/**
 *  商家名
 */
#define G_SHOP_NAME @"gShopName"

/**
 *
 */
#define G_Qrcode  @"gQrcodeID"


/**
 *  接口数据
 */
//#define API_Login @"API/shopinterface.aspx?op=Login"
#define API_Login   @"Business-WebService/login/logincs"//测试登录 //登录

//#define API_Invitation  @"Shop/api/seller/onecustconns/"//我的邀请
#define API_ALLOrderlist    @"Business-WebService/order/getShopAllOrder"   //全部列表
#define API_confirmOrder    @"Business-WebService/order/getShopConfirmOrder"       //确认订单列表
#define API_NewOrderList    @"Business-WebService/order/getShopNewOrder"   //未确认订单列表
#define API_DOrderlist      @"Business-WebService/order/deleteNewOrderByOrderId/"       //删除订单
#define API_ScoreList       @"Business-WebService/freescore/list"   //积分管理
#define API_CONSUPTION      @"Business-WebService/seller/consumerList"   //消费
#define API_Focuson         @"Business-WebService/seller/followList"    //关注列表
#define API_MyInvite        @"Business-WebService/seller/oneCustConns"  //邀请
#define API_AddRemit        @"Business-WebService/freescore/preRecharge"    //支付宝充值
#define API_Check           @"Business-WebService/shopMore/checkVersion"//版本更新
#define API_CHANGE          @"Business-WebService/seller/shareChangeBusiness"  //收益转换
#define API_CommercialPic   @"Business-WebService/seller/getShopImg"  //获取商户的三个证件照片
#define API_SavePic         @"Business-WebService/seller/saveShopImg"  //保存商户的三个证件照片
#define API_UploadImage     @"Business-WebService/seller/uploadShopImg"  //上传照片
#define API_DeleteImage     @"Business-WebService/seller/deleteThum"  // 删除图片
#define API_ShopInfo        @"Business-WebService/seller/getShopInfo"// 获取商户信息
#define API_UpdateShopInfo  @"Business-WebService/seller/saveShopBaseInfo" //修改商户信息
#define API_ShopType        @"Business-WebService/seller/getShopType" //获取商户类别
#define API_RechargeRecord  @"Business-WebService/financial/rechargeList" //充值记录
#define API_WithdrawRecord  @"Business-WebService/financial/withdrawalList" //提现记录
#define API_WithdrawInfo    @"Business-WebService/financial/applyWithdrawal" //提现账户信息
#define API_WithdrawTax     @"Business-WebService/financial/getshareScoreWithTax" //获取分享币提现扣税
#define API_SubmitWithdraw  @"Business-WebService/financial/submitWithdrawal" //申请提现
#define API_BindingCard     @"Business-WebService/financial/bindingBankCards" //绑定银行卡
#define API_AllProvince     @"Client-WebService/index/allProvince" //获取所有省份
#define API_AllCity         @"Client-WebService/index/city" //获取省份对应的城市
#define API_AllRegion       @"Client-WebService/index/region" //获取城市对应的区域
#define API_FeedBack        @"Business-WebService/seller/saveFeedback" //意见反馈


/**
 *  屏幕宽
 */
#define G_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  屏幕高
 */
#define G_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


/**
 *  屏幕高
 */
#define G_SCREEN_PROP [UIScreen mainScreen].bounds.size.height/667


/**
 *  充值成功
 */
#define G_FULLFILL_SUCCESS @"gFullFillSuccess"

/**
 *  微博：应用回调页
 */
#define kWbRedirectURI @"https://api.weibo.com/oauth2/default.html"
/**
 *  友盟key
 */
#define UmengAppkey @"582aadac07fe6502d9000732"

/**
 *  微信key
 */
#define G_WX_KEY @"wx5297bfa7848156b2"


#define APP_SECRET      @"c25b857e14a3790b23287f035177fc89"

/**
 *  微博key
 */
#define G_WB_KEY @"773561501"


/**
 *  回调地址
 */

#define G_Notify_Url  @"http://bizapi.91maidan.com/Business-WebService/alipayServlet"//新版支付宝充值回调接口

/**
 *  合作身份者id
 */
#define G_PartnerID @"2088221310048465"


/**
 *  收款支付宝账号
 */
#define G_SellerID @"2088221310048465"

/**
 *  安全校验码
 */
#define G_MD5_KEY @"o0ekd21bbsw32qtgatce8tq4ap97a07i"

/**
 *  公钥：
 */
#define G_AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"


/**
 *  私钥：
 */

#define  G_PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANO/3c/8KOXfla4dSAzejd4NbSazyLAnQXjRdQIViw9eJ5A0dxSP6Hs7GgGin1h9mGKk5ZQlqvZ8pDrOODKjwM9w2S/auuuua4DDpHnbzRLtVLMgKttRIFw4TNuInJxL+V4e1vEtOxfZLKrAib144EmDxyayZvlTlk4JBKbwC0jVAgMBAAECgYB+SwFQ+2SpNiFgJ7bBdjvHJNrlKnWYGtHB7auMAq1eDRoruB8N9IcEeMuaDhRcAwzQSOlk4tKFEPIi4LxD98cW3HDHQgKBYI1TRVa5AUZJUPALAA66jSRaQbK1RSwWaM6xU+l649VxGzjsNV+cVE1UfBXF1MMsksGI3S2rqRKGQQJBAPT0ovlCrU8JBWknVMn/1+V5YUm828/TrdANy7j/a640DHmbXl7nmoA+UNt969GFnhUyyiNAanxOXBfWQDHSqCsCQQDdS/P5nLAnVLq7xcZJqLHQd3twMk20cZ+XoYSZbdqoN14z/VYmjnQfIGRHriBTJStsNP2n7TrC3Ap4oYG8CFL/AkEAuJ1b6wK+va9t3YegFrH1FGT71ug4vpSqDgEnxmDy1hMyR8C6SkrBnd/ZbuOjhIDw2Mczo4fb+Z3ROMHoFeTPiwJAIjj3vvdbSonQ4u7/7i43aWzA2yX8XFZh/toMnomdkfwWBmY8J3RKQvIIcAlemF0cLPy46XpHZxEOUX9wh7ql0wJAKVKU8hsLp8v7lxMkEuheNZCBPOB/ZIzoiInaDAgz1r67pFUa04BOm3Wt4GB61O7SZmmXVlAPE+8V76Qtk7Wv/g=="
#endif


