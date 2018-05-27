//
//  ViewController.m
//  paomadeng
//
//  Created by guodongdong on 2018/5/26.
//  Copyright © 2018年 Dawn. All rights reserved.
//

#import "ViewController.h"
#import "PaoMaDengView.h"

@interface ViewController ()

@property (nonatomic, strong) PaoMaDengView *p;

@property (nonatomic) BOOL start;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    PaoMaDengView *p = [[PaoMaDengView alloc] initWithFrame:CGRectMake(50, 200, 300, 50)];
    p.text = @"人生若只如初人生若只如初人生若只如初人生若只如初人生若只如初人生";
    p.repeatCount = 1;
    [self.view addSubview:p];
    self.p = p;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.start == YES) {
        self.start = NO;
        [self.p startAction];
    } else {
        [self.p stopAction];
        self.start = YES;
    }
}

@end
