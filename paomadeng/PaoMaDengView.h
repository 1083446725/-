//
// 逗逼专用跑马灯
//

#import <UIKit/UIKit.h>

@interface PaoMaDengView : UIView

/**
 跑马灯文字
 */
@property (nonatomic, copy) NSString *text;


/**
 字体大小 默认13
 */
@property (nonatomic) CGFloat font;


/**
 字体颜色 默认黑色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 背景颜色 默认白色
 */
@property (nonatomic, strong) UIColor *bgColor;


/**
 滚动次数，默认是循环滚动
 */
@property (nonatomic) float repeatCount;

/**
 结束动画
 */
- (void)stopAction;

/**
 开始动画
 */
- (void)startAction;

@end
