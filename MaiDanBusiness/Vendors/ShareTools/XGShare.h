//
//  XGShare.h
//  SmallThings
//
//  Created by 潇哥 on 15/7/23.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

@interface XGShare : NSObject

+ (void)shareWithShareTitle:(NSString *)shareTitle
          shareContent:(NSString *)shareContent
           shareImage:(NSString *)shareImage
             shareUrl:(NSString *)shareUrl
     inViewController:(UIViewController *)vc;

@end
