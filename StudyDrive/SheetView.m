//
//  SheetView.m
//  StudyDrive
//
//  Created by Aico on 8/31/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "SheetView.h"

@interface SheetView(){
//    UIView *_backView;
    UIView *_superView;
    BOOL _startMoving;
    float _height;
    float _width;
    float _y;
    UIScrollView *_scrollView;
    int _count;
}
@end

@implementation SheetView

- (instancetype)initWithFrame:(CGRect)frame WithSuperView:(UIView *)superView AndQuestionsCount:(int)num {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _height = frame.size.height;
        _width = frame.size.width;
        _y = frame.origin.y;
        _superView = superView;
        _count = num;
        [self createView];
    }
    return self;
}

- (void)createView {
    _backView = [[UIView alloc] initWithFrame:_superView.frame];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0;
    [_superView addSubview:_backView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height-70)];
    [self addSubview:_scrollView];
    
    for (int i=0; i<_count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((_width-44*6)/2+44*(i%6), 10+44*(i/6), 40, 40);
        btn.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        if (i==0) {
            btn.backgroundColor = [UIColor orangeColor];
        }
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        [_scrollView addSubview:btn];
    }
    int tip = (_count % 6) ? 1 : 0;
    _scrollView.contentSize = CGSizeMake(0, 20+44*(_count/6+1) + tip);
}

- (void)click:(UIButton *)btn {
    int index = (int)btn.tag - 100;
    
    for (int i=0; i<_count-1; i++) {
        UIButton *button = [self viewWithTag:i+101];
        if (i != index-1) {
            button.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        } else {
            button.backgroundColor = [UIColor orangeColor];
        }
    }
    [self.delegate sheetViewClick:index];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    if (point.y < 25) {
        _startMoving = YES;
    }
    CGPoint point2 = [self convertPoint:point toView:_superView];
    if (_startMoving && self.frame.origin.y >= _y-_height && point2.y > 80) {
        self.frame = CGRectMake(0, point2.y, _width, _height);
        float offset = (_superView.frame.size.height - self.frame.origin.y) / _superView.frame.size.height * 0.8;
        _backView.alpha = offset;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _startMoving = NO;
    void(^action)();
    if (self.frame.origin.y > _y-_height/2) {
        action = ^{
            self.frame = CGRectMake(0, _y, _width, _height);
            _backView.alpha = 0;
        };
    } else {
        action = ^{
            self.frame = CGRectMake(0, _y-_height+60, _width, _height);
            _backView.alpha = 0.8;
        };
    }
    [UIView animateWithDuration:0.3 animations:^{
        action();
    }];
}

@end
