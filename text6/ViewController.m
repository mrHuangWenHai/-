//
//  ViewController.m
//  text6
//
//  Created by 黄文海 on 16/3/3.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UITableView*tab;
    NSArray*array;
    CAShapeLayer*layer;
    UIBezierPath*bigRectPath;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array=@[@"1",@"2",@"3",@"4",@"5",@"6"];
    // Do any additional setup after loading the view, typically from a nib.
    tab=[[UITableView alloc] init];
    tab.delegate=self;
    tab.dataSource=self;
    tab.frame=self.view.bounds;
    
    
    [self.view addSubview:tab];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellId=@"cellId";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text=array[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
CGRect rect = [tableView convertRect:[tableView rectForRowAtIndexPath:indexPath] toView:[tableView superview]];
    
    NSLog(@"%f %f",rect.origin.x,rect.origin.y);
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.layer.shadowOpacity=0.8;
    UIBezierPath*path=[UIBezierPath bezierPath];
    [path moveToPoint:rect.origin];
    [path addLineToPoint:CGPointMake(rect.origin.x+rect.size.width,rect.origin.y )];
    [path addLineToPoint:CGPointMake(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height)];
    [path addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y+rect.size.height)];
    [path addLineToPoint:rect.origin];
    cell.layer.shadowOffset=CGSizeMake(0, -rect.size.height*(indexPath.row));
    cell.layer.shadowColor=[UIColor blackColor].CGColor;
    path.lineWidth=5;
    cell.layer.shadowRadius=5;
    cell.layer.shadowPath=nil;
    CATransition*animation1=[CATransition animation];
    animation1.type=kCATransitionFade;
    animation1.duration=1;
    [cell.layer addAnimation:animation1 forKey:nil];
    cell.layer.shadowPath=path.CGPath;
    cell.layer.zPosition=2;
    
   
    
    
    
    UIView*view=[[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor=[UIColor yellowColor];
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text=@"hello world";
    [view addSubview:label];
    [self.view addSubview:view];
    
    
    layer=[CAShapeLayer layer];
    view.layer.mask=layer;
    UIBezierPath *smallRectPath=[UIBezierPath bezierPathWithRect:rect];
    layer.path=smallRectPath.CGPath;
    layer.strokeColor=[UIColor whiteColor].CGColor;
    
    
    
    bigRectPath=[UIBezierPath bezierPathWithRect:self.view.bounds];
    CABasicAnimation*animation2=[CABasicAnimation animationWithKeyPath:@"path"];
    animation2.toValue=(__bridge id _Nullable)(bigRectPath.CGPath);
    animation2.duration=3;
    animation2.fillMode=kCAFillModeForwards;
    
    CABasicAnimation*animation3=[CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation3.toValue=@200;
    animation3.duration=3;
    //时间的不一致性可以造成组合动画的不协调行
    animation3.fillMode=kCAFillModeForwards;
    
    
    CAAnimationGroup*group=[CAAnimationGroup animation];
    group.animations=@[animation2,animation3];
    group.duration=3;
    group.delegate=self;
    group.fillMode=kCAFillModeForwards;
    [self performSelector:@selector(animation:) withObject:group afterDelay:1];
    
    
}

-(void)animation:(CAAnimationGroup*)group{
    [layer addAnimation:group forKey:nil];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    layer.path=bigRectPath.CGPath;
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.layer.shadowPath=nil;
    cell.layer.shadowColor=[UIColor clearColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
