//
//  DetailViewController.m
//  iOS系统字体大全
//
//  Created by softlipa软嘴唇 on 16/7/24.
//  Copyright © 2016年 softlipa. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    
    NSArray *title;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.92 alpha:1.00];
    
    self.navigationItem.title = self.font;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width*2/3, 44)];
    [label setText:self.font];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:self.font size:18.0f];
    self.navigationItem.titleView = label;
    
    title = [NSArray array];
    title = @[@"0 1 2 3 4 5 6 7 8 9\n",@"a b c d e f g h i j k l m n o p q r s t u v w x y z\nA B C D E F G H I J K L M N O P Q R S T U V W X Y Z",@"螺旋爆炸，病房K歌， 灵堂酒会，丧宴烤尸，\n送葬摇滚，灵车漂移，坟头蹦迪，骨灰拌饭，\n祖坟歌会，宗庙拍片，尸块养猪，脑浆浇花，\n灵堂派对，葬礼庆典，骨髓煮汤，棺木开花。\n"];
    
    [self createLabel];
}


-(void)createLabel {
    
    for (int i = 0; i < 3; i++) {
 
        float width  = [UIScreen mainScreen].bounds.size.width;
        float height = ([UIScreen mainScreen].bounds.size.height - 64)/6;
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:self.font size:20.0f];
        [label setText:title[i]];
        label.numberOfLines = 0;
        
        if (i == 0) {
            
            label.frame = CGRectMake(0, 0, width, height);
           
        } else if (i == 1) {
            
            label.frame = CGRectMake(0, height, width, height*2);
        
        } else if (i == 2) {
            
            label.frame = CGRectMake(0, height*2  + height, width, height*3);
        }
        
        [self.view addSubview:label];
    }
}


@end
