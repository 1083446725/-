//
//  WCPMDView.m
//  paomadeng
//
//  Created by guodongdong on 2018/5/29.
//  Copyright © 2018年 Dawn. All rights reserved.
//

#import "WCPMDView.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

@interface WCPMDView () <CAAnimationDelegate>

// 滚动label
@property (nonatomic, strong) UILabel *titleLB;

// 占位显示label
@property (nonatomic, strong) UILabel *holderLB;

// 移动的距离
@property (nonatomic) CGFloat lenth;

@end

@implementation WCPMDView

- (UILabel *)titleLB
{
    if (_titleLB == nil)
    {
        _titleLB = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.userInteractionEnabled = YES;
    }
    return _titleLB;
}

- (UILabel *)holderLB
{
    if (_holderLB == nil)
    {
        _holderLB = [[UILabel alloc] initWithFrame:self.bounds];
        _holderLB.backgroundColor = [UIColor clearColor];
        _holderLB.userInteractionEnabled = YES;
    }
    return _holderLB;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textFont = [UIFont systemFontOfSize:13];
        self.textAlignment = NSTextAlignmentLeft;
        self.bgColor = [UIColor clearColor];
        self.textColor = [UIColor blackColor];
        [self addSubview:self.titleLB];
        [self addSubview:self.holderLB];
        self.clipsToBounds = YES;
        self.repeatCount = MAXFLOAT;
        self.speed = 0.05;
        self.holderLB.hidden = NO;
        self.titleLB.hidden = YES;
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.holderLB.text = self.text;
    self.titleLB.text = [NSString stringWithFormat:
                         @"%@       %@",self.text,self.text];
    
    CGSize textSize = MB_TEXTSIZE(text, self.textFont);
    CGFloat textlenth = textSize.width;
    CGSize titleSize = MB_TEXTSIZE(self.titleLB.text, self.textFont);
    self.lenth = titleSize.width - textlenth;
    
    self.holderLB.frame = self.bounds;
    self.titleLB.frame = CGRectMake(0, 0, titleSize.width, self.bounds.size.height);
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.titleLB.font = self.textFont;
    self.holderLB.font = self.textFont;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.titleLB.textColor = self.textColor;
    self.holderLB.textColor = self.textColor;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = self.bgColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.titleLB.textAlignment = textAlignment;
    self.holderLB.textAlignment = textAlignment;
}

// 开始动画
- (void)startAction {
    CGSize textSize = MB_TEXTSIZE(self.text, self.textFont);
    CGFloat textlenth = textSize.width;
    
    // 当文字超出边界才需要滚动
    if (textlenth > self.bounds.size.width) {
        self.titleLB.hidden = NO;
        self.holderLB.hidden = YES;
        
        CGSize titleSize = MB_TEXTSIZE(self.titleLB.text, self.textFont);
        self.lenth = titleSize.width - textlenth;
        
        [self startAnimation];
    }
}

- (void)startAnimation {
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    // 终点设定
    animation.fromValue = @(self.titleLB.center.x);
    animation.toValue = @(self.titleLB.center.x - self.lenth);
//    animation.duration = self.text.length * .3;
    animation.speed = self.speed;
    animation.repeatCount = self.repeatCount;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    [self.titleLB.layer addAnimation:animation forKey:@"animationX"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.titleLB.hidden = YES;
    self.holderLB.hidden = NO;
}

// 结束动画
- (void)stopAction {
    [self.titleLB.layer removeAllAnimations];
}

@end
