//
//  WQRatingBarView.h
//  WQRatingBarDemo
//
//  Created by qian wan on 2017/4/20.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 点亮星星发生变化Block */
typedef void(^StarChangeBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, RateStyle)
{
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

/** 评分条_View */
@interface WQRatingBarView : UIView

/** 点亮星星发生变化 */
@property (nonatomic, copy) StarChangeBlock starChangeBlock;

/** 星星总的数量
 *  default：5
 */
@property (nonatomic, assign) NSInteger starTotalNumber;


/** 选中星星的数量，可通过此参数设置默认选中星星个数
 *  default：星星总数
 */
@property (nonatomic, assign) CGFloat selectedStarNumber;

/** 最少选中星星数
 *  default：1
 */
@property (nonatomic, assign) CGFloat minSelectedNumber;

/** 是否允许可触摸
 *  default：YES
 */
@property (nonatomic, assign) BOOL touchEnable;
/** 是否允许滑动选择（在touchEnable = YES的前提下才有意义）
 *  default：YES
 */
@property (nonatomic, assign) BOOL scrollSelectEnable;
/** 底部视图的颜色
 *  default：[UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *bgViewColor;

/** 是否动画显示
 *  default：NO
 */
@property (nonatomic,assign)BOOL isAnimation;

/** 评分样式
 *  default：WholeStar
 */
@property (nonatomic,assign)RateStyle rateStyle;


-(instancetype)initWithFrame:(CGRect)frame;


@end
