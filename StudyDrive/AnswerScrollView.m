//
//  AnswerScrollView.m
//  StudyDrive
//
//  Created by Aico on 8/12/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#import "AnswerViewController.h"
#define SIZE self.frame.size
static NSString *const REUSEMAINCELLID = @"mainTableCell";
static NSString *cellID = @"AnswerTableViewCell";

@interface AnswerScrollView()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, AnswerViewControllerDelegate>{

}
@end

@implementation AnswerScrollView {
    UIScrollView *_scrollView;
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    UITableView *_mainTableView;
}

- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)array {
    
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        _dataArray = [[NSArray alloc] initWithArray:array];
        _hadAnsweredArray = [[NSMutableArray alloc] init];
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        for (int i=0; i<array.count; i++) {
            [_hadAnsweredArray addObject:@"0"];
        }
        _scrollView.delegate = self;
        _leftTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        [_mainTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        [_leftTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        [_rightTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        if (_currentPage || _dataArray.count > 1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width * 2, 0);
        }
        
        [self createView];
    }
    return self;
    
}

- (void)createView {
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _leftTableView.frame = CGRectMake(2 * SIZE.width, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    AnswerModel *model = [self getTheFitModel:tableView];
    CGFloat height;
    if ([model.mtype intValue] == 1) {
        NSString *str = [[Tools getAnswerWithString:model.mquestion] firstObject];
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str WithFont:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    } else {
        NSString *str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str WithFont:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    }
    return MAX(height, 80);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AnswerModel *model = [self getTheFitModel:tableView];
    CGFloat height;
    NSString *str;
    if ([model.mtype intValue] == 1) {
        str = [[Tools getAnswerWithString:model.mquestion] firstObject];
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str WithFont:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    } else {
        str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str WithFont:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, height-20)];
    label.text = [NSString stringWithFormat:@"%d.%@", [self getQuestionNumber:tableView AndCurrentPage:_currentPage], str];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;

    [view addSubview:label];
    
    return view;
}

- (int)getQuestionNumber:(UITableView *)tableView AndCurrentPage:(int)page {
    if (tableView == _leftTableView) {
        if (page == 0) {
            return 1;
        } else {
            return page;
        }
    } else if (tableView == _mainTableView) {
        if (page > 0 && page <_dataArray.count-1) {
            return page + 1;
        } else if (page == 0) {
            return 2;
        } else if (page == _dataArray.count-1) {
            return page;
        }
    } else if (tableView == _rightTableView) {
        if (page < _dataArray.count - 1) {
            return page + 2;
        } else if (page == _dataArray.count-1) {
            return page + 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.numberLabel.text = [NSString stringWithFormat:@"%c", (char)('A' + indexPath.row)];
    
    AnswerModel *model = [self getTheFitModel:tableView];
    
    if ([model.mtype intValue] == 1) {
        cell.answerLabel.text = [[Tools getAnswerWithString:model.mquestion] objectAtIndex:indexPath.row+1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    int page = [self getQuestionNumber:tableView AndCurrentPage:_currentPage];
    if ([_hadAnsweredArray[page-1] intValue] != 0) {
        if ([model.manswer isEqualToString:[NSString stringWithFormat:@"%c", 'A'+(int)indexPath.row]]) {
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"19.png"];
            cell.numberLabel.hidden = YES;
        } else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c", 'A'+[_hadAnsweredArray[page-1] intValue]-1]] && indexPath.row == [_hadAnsweredArray[page-1] intValue]-1) {
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"20.png"];
        } else {
            cell.numberImage.hidden = YES;
        }
    } else {
        cell.numberImage.hidden = YES;
        cell.numberLabel.hidden = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    AnswerModel *model = [self getTheFitModel:tableView];
    NSString *str = [NSString stringWithFormat:@"答案解析：%@", model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    return [Tools getSizeWithString:str WithFont:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    AnswerModel *model = [self getTheFitModel:tableView];
    NSString *str = [NSString stringWithFormat:@"答案解析：%@", model.mdesc];
    CGFloat height = [Tools getSizeWithString:str WithFont:[UIFont systemFontOfSize:16] WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width-20, view.frame.size.height-20)];
    label.text = str;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.textColor = [UIColor greenColor];
    [view addSubview:label];
    
    int page = [self getQuestionNumber:tableView AndCurrentPage:_currentPage];
    if ([_hadAnsweredArray[page - 1] intValue] != 0) {
        return view;
    }
    
    return nil;
}

- (AnswerModel *)getTheFitModel:(UITableView *)tableView {
    AnswerModel *model;
    if(tableView == _leftTableView) {
        if (_currentPage == 0) {
            model = _dataArray[_currentPage];
        } else {
            model = _dataArray[_currentPage - 1];
        }
    } else if (tableView == _mainTableView) {
        if (_currentPage == 0) {
            model = _dataArray[_currentPage + 1];
        } else if (_currentPage == _dataArray.count-1) {
            model = _dataArray[_currentPage - 1];
        } else {
            model = _dataArray[_currentPage];
        }
    } else if (tableView == _rightTableView) {
        if (_currentPage == _dataArray.count-1) {
            model = _dataArray[_currentPage];
        } else {
            model = _dataArray[_currentPage + 1];
        }
    }
    
    return model;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int page = [self getQuestionNumber:tableView AndCurrentPage:_currentPage];
    if ([_hadAnsweredArray[page-1] intValue] != 0) {
        return;
    } else {
        [_hadAnsweredArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
    }
    [self reloadData];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currentOffset = scrollView.contentOffset;
    int page = (int)(currentOffset.x / SIZE.width);
    if (page < _dataArray.count-1 && page > 0) {
        _scrollView.contentSize = CGSizeMake(currentOffset.x+SIZE.width*2, 0);
        _leftTableView.frame = CGRectMake(currentOffset.x - SIZE.width, 0, SIZE.width, SIZE.height);
        _mainTableView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _rightTableView.frame = CGRectMake(currentOffset.x + SIZE.width, 0, SIZE.width, SIZE.height);
    }
    _currentPage = page;
    [self reloadData];
}

- (void)reloadData {
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_mainTableView reloadData];
}

# pragma mark - AnswerViewController delegate
- (void)refreshMainTableData {
    [_mainTableView reloadData];
}

@end
