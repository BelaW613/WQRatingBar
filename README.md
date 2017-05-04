# WQRatingBar
图片可自定义，滑动可控的星级视图

/** 点亮星星发生变化 */
@property (nonatomic, copy) StarChangeBlock starChangeBlock;

/** 星星总的数量*/
@property (nonatomic, assign) NSInteger starTotalNumber;


/** 选中星星的数量，可通过此参数设置默认选中星星个数*/
@property (nonatomic, assign) CGFloat selectedStarNumber;

/** 最少选中星星数*  default：1*/
@property (nonatomic, assign) CGFloat minSelectedNumber;

/** 是否允许可触摸*  default：YES*/
@property (nonatomic, assign) BOOL touchEnable;

/** 是否允许滑动选择（在touchEnable = YES的前提下才有意义）*  default：YES*/
@property (nonatomic, assign) BOOL scrollSelectEnable;

/** 底部视图的颜色 *  default：[UIColor whiteColor]*/
@property (nonatomic, strong) UIColor *bgViewColor;

/** 是否动画显示*  default：NO*/
@property (nonatomic,assign)BOOL isAnimation;

/** 评分样式*  default：WholeStar*/
@property (nonatomic,assign)RateStyle rateStyle;

演示截图如下：
![image](https://github.com/BelaW613/WQRatingBar/WQRatingBar/WQRatingBar/screenshots/screenshots.gif )
