//
//  ViewController.m
//  StudyDrive
//
//  Created by Aico on 7/20/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "FirstViewController.h"

@interface ViewController () {
    SelectView *selectView;
}

@end

@implementation ViewController

- (IBAction)clicked:(UIButton *)sender {
    switch (sender.tag) {
        // 中间
        case 100:
        {
            [selectView setAlphaToZero];
        }
            break;
        // 科目一
        case 101:
        {
            [self.navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
        }
            break;
        // 科目二
        case 102:
        {}
            break;
        // 科目三
        case 103:
        {}
            break;
        // 科目四
        case 104:
        {}
            break;
            
        default:
            break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    selectView = [[SelectView alloc] initWithFrame:self.view.frame andBtn:[self.view viewWithTag:100]];
    [self.view addSubview:selectView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
