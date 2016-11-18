//
//  UIStoryboard+Category.m
//  SmallThings
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import "UIStoryboard+Category.h"

@implementation UIStoryboard (Category)

+ (id)initViewController {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
}

+ (id)getControllerByID:(NSString *)identifier {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
            instantiateViewControllerWithIdentifier:identifier];
}

@end
