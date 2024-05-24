//
//  SelectedResultTableView.m
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/22.
//

#import "SelectedResultTableView.h"
#import "SelectedResultTableCell.h"
@interface SelectedResultTableView ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSMutableArray<NSArray<MLSelectedNumModel *> *>* selectedArray;

@property (nonatomic, strong) NSMutableArray<MLSelectedNumModel *>* hitModel;
@property (nonatomic, strong) NSMutableArray<NSArray<NSString *> *>* nameArray;
@property (nonatomic, strong) NSMutableArray<NSString *>* results;
@end

@implementation SelectedResultTableView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.selectedArray = [NSMutableArray array];
        self.hitModel = [NSMutableArray array];
        self.nameArray = [NSMutableArray array];
        self.results = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(void)addSelectedArray:(NSArray<MLSelectedNumModel *> *)selectedArray hitModel : (MLSelectedNumModel *) hitModel nameArray:(NSArray<NSString *> *)nameArray result : (int64_t) result{
    [self.selectedArray addObject:[selectedArray copy]];
    [self.hitModel addObject:hitModel];
    [self.nameArray addObject:[nameArray copy]];
    [self.results addObject:[NSString stringWithFormat:@"%lld",result]];
    
    [self reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.selectedArray[self.selectedArray.count - indexPath.row - 1].count + 1) * 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectedArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    bool hit = false;
    for (MLSelectedNumModel * selected in self.selectedArray[self.selectedArray.count - indexPath.row - 1]) {
        if (selected.selectedNum == self.hitModel[self.selectedArray.count - indexPath.row - 1].selectedNum) {
            hit = true;
            break;
        }
    }
    SelectedResultTableCell * cell = [[SelectedResultTableCell alloc]initWithSelectedArray:self.selectedArray[self.selectedArray.count - indexPath.row- 1] hitModel:self.hitModel[self.selectedArray.count - indexPath.row - 1] nameArray:self.nameArray[self.selectedArray.count - indexPath.row - 1] hit:hit result:[self.results[self.selectedArray.count - indexPath.row - 1] longLongValue]];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
