//
//  AnswerViewController.m
//  StudyDrive
//
//  Created by Aico on 8/14/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@"5", @"4", @"3", @"2", @"1"];
    AnswerScrollView *view = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) WithDataArray:array];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
