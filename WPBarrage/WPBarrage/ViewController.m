//
//  ViewController.m
//  WPBarrage
//
//  Created by 吴鹏 on 16/8/22.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSInteger count;
}

@property (nonatomic , strong) NSMutableArray * contentArray;
@property (nonatomic , strong) NSMutableArray * noOccupiedArray;
@property (nonatomic , strong) NSArray * contentStr;

@property (nonatomic , strong) NSTimer * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = [NSMutableArray array];
    
    self.contentStr = @[@"这是一个弹幕demo的测试,写的不好希望大家体谅",
                        @"我很nb",
                        @"6666666666",
                        @"666",
                        @"社会我k哥人狠话不多",
                        @"k哥无敌",
                        @"好污",
                        @"我p强无敌",
                        @"我支持我p",
                        @"我是一个分割线",
                        @"我p我喜欢你",
                        @"老公强无敌",
                        @"五十一刀",
                        @"k哥,袁世凯,幼儿园",
                        @"66666666666666666666",
                        @"这波操作 我给82分,剩下的我已666的形式给你"];
    
    for(NSInteger i = 0 ; i < self.contentStr.count ;i++)
    {
        [self.contentArray addObjectsFromArray:self.contentStr];
    }
    self.noOccupiedArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor blackColor];
    [self getRunwayArray];
    
    count = 0;
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(creatLabel) userInfo:nil repeats:YES];
    
    UIButton * sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 30, 100, 30)];
    sendBtn.backgroundColor = [UIColor whiteColor];
    [sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
}

- (void)sendClick
{
    NSDictionary * dic = self.noOccupiedArray[arc4random()%self.noOccupiedArray.count];
    
    CGSize size = [self getStringRect:@"这个是我说的"];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), [[dic objectForKey:@"y"] floatValue], size.width, size.height)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor greenColor];
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.text = @"这个是我说的";
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         label.frame = CGRectMake(-200, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
                     } completion:^(BOOL finished) {
                         [label removeFromSuperview];
                     }];
}

- (void)getRunwayArray
{
    for(NSInteger i = 0 ;i < (CGRectGetHeight(self.view.frame) - 30)/30 ;i++)
    {
        NSDictionary * dic = @{@"y":@(i*30)};
        [self.noOccupiedArray addObject:dic];
    }
}

- (void)creatLabel
{
    
    if(count >= self.contentArray.count)
    {
        return;
    }
    
    NSString * str = self.contentArray[count];
    
    if(self.contentArray.count <= 0)
        return;
    
    
    NSDictionary * dic = self.noOccupiedArray[arc4random()%self.noOccupiedArray.count];
    CGSize size = [self getStringRect:str];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), [[dic objectForKey:@"y"] floatValue],size.width , size.height)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = str;
    [self.view addSubview:label];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        label.frame = CGRectMake(-200, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];

    count ++;
}

- (CGSize)getStringRect:(NSString*)aString

{
    UIFont * font = [UIFont systemFontOfSize:18];
    
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attribute = @{NSFontAttributeName: font,
                                NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize retSize = [aString boundingRectWithSize:CGSizeMake(10000, 30) options:
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    return retSize;
    
}





@end
