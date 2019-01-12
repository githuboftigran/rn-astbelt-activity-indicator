//
// Created by Tigran Sahakyan on 2019-01-12.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AstbeltActivityIndicator.h"
#import <React/RCTViewManager.h>

@interface AstbeltActivityIndicatorManager : RCTViewManager

@end

@implementation AstbeltActivityIndicatorManager

RCT_EXPORT_MODULE()
- (UIView *) view
{
    return [[AstbeltActivityIndicator alloc] init];
}


RCT_EXPORT_VIEW_PROPERTY(blankColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(progressColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(progress, float)


@end