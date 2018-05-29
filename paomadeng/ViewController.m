//
//  ViewController.m
//  paomadeng
//
//  Created by guodongdong on 2018/5/26.
//  Copyright © 2018年 Dawn. All rights reserved.
//

#import "ViewController.h"
#import "WCPMDView.h"

@interface ViewController ()

@property (nonatomic, strong) WCPMDView *p;

@property (nonatomic) BOOL start;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.start = YES;
    WCPMDView *p = [[WCPMDView alloc] initWithFrame:CGRectMake(50, 200, 100, 50)];
    p.text = @"人生若人生人生若---";
    p.repeatCount = 1;
    p.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:p];
    self.p = p;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.start == YES) {
        self.start = NO;
        
        self.p.textColor = [UIColor blueColor];
        self.p.bgColor = [UIColor whiteColor];
        [self.p startAction];
    } else {
        [self.p stopAction];
        self.p.textColor = [UIColor blackColor];
        self.p.bgColor = [UIColor greenColor];
        self.start = YES;
    }
}

@end

