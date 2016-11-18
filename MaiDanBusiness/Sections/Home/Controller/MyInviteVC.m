//
//  MyInviteVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "MyInviteVC.h"
#import "TTButton.h"
#import "BenefitBean.h"
#import "HomeMessage.h"
#import "SHTableView.h"


#import "UIImage+MDQRCode.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "XGShare.h"

#define TAG_BUTTON_INVITE1 0x001
#define TAG_BUTTON_INVITE2 0x002
#define TAG_BUTTON_CODE    0x003
#define TAG_BUTTON_RETURN  0x004
#define TAG_LABEL_COUNT    0x005

#define TAG_LABEL_CELL1 0x101
#define TAG_IMAGE_LOGO  0x103
#define TAG_LABEL_CELL2 0x104
#define TAG_IMAGE_LOGO1  0x105
@interface MyInviteVC ()<DataParseDelegate>
{
    int _hasNext;
    TTButton *btn1;
    UILabel *lblName ;
    UIImageView *topView;
    UIButton *recyBtn;
    UILabel *invitcode ;//我的
}

@property (nonatomic, strong) NSMutableArray  *arrBenefitList;
@property (nonatomic, strong) SHTableView *tableView;

//二维码
@property (nonatomic,strong)  UIView *qrView;
@property (nonatomic, strong) UIImageView* qrImgView;
@property (nonatomic, strong) UIImageView* qrImgView1;
@property (nonatomic, strong) NSString *strQRCodeUrl;
@property (nonatomic, strong) NSString *strQRCodeImg;
@property (nonatomic, strong) NSString *strLogoUrl;
@end

@implementation MyInviteVC
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(247, 247, 247);
    self.title = @"我的邀请";
    _hasNext = 1;
    
    //列表
    [self initUI];
    [self addTableView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    //生效
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}

- (UIView *)qrView {
    
    if (_qrView == nil) {
        
        _qrView = [[UIView alloc] initWithFrame:CGRectMake(0,lblName.bottom + 5, 225, 250)];
        _qrView.backgroundColor = [UIColor whiteColor];
        
        
        _qrImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 225, 225)];
        _qrImgView.contentMode = UIViewContentModeScaleAspectFit;
        
        //二维码链接生成 TODO
        NSString *strUserID = [[API shareAPI] getLocalData:G_SHOP_ID];
        
        _strQRCodeUrl = [NSString stringWithFormat:@"%@%@",G_SHARE_URL, strUserID];
        
        [self createQR1];
//        [self createQR2];
        
        [_qrView addSubview:_qrImgView];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _qrImgView.bottom +5, 225, 20)];
        lbl.text = @"扫一扫,注册脉单";
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = RGBCOLOR(51, 51, 51);
        [_qrView  addSubview:lbl];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapCliclk:)];
        _qrImgView.userInteractionEnabled = YES;
        [self.qrImgView addGestureRecognizer:tap];
    }
    return  _qrView;
}

- (void)initUI {
    //账户信息视图
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, 265 *G_SCREEN_PROP)];
    topView.image = [UIImage imageNamed:@"wodeyaoqing_bg"];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    //头像
    UIImageView *imgViewPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 60, 60)];
    
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]
         ]) {
        imgViewPortrait.image =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]];
    }else{
        // by mayan  20160426   修改加载失败图
        [imgViewPortrait sd_setImageWithURL:[NSURL URLWithString:_homeMessage.logo]placeholderImage:[UIImage imageNamed:@"logo_zhuan"]];
        [[API shareAPI] saveLocalData:G_HeadUrl value:_homeMessage.logo];
    }
    imgViewPortrait.centerX = self.view.centerX;
    
    imgViewPortrait.layer.masksToBounds    = YES;
    imgViewPortrait.layer.cornerRadius     = 30;
    [topView addSubview:imgViewPortrait];
    
    //名称
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, imgViewPortrait.bottom + 5, 200, 15)];
    lblName.centerX = self.view.centerX;
    lblName.textAlignment = NSTextAlignmentCenter;
    lblName.textColor = [UIColor whiteColor];
    lblName.font = [UIFont systemFontOfSize:14];
    lblName.text = _homeMessage.workerName;
    if ([_homeMessage.workerName isEqualToString:@""] || _homeMessage.workerName.length == 0 ) {
        lblName.text = _homeMessage.loginName;
    }
    [topView addSubview:lblName];
    
    
    //我的邀请码
    UIButton *inviteBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    inviteBtn.frame  = CGRectMake(0, lblName.bottom + 9, 48*G_SCREEN_PROP,48*G_SCREEN_PROP);
    inviteBtn.centerX = self.view.centerX;
    inviteBtn.tag =TAG_BUTTON_CODE;
    [inviteBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [inviteBtn setImage:[UIImage imageNamed:@"xialajiantou"] forState:UIControlStateNormal];
    [topView addSubview:inviteBtn];
    //积分
    invitcode =  [[UILabel alloc] initWithFrame:CGRectMake(0, inviteBtn.bottom + 4, G_SCREEN_WIDTH, 15)];
    invitcode.text = [NSString stringWithFormat:@"我的邀请码:%@",_homeMessage.inviteCode];
    invitcode.textColor = [UIColor whiteColor];
    invitcode.textAlignment = NSTextAlignmentCenter;
    invitcode.font = [UIFont systemFontOfSize:14];
    invitcode.centerX = self.view.centerX;
    [topView addSubview:invitcode];
    
    
    // 添加分享按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        NSString *shareTitle = [[API shareAPI] getLocalData:G_SHOP_NAME];
        NSString *inviteCode = [[API shareAPI] getLocalData:G_SHOP_ID];
        NSString *shareText = @"消费赠积分，积分再消费，分享有收益。";
        NSString *shareUrl = [NSString stringWithFormat:@"%@%@",@"http://web.91maidan.com/businessh5/businessShare.html?id=",inviteCode];
        [XGShare shareWithShareTitle:shareTitle shareContent:shareText shareImage:@"md_app_share" shareUrl:shareUrl inViewController:self];
    }];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addTableView{
    
    self.tableView = [[SHTableView alloc] initWithFrame:CGRectMake(0, 265 *G_SCREEN_PROP, G_SCREEN_WIDTH, G_SCREEN_HEIGHT - 265 *G_SCREEN_PROP) andCompletionBlock:^NSInteger{
        return 1;
        
    } numberOfRows:^NSInteger(NSInteger section) {
        
        if (_tableView.dataArray > 0) {
            if (_tableView.dataArray.count %2 == 0) {
                return  _tableView.dataArray.count/2 +1;
            }
            return  _tableView.dataArray.count/2 +2;
        }
        return 0;
    } andCells:^UITableViewCell *(SHTableView *tableView, NSIndexPath *indexPath) {
        static NSString *identifier1 = @"identifier1";
        static NSString *identifier2 = @"identifier2";
        UITableViewCell *cell;
        if (indexPath.row == 0) {
            cell=[tableView dequeueReusableCellWithIdentifier:identifier2];;
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 18, 115, 25)];
                lable.text =     @"已邀请的好友:";
                lable.textColor = RGBCOLOR(51, 51, 51);
                [cell.contentView addSubview:lable];
                UILabel *Number=[Factory createLabelWithframe:CGRectMake(lable.right + 5, 18, 100, 25) tag:0 textColor:RGBCOLOR(237, 87, 49) backgroud:[UIColor whiteColor] fontSize:16 Title:@"0"];
                Number.tag=TAG_LABEL_COUNT;
                Number.font = [UIFont systemFontOfSize:18];
                Number.textAlignment=NSTextAlignmentLeft;
                [cell.contentView addSubview:Number];
            }
            _tableView.cellHeight = 40;
            UILabel *lbl1 = (UILabel *)[cell viewWithTag:TAG_LABEL_COUNT];
            
            lbl1.text = [NSString stringWithFormat:@"%@",_homeMessage.inviteCount];
            
            
        }else{
            cell=[tableView dequeueReusableCellWithIdentifier:identifier1];;
            if (cell == nil)
            {
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIImageView *imgViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
                imgViewLogo.tag = TAG_IMAGE_LOGO;
                [cell.contentView addSubview:imgViewLogo];
                imgViewLogo.layer.borderWidth = 2;
                imgViewLogo.layer.borderColor = [UIColor whiteColor].CGColor;
                
                imgViewLogo.layer.masksToBounds    = YES;
                imgViewLogo.layer.cornerRadius     = 30;
                //名称
                UILabel *lbl1  = [[UILabel alloc] initWithFrame:CGRectMake(imgViewLogo.right + 5, 25, G_SCREEN_WIDTH/2 - 70, 20)];
                lbl1.tag = TAG_LABEL_CELL1;
                lbl1.textColor = RGBCOLOR(51, 51, 51);
                lbl1.font      = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:lbl1];
                
                UIImageView *imgViewLogo1 = [[UIImageView alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH/2 + 5, 10, 60, 60)];
                imgViewLogo1.tag = TAG_IMAGE_LOGO1;
                [cell.contentView addSubview:imgViewLogo1];
                imgViewLogo1.layer.masksToBounds    = YES;
                imgViewLogo1.layer.cornerRadius     = 30;
                //名称
                UILabel *lbl2  = [[UILabel alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH/2 + imgViewLogo.right + 5, 25, G_SCREEN_WIDTH/2 - 75, 20)];
                lbl2.tag = TAG_LABEL_CELL2;
                lbl2.textColor = RGBCOLOR(51, 51, 51);
                lbl2.font      = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:lbl2];
                
                UILabel *textlbl= [[UILabel alloc] initWithFrame:CGRectMake(0, imgViewLogo.bottom + 5, G_SCREEN_WIDTH + 100, 10)];
                textlbl.text = @".............................................................................................................................................................";
                textlbl.textColor = RGBCOLOR(197, 197, 197);
                textlbl.font = [UIFont systemFontOfSize:10];
                [cell addSubview:textlbl];
            }
            _tableView.cellHeight = 80;
            NSInteger m = 0;
            m = indexPath.row * 2  -2;
            _bean = [_tableView.dataArray objectAtIndex:m];
            UIImageView *imgViewLogo = (UIImageView *)[cell viewWithTag:TAG_IMAGE_LOGO];
            [imgViewLogo sd_setImageWithURL:[NSURL URLWithString:_bean.logo] placeholderImage:[UIImage imageNamed:@"icon80"]];
            
            //名称
            UILabel *lbl1 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL1];
            lbl1.text = _bean.name;
            
            if (_tableView.dataArray.count  > m + 1) {
                _bean = [_tableView.dataArray objectAtIndex:m + 1];
                UIImageView *imgViewLogo1 = (UIImageView *)[cell viewWithTag:TAG_IMAGE_LOGO1];
                [imgViewLogo1 sd_setImageWithURL:[NSURL URLWithString:_bean.logo] placeholderImage:[UIImage imageNamed:@"icon80"]];
                //名称
                UILabel *lbl2 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL2];
                lbl2.text = _bean.name;
            }
        }
        
        
        return  cell;
    }];
    [_tableView configureSelectionBlock:^(NSIndexPath *selectedIndex) {
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 0.0001;
    self.tableView.dataDelagate = self;
    [self requestDataFromNet:1];
    [self.view addSubview:_tableView];
}

- (void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == TAG_BUTTON_CODE)
    {
        //添加二维码
        self.qrView.centerX = self.view.centerX;
        self.tableView.frame  =CGRectMake(0, 259 + lblName.bottom + 24*G_SCREEN_PROP , G_SCREEN_WIDTH, G_SCREEN_HEIGHT - 259 -  lblName.bottom -24*G_SCREEN_PROP);
        //我的邀请码
        //回收二维码
        recyBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        recyBtn.frame  = CGRectMake(0,self.tableView.top -24*G_SCREEN_PROP,48*G_SCREEN_PROP,24*G_SCREEN_PROP);
        recyBtn.centerX = self.view.centerX;
        recyBtn.tag =TAG_BUTTON_RETURN;
        [recyBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [recyBtn setImage:[UIImage imageNamed:@"xiangshangjiantou"] forState:UIControlStateNormal];
        invitcode.hidden = YES;
        [self.view addSubview:recyBtn];
        [self.view addSubview:_qrView];
    }
    else if (btn.tag == TAG_BUTTON_RETURN)
    {
        invitcode.hidden = NO;
        [_qrView removeFromSuperview];
        [recyBtn removeFromSuperview];
        self.tableView.frame  =CGRectMake(0, 265 *G_SCREEN_PROP, G_SCREEN_WIDTH, G_SCREEN_HEIGHT - 265 *G_SCREEN_PROP);
        
    }
}


/**
 *  获取后台数据
 */
- (void)requestDataFromNet:(int)pag{
    __weak MyInviteVC *weakSelf = self;
    
    //关注请求
    weakSelf.arrBenefitList = [NSMutableArray array];
    [[API shareAPI] getAPI:API_MyInvite pag:pag completion:^(id responseData) {
        _hasNext= [responseData[@"json_val"][@"hasNext"] boolValue];
        
        if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
            for (NSDictionary *dic in responseData[@"json_val"][@"list"]) {
                weakSelf.bean = [[BenefitBean alloc] init];
                [weakSelf.bean setValuesForKeysWithDictionary:dic];
                [weakSelf.arrBenefitList addObject:_bean];
                
            }
            
        }
        if (pag == 1) {
            self.tableView.dataArray = nil;
            self.tableView.dataArray = _arrBenefitList;
        }else{
            [self.tableView.dataArray addObjectsFromArray:_arrBenefitList];
        }
        _homeMessage.inviteCount = responseData[@"json_val"][@"totalCount"];
        weakSelf.tableView.hastNext =_hasNext;
    }];
    
}
/**
 *  二维码
 */


- (void)createQR1
{
    //二维码链接生成
//    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
//    NSString *strUserID = [config objectForKey:G_SHOP_ID];
//    
//    _strQRCodeUrl =  [NSString stringWithFormat:@"%@/regbybusiness/%@",G_SHARE_URL,strUserID];
    
    UIImage *qrImg = [UIImage mdQRCodeForString:_strQRCodeUrl size:self.qrImgView.frame.size.width fillColor:RGBCOLOR(0, 0, 0)];;
    
    UIImageView *logoImg          = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    logoImg .backgroundColor = [UIColor whiteColor];
    logoImg .layer.masksToBounds    = YES;
    logoImg .userInteractionEnabled = YES;
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]) {
        
        [logoImg  setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]];
        
    } else {
        [logoImg  sd_setImageWithURL:[NSURL URLWithString:_strLogoUrl] placeholderImage:[UIImage imageNamed:@"icon80"]];
    }
    UIImage *logoImg1;
    logoImg1 = [UIImage roundedCornerImageWithCornerRadius:5 srcImg:logoImg.image];
    _qrView.backgroundColor = [UIColor whiteColor];
    _qrImgView.image = [UIImage addImageLogo:qrImg centerLogoImage:logoImg1 logoSize:CGSizeMake(60, 60)];
}
- (void)createQR2
{
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strUserID = [config objectForKey:G_SHOP_ID];
    
//    _strQRCodeUrl =  [NSString stringWithFormat:@"%@/regbybusiness/%@",G_SHARE_URL,strUserID];
    _strQRCodeUrl = [NSString stringWithFormat:@"%@%@",G_SHARE_URL, strUserID];
    _qrImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , G_SCREEN_WIDTH, G_SCREEN_WIDTH )];
    UIImage *qrImg = [UIImage mdQRCodeForString:_strQRCodeUrl size:self.qrImgView.frame.size.width fillColor:RGBCOLOR(0, 0, 0)];;
    
    UIImageView *logoImg          = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    logoImg.backgroundColor = [UIColor whiteColor];
    logoImg.layer.masksToBounds    = YES;
    logoImg.userInteractionEnabled = YES;
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]) {
        [logoImg  setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]];
        
    } else {
        [logoImg  sd_setImageWithURL:[NSURL URLWithString:_strLogoUrl] placeholderImage:[UIImage imageNamed:@"icon80"]];
    }
    UIImage *logoImg1;
    logoImg1 = [UIImage roundedCornerImageWithCornerRadius:5 srcImg:logoImg.image];
    
    _qrImgView1.image = [UIImage addImageLogo:qrImg centerLogoImage:logoImg1 logoSize:CGSizeMake(60, 60)];
    
}



- (void)imgTapCliclk:(UITapGestureRecognizer *)tap{
    //1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i<1; i++) {
        //        // 替换为中等尺寸图片
//        NSString *url = [_strQRCodeUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image =_qrImgView.image;
//        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.isPhone = YES;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    
    [browser show];
}

@end
