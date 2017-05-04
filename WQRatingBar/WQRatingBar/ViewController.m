//
//  ViewController.m
//  WQRatingBar
//
//  Created by qian wan on 2017/5/4.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import "ViewController.h"
#import "WQRatingBarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WQRatingBarView *view = [[WQRatingBarView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    view.center = self.view.center;
    view.starTotalNumber = 7;
    view.selectedStarNumber = 2;
    [view setTouchEnable:YES];
    [view setScrollSelectEnable:YES];
    [self.view addSubview:view];
    
    //设置星星滑动点击后的星级内容
    view.starChangeBlock = ^(CGFloat currentScore) {
        NSLog(@"%f",currentScore);
    };
}


@end
