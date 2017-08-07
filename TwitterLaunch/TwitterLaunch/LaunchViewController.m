//
//  LaunchViewController.m
//  PushOrPresent
//
//  Created by Apple on 2017/8/7.
//  Copyright © 2017年 PS. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;// finished remove
@property (weak, nonatomic) IBOutlet UIView *maskView;// finished remove

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *mask = [CALayer layer];
    
    UIImage *icon = [UIImage imageNamed:@"mask"];
    mask.contents = (__bridge id)icon.CGImage;
    
    mask.frame = CGRectMake(0,0,icon.size.width,icon.size.height);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    mask.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    
    _maskView.layer.mask = mask;
    
    // animation
    [self launchAnimation];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

#pragma mark - ======== Animation ========
- (void)launchAnimation{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.6;
    animation.beginTime = CACurrentMediaTime() + 0.6;
    animation.values = @[
                         @(1),
                         @(0.5),
                         @(20)];
    
    animation.keyTimes = @[@(0),@(0.7),@(1)];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName:@"easeInEaseOut"],
                                  [CAMediaTimingFunction functionWithName:@"easeIn"],
                                  ];
    
    animation.delegate = self;
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    [_maskView.layer.mask addAnimation:animation forKey:@"scale"];
    
}

- (void)homeContentAnimation{
    
    CABasicAnimation *animaiton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animaiton.beginTime = CACurrentMediaTime() - 0.25;
    animaiton.duration = 0.25;
    animaiton.toValue = @(1.3);
    animaiton.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animaiton.autoreverses = YES;

    [_imageView.layer addAnimation:animaiton forKey:@"contentScale"];
    
}
#pragma mark - ======== CAAnimationDelegate ========

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [_maskView removeFromSuperview];
    [_backgroundView removeFromSuperview];
    [self homeContentAnimation];
    
}
@end
