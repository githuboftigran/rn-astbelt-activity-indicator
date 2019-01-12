//
// Created by Tigran Sahakyan on 2019-01-12.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Asteroid;

NS_ASSUME_NONNULL_BEGIN

@interface AstbeltActivityIndicator : UIView

@property NSString *blankColor;
@property NSString *progressColor;
@property (nonatomic) float progress;

@property NSMutableArray<Asteroid *>* asteroids;

@end

NS_ASSUME_NONNULL_END