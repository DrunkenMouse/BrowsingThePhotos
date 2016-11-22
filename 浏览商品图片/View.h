//
//  View.h
//  浏览商品图片
//
//  Created by 王奥东 on 16/11/11.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <UIKit/UIKit.h>

#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width

@class View;

@interface View : UIView<UIScrollViewDelegate>{
    UIView *zoomedView;
    UIView *miniMe;
    UIImageView *miniMeImageView;
    UIView *miniMeIndicator;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger ratio;

-(View *)initWithView:(UIView *)viewToMap withRatio:(NSInteger)ratio;

@end
