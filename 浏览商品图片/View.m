//
//  View.m
//  浏览商品图片
//
//  Created by 王奥东 on 16/11/11.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "View.h"

@implementation View
//初始化
-(View *)initWithView:(UIView *)viewToMap withRatio:(NSInteger)ratio {
    
    self = [super initWithFrame:viewToMap.frame];
    
    if (self) {
        zoomedView = viewToMap;
        _ratio = ratio;
        
        //创建并设置滚动视图对象
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
        self.scrollView.contentSize = CGSizeMake(viewToMap.bounds.size.width, viewToMap.bounds.size.height);
        self.scrollView.delegate = self;
        //设置滚动视图可以缩放的最小最大值
        self.scrollView.minimumZoomScale = 1;
        self.scrollView.maximumZoomScale = 20;
        
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        self.scrollView.bounces = NO;
        
        //添加视图对象到滚动视图中
        [self.scrollView addSubview:viewToMap];
        
        [self addSubview:self.scrollView];
        //创建并设置一个小的视图
        miniMe = [[UIView alloc] initWithFrame:CGRectMake(10, 10, viewToMap.frame.size.width/_ratio, viewToMap.frame.size.height/_ratio)];
        //剪切超出父视图范围的子视图部分
        miniMe.clipsToBounds = YES;
        
        //设置当前的缩放值
        self.scrollView.zoomScale = 5;
        
        //小视图的图片
        UIImageView *miniMeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
        miniMeImgView.frame = CGRectMake(0, 0, miniMe.frame.size.width, miniMe.frame.size.height);
        [miniMe addSubview:miniMeImgView];
        
        [self addSubview:miniMe];
        
        //指示器
        miniMeIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, miniMe.frame.size.width/self.scrollView.zoomScale, miniMe.frame.size.height/self.scrollView.zoomScale)];
        
        [miniMeIndicator setBackgroundColor:[UIColor redColor]];
        
        [miniMeIndicator setAlpha:0.40];
        [miniMe addSubview:miniMeIndicator];
        
        //覆盖小视图的按钮
        UIButton *miniMeSelectorBtn = [[UIButton alloc] init];
        
        miniMeSelectorBtn.frame = CGRectMake(0, 0, miniMe.frame.size.width, miniMe.frame.size.height);
        miniMeSelectorBtn.backgroundColor = [UIColor clearColor];
        
        [miniMeSelectorBtn addTarget:self action:@selector(dragBegan:withEvent:) forControlEvents:UIControlEventTouchDragInside | UIControlEventTouchDown];

        miniMeSelectorBtn.clipsToBounds = YES;
        [miniMe addSubview:miniMeSelectorBtn];
    }
    return self;
}


//拖拽
-(void)dragBegan:(UIControl *)c withEvent:ev {
    
    UITouch *touch = [[ev allTouches] anyObject];
    //获取相对于miniMe的触摸点
    CGPoint touchPoint = [touch locationInView:miniMe];
    
    //小于0即超出了小视图的左、上
    
    //判断当前触摸点的x是否小于0
    if (touchPoint.x < 0) {
        touchPoint.x = 0;
    }
    //判断当前触摸点的x是否小于0
    if (touchPoint.y < 0) {
        touchPoint.y = 0;
    }
    
    //超出了右、下
    
    if (touchPoint.y + miniMe.frame.size.height / self.scrollView.zoomScale > miniMe.frame.size.height) {
        touchPoint.y = miniMe.frame.size.height - miniMe.frame.size.height / self.scrollView.zoomScale;
    }
    
    if (touchPoint.x + miniMe.frame.size.width / self.scrollView.zoomScale > miniMe.frame.size.width) {
    
        touchPoint.x = miniMe.frame.size.width - miniMe.frame.size.width / self.scrollView.zoomScale;
    }
    //指示器
    miniMeIndicator.frame = CGRectMake(touchPoint.x, touchPoint.y, miniMeIndicator.frame.size.width, miniMeIndicator.frame.size.height);
    
    
    //设置可滚动区域的偏移量
    [self.scrollView setContentOffset:CGPointMake(touchPoint.x * _ratio * self.scrollView.zoomScale, touchPoint.y * _ratio *self.scrollView.zoomScale)];
    
}


//实现对屏幕的截取,本案例暂无用到。
-(UIImage *)captureScreen:(UIView *)viewToCapture {
    
    CGRect rect = [viewToCapture bounds];
    //设置视图上下文与缩放因子
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    //获取一个基于当前图形的上下文图片
    [viewToCapture.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}



#pragma mark - UIScrollViewDelegate methods
//滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    miniMeIndicator.frame = CGRectMake(self.scrollView.contentOffset.x / _ratio / self.scrollView.zoomScale, self.scrollView.contentOffset.y / _ratio / self.scrollView.zoomScale, miniMeIndicator.frame.size.width, miniMeIndicator.frame.size.height);
}
//获取放大后的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return zoomedView;
}


@end
