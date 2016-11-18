//
//  HomeViewController.m
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/8.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "HomeViewController.h"
#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"
#import "HomeTableViewCell1.h"
#import "LoginViewController.h"
#import "FinancialManagerViewController.h"
#import "ImageManagerViewController.h"
#import "ShopInfomationViewController.h"
#import "MDShopInfoViewController.h"
#import "FeedBackViewController.h"

#import "HomeMessage.h"
#import "FooterCollectionViewCell.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AttenView.h"
#import "WXApi.h"
#import "InputCodeViewController.h"//订单输入确认
#import "IntegralManageViewController.h"//订单管理
#import "MyInviteVC.h"
#import "AttentionUserVC.h"
#import "ScanViewController.h" //订单扫描确认
#import "CLLockVC.h"
#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "HeaderView.h"



#import "UMSocial.h"

@interface HomeViewController () <UIAlertViewDelegate,UMSocialUIDelegate>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) int cellHegit;
@property (nonatomic, strong) NSString *strMemo;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecongnizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecongnizer;
@property (nonatomic, strong) UIWindow *myWindow;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIImageView *imageView;
@property (strong, nonatomic) DEMOMenuViewController *menuController;

@end

static BOOL Check = NO;
@implementation HomeViewController
@synthesize window,imageView;

- (void)viewWillAppear:(BOOL)animated{
    NSString *strIsLogin = [[API shareAPI] getLocalData:G_IS_LOGIN];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming64"] forBarMetrics:UIBarMetricsDefault];
    _strMemo = @"大家赶紧一起来注册吧！";
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    //数据请求
    if ([strIsLogin isEqualToString:G_YES]) //登录
    {
        [self requestDataFromNet];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *strIsLogin = [[API shareAPI] getLocalData:G_IS_LOGIN];
    
    // Do any additional setup after loading the view.
    
    window = [UIApplication sharedApplication].keyWindow;
    _myWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _myWindow.backgroundColor = [UIColor whiteColor];
    
    self.menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    self.menuController.viewVC = self;
    _menuController.view.frame = CGRectMake(-223, 0, 223, G_SCREEN_HEIGHT );
    [_myWindow addSubview:_menuController.view];
    
    
    //投影
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_yingyin"]];
    imageView.frame = CGRectMake(0, 0, 10, G_SCREEN_HEIGHT + 64);
    imageView.alpha = 0;
    [window addSubview:imageView];
    
    // Create frosted view controller
    //手势滑动
    self.leftSwipeGestureRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecongnizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecongnizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecongnizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecongnizer];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_caidan"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主页";
    
    //    self.titleArray = @[@"订单扫描",@"订单管理",@"积分管理",@"我的邀请",@"分享",@"关注用户"];
    //    self.imageArray = @[@"icon_saomiao",@"icon_guanli",@"icon_jifen",@"icon_yaoqing",@"icon_fenxiang",@"icon_guanzhu"];
    self.titleArray = @[@"订单扫描",@"订单管理",@"积分管理",@"财务管理",@"商户信息",@"图片管理",@"我的邀请",@"关注用户",@"意见反馈"];
    self.imageArray = @[@"icon_saomiao",@"icon_guanli",@"icon_jifen",@"icon_caiwuguanli",@"icon_commertial_info",@"icon_image_manager",@"icon_yaoqing",@"icon_guanzhu",@"icon_feedback"];
    
    if ([strIsLogin isEqualToString:G_YES] ) {
        //登录
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
        temporaryBarButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
        if (!_enter) {
            _enter = YES;
            __weak HomeViewController *weakSelf = self;
            BOOL hasPwd = [CLLockVC hasPwd];
            //判断是否已经存在密码
            if (hasPwd) {
                [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
                    [[API shareAPI] saveLocalData:G_IS_LOGIN value:G_NO];
                    [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_YES];
                    weakSelf .enter = YES;
                    NSLog(@"忘记密码");
                    
                } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                    NSLog(@"密码正确");
                    weakSelf .enter = YES;
                    lockVC.vc=self;
                    [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_NO];
                    Check = YES;
                    
                }];
            }else{
                [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                    NSLog(@"密码设置成功");
                    [[API shareAPI] saveLocalData:G_IS_GESTURES value:G_NO];
                    Check = YES;
                }];
            }
        }
        
    }
    else if ([strIsLogin isEqualToString:G_NO] ) //未登录
    {
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
        temporaryBarButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
        _enter = NO;
        LoginViewController *controller = [[LoginViewController alloc] init];
        controller.homeVC = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
    [self initUI];
    
    
}
- (void)initUI{
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _cellHegit = 240;
    flowLayout.itemSize = CGSizeMake( (self.view.frame.size.width - 2) / 3, (self.view.frame.size.height - _cellHegit *G_SCREEN_PROP - 64) / 3 );
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, G_SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    self.myCollectionView.backgroundColor = RGBCOLOR(242, 242, 242);
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"FooterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FooterCollectionViewCell"];
    [_myCollectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.scrollEnabled = NO;
    
    [self.view addSubview:_myCollectionView];
}



/**
 *  自定义按钮
 *
 *  @param frame 按钮大小
 *  @param image 按钮图片
 *  @param title 按钮文字
 *
 *  @return button
 */

/**
 *  按钮触发事件
 *
 *  @param sender
 */
#pragma mark -

/**
 *  获取基本信息
 */
- (void)requestDataFromNet {
    
    //
    __weak HomeViewController *weakSelf = self;
    
    
    
    [[API shareAPI] getUserInfo:^(id responseData) {
        
        weakSelf.homeMessage = [[HomeMessage alloc] init];
        [weakSelf.homeMessage setValuesForKeysWithDictionary:responseData[@"json_val"]];
        weakSelf.title = _homeMessage.shopName;
        [[API shareAPI] saveLocalData:G_HeadUrl value:_homeMessage.logo];
        [[API shareAPI] saveLocalData:G_SHOP_NAME value:_homeMessage.shopName];
        
        
        if (Check) {
            Check = NO;
            [self creatViewToShowAttion];
            [weakSelf requestDataFromNet1];
        }
        
        [weakSelf.myCollectionView reloadData];
        
    }];
    
    
    
    
    
    
}

- (void)requestDataFromNet1{
    
    
    [[API shareAPI] checkAPI:API_Check completion:^(id responseData) {
        if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
            if ([responseData[@"json_val"][@"status"] isEqualToString:@"1"]) {
                //有版本更新
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"更新" otherButtonTitles: nil];
                alert.tag = 102;
                [alert show];
            }
            
        }
    }];
    
}
- (void)share{
    
    NSString *shareText = @"消费满180，累计最高赠送180积分。以此类推！分享还有钱赚。";             //分享内嵌文字
    //    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
    UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon80" ofType:@"png"]];
    //调用快速分享接口
    NSArray *nameArry  =  [NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline, UMShareToEmail,UMShareToSms,UMShareToQQ,UMShareToQzone,UMShareToTencent,nil];
    //    UMShareToSina  UMShareToQQ  UMShareToQzone
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strUserID = [config objectForKey:G_SHOP_ID];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _homeMessage.shopName;//微信
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _homeMessage.shopName;//微信朋友圈
    [UMSocialData defaultData].extConfig.qqData.title = _homeMessage.shopName;//QQ
    [UMSocialData defaultData].extConfig.qzoneData.title = _homeMessage.shopName;//QQ 空间
    [UMSocialData defaultData].extConfig.emailData.title = _homeMessage.shopName;//邮箱
    [UMSocialData defaultData].extConfig.tencentData.title = _homeMessage.shopName;//腾讯微博
    
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://web.91maidan.com/businessh5/businessShare.html?id=%@",strUserID];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://web.91maidan.com/businessh5/businessShare.html?id=%@",strUserID];
    [UMSocialData defaultData].extConfig.qzoneData.url =  [NSString stringWithFormat:@"http://web.91maidan.com/businessh5/businessShare.html?id=%@",strUserID];
    [UMSocialData defaultData].extConfig.qqData.url=   [NSString stringWithFormat:@"http://web.91maidan.com/businessh5/businessShare.html?id=%@",strUserID];
    [UMSocialData defaultData].extConfig.tencentData.urlResource.url = [NSString stringWithFormat:@"http://web.91maidan.com/businessh5/businessShare.html?id=%@",strUserID];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:nameArry
                                       delegate:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Share Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }else if(alertView.tag == 102){
        NSString *_trackVireUrl  = @"https://itunes.apple.com/us/app/mai-dan-shang-hu-duan/id1095553096";
        UIApplication *application = [UIApplication sharedApplication];
        NSString *strUrl = [_trackVireUrl  stringByReplacingOccurrencesOfString:@"https" withString:@"itms-apps"];
        
        [application openURL:[NSURL URLWithString:strUrl]];
    }
    
}
#pragma mark - UITableViewDelegate



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//某个分区的cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FooterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FooterCollectionViewCell" forIndexPath:indexPath];
    
    cell.imageV.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.nameLable.text = _titleArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.size.width, _cellHegit *G_SCREEN_PROP);
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if (kind == UICollectionElementKindSectionHeader){
        HeaderView *headerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.homeVC =self;
        NSString *price;
        NSMutableAttributedString *mAtrrString;
        price =[NSString stringWithFormat:@"%.2f",[_homeMessage.businessScore floatValue]];
        
        NSDictionary *consumDic1 =  @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:24],NSForegroundColorAttributeName:RGBCOLOR(255, 255, 255)};
        NSDictionary *consumDic2 = @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:12],NSForegroundColorAttributeName:RGBCOLOR(255, 255, 255)};
        NSRange range = [price rangeOfString:@"."];//匹配得到的下标
        mAtrrString= [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
        
        [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(range.location + 1,2)];
        headerView.businessLable.attributedText = mAtrrString;
        
        
        price =[NSString stringWithFormat:@"%.2f",[_homeMessage.shareScore floatValue]];
        NSRange range1 = [price rangeOfString:@"."];//匹配得到的下标
        mAtrrString = [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
        [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(range1.location + 1,2)];
        headerView.shareLable.attributedText = mAtrrString;
        if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]
             ]) {
            headerView.headerView.image =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]];
        }else{
            // by mayan  20160426   修改加载失败图
            [headerView.headerView sd_setImageWithURL:[NSURL URLWithString:_homeMessage.logo] placeholderImage:[UIImage imageNamed:@"logo_zhuan"]];
            [[API shareAPI] saveLocalData:G_HeadUrl value:_homeMessage.logo];
        }
        headerView.userName.text = _homeMessage.workerName;
        if (_homeMessage.workerName.length == 0) {
            headerView.userName.text = _homeMessage.loginName;
        }
        return  headerView;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)      //订单扫描确认
    {
        
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                NSLog(@"相机权限受限");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"抱歉，你的设备未开启相机权限！"
                                                               delegate:self
                                                      cancelButtonTitle:@"前往开启"
                                                      otherButtonTitles:nil];
                alert.tag = 101;
                [alert show];
                return;
            }
            ScanViewController *controller = [[ScanViewController alloc] init];
            [self.navigationController pushViewController: controller animated:YES];
        }
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"抱歉，你的设备不支持该功能！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    else if (indexPath.row == 1) //订单输入确认
    {
        InputCodeViewController *controller = [[InputCodeViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 2) //积分管理
    {
        IntegralManageViewController *controller = [[IntegralManageViewController alloc] init];
        controller.strLogoUrl = _homeMessage.logo;
        controller.operatingIncome = _homeMessage.businessScore;
        controller.benefitSharing = _homeMessage.shareScore;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 3) //财务管理
    {
        FinancialManagerViewController *managerVC = [FinancialManagerViewController new];
        managerVC.businessScore = self.homeMessage.businessScore;
        managerVC.shareScore = self.homeMessage.shareScore;
        managerVC.workerName = self.homeMessage.workerName;
        managerVC.loginName = self.homeMessage.loginName;
        managerVC.homeMessage = self.homeMessage;
        [self.navigationController pushViewController:managerVC animated:YES];
    }
    else if (indexPath.row == 4) //商户信息
    {
#warning test....
        MDShopInfoViewController *infoVC = [MDShopInfoViewController new];
        [self.navigationController pushViewController:infoVC animated:YES];
//        ShopInfomationViewController *infoVC = [ShopInfomationViewController new];
//        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else if (indexPath.row == 5) //图片管理
    {
        ImageManagerViewController *imageVC = [ImageManagerViewController new];
        [self.navigationController pushViewController:imageVC animated:YES];
    }
    else if (indexPath.row == 6) //我的邀请
    {
        MyInviteVC *controller = [[MyInviteVC alloc] init];
        controller.homeMessage = _homeMessage;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 7) //关注用户
    {
        AttentionUserVC *controller = [[AttentionUserVC alloc] init];
        [self.navigationController pushViewController: controller animated:YES];
    }
    else if (indexPath.row == 8) //意见反馈
    {
        FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController: feedBackVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//显示首页提示信息
- (void)creatViewToShowAttion{
    //组装URL
    
    NSString *strUrl = [NSString stringWithFormat:@"%@Business-WebService/shopMore/warning",G_SERVER_URL];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@""]; //字符串去空
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: strUrl]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) //成功
     {
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         
         NSLog(@"dicData = %@",dicData);
         
         NSString *iStatus = [dicData objectForKey:@"json_res"];
         
         if ([iStatus  isEqualToString:@"json_ok"]) //通讯正常
         {
             NSDictionary   *dicItem = [dicData objectForKey:@"json_val"];
             if ([dicItem[@"isOpen"]isEqualToString:@"1"]) {
                 AttenView *atten = [[AttenView alloc] initWithFrame:self.view.bounds];
                 [atten showWithtitle:dicItem[@"title"] Content:dicItem[@"content"]];
             }
         }
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         NSLog(@"Failure == %@", error);
     }];
    
    [operation start];
}


#pragma mark - handleSwipes
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender {
    _isAction = !_isAction;
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self left];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self right];
    }
}

#pragma mark - left
- (void)left {
    for (UIGestureRecognizer *tap in self.view.gestureRecognizers) {
        if ([tap isKindOfClass:[UITapGestureRecognizer class]]) {
            [self.view removeGestureRecognizer:tap];
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        window.frame = [UIScreen mainScreen].bounds;
        _menuController.view.frame = CGRectMake(-223, 0, 223, G_SCREEN_HEIGHT);
        imageView.alpha = 0;
    }];
}

#pragma mark - right
- (void)right {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
    [UIView animateWithDuration:0.5 animations:^{
        _menuController.view.frame = CGRectMake(0, 0, 223, G_SCREEN_HEIGHT);
        window.frame = CGRectMake(223, 0, G_SCREEN_WIDTH, G_SCREEN_HEIGHT);
        [_myWindow addSubview:window];
        [_myWindow makeKeyAndVisible];
        imageView.alpha = 1.0;
    }];
}
- (void)setting {
    
    if (_isAction == NO) {
        _isAction = !_isAction;
        [self right];
    } else {
        _isAction = !_isAction;
        [self left];
    }
}
- (void)tapView {
    _isAction = !_isAction;
    [self left];
}
@end
