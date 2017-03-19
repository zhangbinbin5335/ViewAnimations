//
//  LayerAnimationsVC.m
//  Animations
//
//  Created by zhangbinbin on 2017/3/19.
//  Copyright © 2017年 zhangbinbin. All rights reserved.
//

#import "LayerAnimationsVC.h"

@interface LayerAnimationsVC ()
<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@end

@implementation LayerAnimationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.Layer Animations的基本使用
    
    /**
     *    Layer可以自定义动画的属性
     *
     *      位置和尺寸: bounds position transform
     *      边框: borderColor borderWidth cornerRadius
     *      阴影: shadowOffset shadowOpacity shadowPath shadowRadius
     *      内容: contents mask opacity
     *      等等,以上仅仅只是一部分.
     */
}

// CABasicAnimation:CAPropertyAnimation
- (IBAction)startBaseAnimation:(id)sender {
    
    //CABasicAnimation
    CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    // 开始时的位置
//    baseAnimation.fromValue = @20; // 默认从当前位置开始动画
    // 结束时的位置
    baseAnimation.toValue = @200;
    // 动画时间
    baseAnimation.duration = 2;
    // 延迟0.3执行
    baseAnimation.beginTime = CACurrentMediaTime() + .3;
    
    /**
     *  动画执行完毕，默认是回到初始状态
     *  可以通过修改fillMode，改变动画结束后的状态
     *  
     *  kCAFillModeRemoved : 默认样式 动画结束后会回到layer的开始的状态
     *  kCAFillModeForwards : 动画结束后,layer会保持结束状态
     *  kCAFillModeBackwards : layer跳到fromValue的值处,然后从fromValue到toValue播放动画,最后回到layer的开始的状态
     *  kCAFillModeBoth : kCAFillModeForwards和kCAFillModeBackwards的结合,即动画结束后layer保持在结束状态
     */
    
    // 保证fillMode起作用
    baseAnimation.removedOnCompletion = NO;
    // 动画结束后,layer会保持结束状态
    baseAnimation.fillMode = kCAFillModeForwards; // layer虽然保持在结束状态，但是imageView的位置其实并没有改变
    
    // 动画代理
    baseAnimation.delegate = self;
    
    // 用KVC设置一个name然后在代理中做一下判断,就可以区分动画了
    [baseAnimation setValue:@"from" forKey:@"name"];
    [baseAnimation setValue:self.imageView.layer forKey:@"layer"];
    
    [self.imageView.layer addAnimation:baseAnimation forKey:@"position"];
}

- (void) stopView:(UIView*)view animationForKey:(NSString*)key{
    // 停止动画
    // 添加到需要终止的地方,就可以随时终止动画了
    [view.layer removeAnimationForKey:key];
    // 移除dogImageView上所有动画
    [view.layer removeAllAnimations];
}


- (IBAction)startSpringAnimation:(id)sender {
    
    [self stopView:self.imageView animationForKey:@"position"];
    
    /**
     *  CASpringAnimation的重要属性:
     *
     *  mass：质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
     *  stiffness：弹性系数（弹性系数越大，弹簧的运动越快）
     *  damping：阻尼系数（阻尼系数越大，弹簧的停止越快)
     *  initialVelocity：初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
     *  settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
     */
    
    CASpringAnimation* springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.fromValue = @1.5;
    springAnimation.toValue = @1;
    
    // settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
    springAnimation.duration = springAnimation.settlingDuration;
    // mass：质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大) 默认值为1
//    springAnimation.mass = 10.0;
    // stiffness：弹性系数（弹性系数越大，弹簧的运动越快）默认值为100
//    springAnimation.stiffness = 50.;
    // damping：阻尼系数（阻尼系数越大，弹簧的停止越快）默认值为10
    springAnimation.damping = 50;
    // initialVelocity：初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）默认值为0
    springAnimation.initialVelocity = 100;
    
    [self.imageView2.layer addAnimation:springAnimation forKey:nil];
}
- (IBAction)startGroupAnimation:(id)sender {
    
    // CAAnimationGroup
    
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    // 延迟1秒
    animationGroup.beginTime = CACurrentMediaTime() + 1;
    // 整个动画时间
    animationGroup.duration = 3;
    
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeBoth;
    
    // 缓慢加速缓慢减速
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    // 重复次数
    animationGroup.repeatCount = 4.5;
    // 来回往返执行
    animationGroup.autoreverses = YES;
    // 速度
    animationGroup.speed = 2.0;
    
    CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAnimation.fromValue = @1.5;
    baseAnimation.toValue = @1.0;
    
    CABasicAnimation* roate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    roate.fromValue = @(M_PI_4);
    
    roate.toValue = @0.0;
    
    CABasicAnimation* fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @0.5;
    fade.toValue = @1.0;
    
    animationGroup.animations = @[baseAnimation, roate, fade];
    [self.imageView3.layer addAnimation:animationGroup forKey:nil];
}

#pragma mark -- CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animationDidStart %@",anim);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animationDidStop %@ finished %d",anim,flag);
    NSLog(@"self.imageView=%@",self.imageView); // layer虽然保持在结束状态，但是imageView的位置其实并没有改变
    
    //
    NSString* name = [anim valueForKey:@"name"];
    if ([name isEqualToString:@"from"]) {
        
        CALayer* layer = [anim valueForKey:@"layer"];
        
        // 动画结束后设置一个先放大然后缩小的效果
        CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [anim setValue:nil forKey:@"layer"];
        baseAnimation.fromValue = @1.25;
        baseAnimation.toValue = @1;
        baseAnimation.duration = 2;
        
        [layer addAnimation:baseAnimation forKey:nil];
    }
}


@end
