//
//  ViewAnimationsVC.m
//  Animations
//
//  Created by zhangbinbin on 2017/3/18.
//  Copyright © 2017年 zhangbinbin. All rights reserved.
//

#import "ViewAnimationsVC.h"

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat centerX; // category可以添加非实例变量
@property (nonatomic, assign) CGFloat centerY;
//@property (nonatomic, strong) NSString* test; // 实例变量需要利用runtime机制添加


@end

@implementation UIView (Frame)

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


@end

@interface ViewAnimationsVC ()

@end

@implementation ViewAnimationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//                                              initWithTitle:@"开始"
//                                              style:UIBarButtonItemStyleDone
//                                              target:self
//                                              action:@selector(startAnimation)];
    
    /**
     *  动画属性
     *     通过修改对应视图(UIView)的属性,可以实现一些最基础的动画效果.
     *     位置和尺寸的修改: bounds frame center transform
     *     外观样式的变化: backgroundColor alpha
     */
}

#pragma mark -- 通过改变imageView center 做些简单的动画效果

- (IBAction)startAnimation:(id)sender {
    
    // 1. 普通动画效果
    
    [UIView animateWithDuration:2 // 动画时间
                          delay:1. // 延迟
                        options:UIViewAnimationOptionRepeat // 可选项,这里是循环
                     animations:^{
                         //动画代码,动画执行完后，imageview x + 200
                         self.imageView.centerX += 200;
                     }
                     completion:nil];
}
- (IBAction)startSpringAnimation:(id)sender {
    
    // 2. 弹簧效果
    [UIView animateWithDuration:2
                          delay:1.
         usingSpringWithDamping:.5 // 弹性效果0~1之间,值越大弹簧效果越不明显
          initialSpringVelocity:0 // 运动的速度
                        options:UIViewAnimationOptionRepeat
                     animations:^{
                         //动画代码,动画执行完后，imageview x + 200
                         self.imageView2.centerX += 200;
                     }
                     completion:nil];
}
- (IBAction)startTransitionAnimation:(id)sender {
    
    // 3. 过渡效果
    
    /**
     * 如果想为添加或者移除视图这个动作添加特效,那么我们可以这样做
     */
    [UIView transitionWithView: self.view // contentView 执行动画效果的视图
                      duration:2
                       options:UIViewAnimationOptionTransitionCurlUp // TransitionCurlUp 翻页效果
                    animations:^{
                        [self.imageView3  removeFromSuperview];
                    }
                    completion:nil];
    
    // 如果需要将一个视图替换成另一个视图,那么可以这样做
//    [UIView transitionFromView:self.imageView
//                        toView:self.imageView3
//                      duration:2
//                       options:UIViewAnimationOptionTransitionFlipFromTop
//                    completion:nil];
}

- (IBAction)startGroupAnimation:(id)sender {
    
    // 4. 将一组动画组合
    
    CGRect imageView4Frame = self.imageView4.frame;
    
    [UIView animateKeyframesWithDuration:5 // duration 整个动画的时间
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  
                                  // 1.第一步代码
                                  // frameStartTime 开始时间占总时间的百分比
                                  // relativeDuration 每一个小的动画占总时间的百分比
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    self.imageView4.centerY -= 10;
                                                                    self.imageView4.centerX += 180;
                                                                }
                                   ];
                                  
                                  // 2.第二步代码
                                  [UIView addKeyframeWithRelativeStartTime:0.1
                                                          relativeDuration:0.4
                                                                animations:^{
                                                                    self.imageView4.transform =
                                                                    CGAffineTransformMakeRotation(-M_PI_4/2);
                                                                }
                                   ];
                                  
                                  // 3.第三步代码
                                  [UIView addKeyframeWithRelativeStartTime:0.25
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    self.imageView4.centerX += 200;
                                                                    self.imageView4.centerY -= 50;
                                                                    self.imageView4.alpha = 0.0;
                                                                }
                                   ];
                                  
                                  // 4.第四步代码
                                  [UIView addKeyframeWithRelativeStartTime:0.25
                                                          relativeDuration:0.0
                                                                animations:^{
                                                                    self.imageView4.centerX = -50;
                                                                }
                                   ];
                                  
                                  // 5.第五步代码
                                  [UIView addKeyframeWithRelativeStartTime:0.51
                                                          relativeDuration:0.1
                                                                animations:^{
                                                                    self.imageView4.centerY = self.view.center.y;
                                                                    self.imageView4.transform = CGAffineTransformMakeRotation(M_PI_4/2);;
                                                                    self.imageView4.alpha = 1.0;
                                                                }
                                   ];
                                  
                                  // 6.第六步代码
                                  [UIView addKeyframeWithRelativeStartTime:0.61
                                                          relativeDuration:0.3
                                                                animations:^{
                                                                    self.imageView4.transform = CGAffineTransformIdentity;
                                                                    self.imageView4.frame = imageView4Frame;
                                                                }
                                   ];
                                  
                              }
                              completion:nil];
}



@end
