//
//  WQRatingBarView.m
//  WQRatingBarDemo
//
//  Created by qian wan on 2017/4/20.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import "WQRatingBarView.h"

#define ForegroundStarImage @"star_light"
#define BackgroundStarImage @"star_off"

@interface WQRatingBarView()

@property (nonatomic, strong) UIView *foregroundStarView;//前置试图
@property (nonatomic, strong) UIView *backgroundStarView;//后置试图


@end

@implementation WQRatingBarView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _starTotalNumber = 5;
        _rateStyle = WholeStar;
        _touchEnable = YES;
        _scrollSelectEnable = YES;
    }
    return self;
}

#pragma mark - 创建试图
-(void)createStarView{
    
    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*self.selectedStarNumber/self.starTotalNumber, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.starTotalNumber; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.starTotalNumber, 0, self.bounds.size.width / self.starTotalNumber, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}




#pragma matk - 点击星星
- (void)tapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.starTotalNumber);
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
}

#pragma matk - 滑动星星
- (void)panRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.starTotalNumber);
    //    NSLog(@"%f",realStarScore);
    
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak WQRatingBarView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    
    //不能滑动到0星
    if (weakSelf.selectedStarNumber >= 1) {
        [UIView animateWithDuration:animationTimeInterval animations:^{
            weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.selectedStarNumber/self.starTotalNumber, weakSelf.bounds.size.height);
        }];
    }
    
    
}

#pragma mark - set方法
- (void)setStarChangeBlock:(StarChangeBlock)starChangeBlock
{
    _starChangeBlock = starChangeBlock;
    
    [self setNeedsLayout];
}

- (void)setStarTotalNumber:(NSInteger)starTotalNumber
{
    
    _starTotalNumber = starTotalNumber;
    [self createStarView];
    [self setNeedsLayout];
    
}

- (void)setSelectedStarNumber:(CGFloat)selectedStarNumber
{
    _selectedStarNumber = selectedStarNumber;
    
    [self setNeedsLayout];
    
}

- (void)setMinSelectedNumber:(CGFloat)minSelectedNumber
{
    
    _minSelectedNumber = minSelectedNumber;
    
    [self setNeedsLayout];
    
}

- (void)setTouchEnable:(BOOL)touchEnable
{
    _touchEnable = touchEnable;
    
    if (_touchEnable) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRateView:)];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
    
    
    [self setNeedsLayout];
    
}

- (void)setScrollSelectEnable:(BOOL)scrollSelectEnable
{
    _scrollSelectEnable = scrollSelectEnable;
    if (_scrollSelectEnable) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRateView:)];
        [self addGestureRecognizer:panGesture];
    }
    
    [self setNeedsLayout];
    
}

- (void)setBgViewColor:(UIColor *)bgViewColor
{
    if (_bgViewColor == bgViewColor) {
        return;
    }
    
    self.backgroundColor = bgViewColor;
    self.foregroundStarView.backgroundColor = bgViewColor;
    self.backgroundStarView.backgroundColor = bgViewColor;
    
    [self setNeedsLayout];
    
}

- (void)setIsAnimation:(BOOL)isAnimation
{
    _isAnimation = isAnimation;
    
    [self setNeedsLayout];
    
}

- (void)setRateStyle:(RateStyle)rateStyle
{
    _rateStyle = rateStyle;
    [self setNeedsLayout];
    
}


-(void)setCurrentScore:(CGFloat)currentScore {
    if (_selectedStarNumber == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _selectedStarNumber = 0;
    } else if (currentScore > _starTotalNumber) {
        _selectedStarNumber = _starTotalNumber;
    } else {
        _selectedStarNumber = currentScore;
    }
    
    
    
    if (self.starChangeBlock) {
        _starChangeBlock(_selectedStarNumber );
    }
    
    [self setNeedsLayout];
}

@end
