//
//  ViewController.m
//  StudyDrive
//
//  Created by Aico on 7/20/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"

@interface ViewController () {
    SelectView *selectView;
}

@end

@implementation ViewController

- (IBAction)clicked:(id)sender {
    [selectView setAlphaToZero];
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
