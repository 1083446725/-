//
// 逗逼专用跑马灯
//


#import "PaoMaDengView.h"

@interface PaoMaDengView ()

// 滚动label
@property (nonatomic, strong) UILabel *titleLB;

// 占位显示label
@property (nonatomic, strong) UILabel *holderLB;

// 移动的距离
@property (nonatomic) CGFloat lenth;

@end

@implementation PaoMaDengView

-(UILabel *)titleLB
{
    if (_titleLB == nil)
    {
        _titleLB = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.userInteractionEnabled = YES;
    }
    return _titleLB;
}

-(UILabel *)holderLB
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
        self.font = 13;
        self.bgColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        [self addSubview:self.titleLB];
        [self addSubview:self.holderLB];
        self.clipsToBounds = YES;
        self.repeatCount = MAXFLOAT;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLB.font = [UIFont systemFontOfSize:self.font];
    self.holderLB.font = [UIFont systemFontOfSize:self.font];
    
    self.titleLB.text = self.text;
    self.holderLB.text = self.text;
    
    self.titleLB.textColor = self.textColor;
    self.holderLB.textColor = self.textColor;
    
    self.backgroundColor = self.bgColor;
    
    self.holderLB.frame = self.bounds;
    self.holderLB.hidden = NO;
    self.titleLB.hidden = YES;
    
    [self.titleLB sizeToFit];
    
    CGFloat w = self.titleLB.frame.size.width;
    // 当文字超出边界才需要滚动
    if (w > self.bounds.size.width) {
        self.titleLB.text = [NSString stringWithFormat:
                             @"%@       %@",self.text,self.text];
        [self.titleLB sizeToFit];
        self.lenth = self.titleLB.frame.size.width - w;
        self.titleLB.frame = CGRectMake(0, 0, 2 * w + 50, self.bounds.size.height);
    }
}

// 开始动画
- (void)startAction {
    
    CGFloat w = self.titleLB.frame.size.width;
    // 当文字超出边界才需要滚动
    if (w > self.bounds.size.width) {
        self.titleLB.hidden = NO;
        self.holderLB.hidden = YES;
        [self startAnimation];
    }
}

- (void)startAnimation {
    
    [UIView beginAnimations:@"MarqueeBarAniamation" context:NULL];
    
    // 设置动画变化曲线
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [UIView setAnimationDuration:self.text.length * 0.3];
    
    // 设置动画是否从当前状态开始播放
    [UIView setAnimationRepeatAutoreverses:NO];
    
    [UIView setAnimationRepeatCount:self.repeatCount];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    CGRect frame = self.titleLB.frame;
    frame.origin.x = - self.lenth;
    self.titleLB.frame = frame;
    
    [UIView commitAnimations];
}

// 动画结束后回到初始位置
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context

{
    //    self.titleLB.frame = self.bounds;
    //    self.titleLB.hidden = YES;
    //    self.holderLB.hidden = NO;
    [self setNeedsLayout];
}

// 结束动画
- (void)stopAction {
    [self.titleLB.layer removeAllAnimations];
}

@end
