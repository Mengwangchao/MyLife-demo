//
//  GamblingRoomTableViewCell.m
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/22.
//

#import "GamblingRoomTableViewCell.h"
#import <MyLife/MLGetRandomHelper.h>
@interface GamblingRoomTableViewCell()
@property (nonatomic, strong) MLContext* mlContext;
@property (nonatomic, strong) NSArray* roomArray;
@end
@implementation GamblingRoomTableViewCell


-(instancetype)initWithContext:(MLContext*)context roomArray : (NSArray *) roomArray{
    self = [super init];
    if (self) {
        self.mlContext = context;
        self.roomArray = roomArray;
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 30)];
        title.backgroundColor = [UIColor whiteColor];
        title.text = self.roomArray[0];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        
        UILabel* personNumTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 60, 30)];
        personNumTitle.backgroundColor = [UIColor whiteColor];
        personNumTitle.text = @"在线人数: ";
        personNumTitle.textColor = [UIColor blackColor];
        personNumTitle.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:personNumTitle];
        
        UILabel* personNum = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, self.frame.size.width - 60, 30)];
        personNum.backgroundColor = [UIColor whiteColor];
        personNum.text = [NSString stringWithFormat:@"%d",[MLGetRandomHelper getRandomWithRangeMin:0 max:1000]];
        personNum.textColor = [UIColor redColor];
        personNum.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:personNum];
        
        
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
