//
//  SelectedResultTableCellTableViewCell.m
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/22.
//

#import "SelectedResultTableCell.h"
@interface SelectedResultTableCell ()

@end
@implementation SelectedResultTableCell
-(instancetype)initWithSelectedArray:(NSArray<MLSelectedNumModel *> *)selectedArray hitModel : (MLSelectedNumModel *) hitModel nameArray:(NSArray<NSString *> *)nameArray hit : (bool)hit result : (int64_t) result{
    self = [super init];
    if (self) {
        int i = 0;
        for (MLSelectedNumModel * seleted in selectedArray) {
            UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + i*40, self.frame.size.width - 20, 30)];
            title.backgroundColor = [UIColor whiteColor];
            title.text = [NSString stringWithFormat:@"选择了 : %@  投资 : %d",nameArray[seleted.selectedNum + 1],seleted.putMoney];
            title.textColor = [UIColor blackColor];
            [self.contentView addSubview:title];
            i++;
        }
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + i*40, self.frame.size.width - 20, 30)];
        title.backgroundColor = [UIColor whiteColor];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        if (hit) {
            title.text = [NSString stringWithFormat:@"中奖号码 ：%@ , 赚了： %lld",nameArray[hitModel.selectedNum + 1], result];
        }else{
            title.text = [NSString stringWithFormat:@"中奖号码 ：%@ , 亏了： %lld",nameArray[hitModel.selectedNum + 1], result];
        }
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
