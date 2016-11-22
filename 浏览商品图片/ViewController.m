//
//  ViewController.m
//  浏览商品图片
//
//  Created by 王奥东 on 16/11/11.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()

@end

@implementation ViewController {
    View *_MeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.view.frame];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imgView.frame = tempView.frame;
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [tempView addSubview:imgView];
    _MeView = [[View alloc] initWithView:tempView withRatio:4];
    [self.view addSubview:_MeView];
}



@end
