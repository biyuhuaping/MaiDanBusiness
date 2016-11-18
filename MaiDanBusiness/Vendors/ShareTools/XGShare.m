//
//  XGShare.m
//  SmallThings
//
//  Created by 潇哥 on 15/7/23.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import "XGShare.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"

@implementation XGShare

+ (void)shareWithShareTitle:(NSString *)shareTitle
               shareContent:(NSString *)shareContent
                 shareImage:(NSString *)shareImage
                   shareUrl:(NSString *)shareUrl
           inViewController:(UIViewController *)vc {

    NSMutableArray *platforms = [NSMutableArray array];
    
    if ([QQApiInterface isQQInstalled]) {
        [platforms addObject:UMShareToQQ];
        [platforms addObject:UMShareToQzone];
    }
    
    if ([WXApi isWXAppInstalled]) {
        [platforms addObject:UMShareToWechatSession];
        [platforms addObject:UMShareToWechatTimeline];
    }
    
    if (platforms.count == 0) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [API hudWithText:@"尚未安装微信和QQ，无法分享！" atView:keyWindow];
        return;
    }
    
    // 微信好友
    [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    
    // 朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    
    // QQ
    [UMSocialData defaultData].extConfig.qqData.title = shareTitle;
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    
    // QZone
    [UMSocialData defaultData].extConfig.qzoneData.title = shareTitle;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    
    id image = [[[XGShare alloc] init] shareImageWithStr:shareImage];
    
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UmengAppkey
                                      shareText:shareContent
                                     shareImage:image
                                shareToSnsNames:platforms delegate:nil];
}

- (id)shareImageWithStr:(NSString *)shareImage {
    
    if (!shareImage.length) {
        return nil;
    }
    
    if ([shareImage hasPrefix:@"http://"]) {
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImage]];
        return data;
    } else {
        
        UIImage *image = [UIImage imageNamed:shareImage];
        return image;
    }
}

@end
