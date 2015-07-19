
#import "ViewController.h"

#define Count 20.0
#define DurationTime 1.0
@interface ViewController ()
@property (nonatomic,strong) CAReplicatorLayer *replicator;
@property (nonatomic,strong) CALayer *indicator;
@property (nonatomic,strong) CABasicAnimation *anim;
@end

@implementation ViewController

//懒加载，复制层
- (CAReplicatorLayer *)replicator
{
    if (_replicator == nil) {
        _replicator = [CAReplicatorLayer layer];
        _replicator.frame = CGRectMake(50, 50, 200, 200);
        _replicator.backgroundColor = [UIColor clearColor].CGColor;
        // 设置子层次数
        _replicator.instanceCount = Count;
        // 设置子层动画延长时间
        _replicator.instanceDelay = DurationTime / Count;
        // 设置子层形变角度
        CGFloat angle = M_PI * 2 / Count;
        _replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    }
    return _replicator;
}

//普通层
- (CALayer *)indicator
{
    if (_indicator == nil) {
        _indicator = [CALayer layer];
        _indicator.transform = CATransform3DMakeScale(0, 0, 0);
        _indicator.position = CGPointMake(100, 20);
        _indicator.bounds = CGRectMake(0, 0, 10, 10);
        _indicator.cornerRadius = 5;
        _indicator.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _indicator;
}

//动画
- (CABasicAnimation *)anim
{
    if (_anim == nil) {
        _anim = [CABasicAnimation animation];
        
        _anim.keyPath = @"transform.scale";
        _anim.fromValue = @1;
        _anim.toValue = @0.1;
        _anim.repeatCount = MAXFLOAT;
        _anim.duration = DurationTime;
    }
    return _anim;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加复制层
    [self.view.layer addSublayer:self.replicator];
    //添加层
    [self.replicator addSublayer:self.indicator];
    //添加动画
    [self.indicator addAnimation:self.anim forKey:nil];
}


@end
