//
//  GamblingRoomTableViewCell.h
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/22.
//

#import <UIKit/UIKit.h>
#import <MyLife/MLContext.h>
NS_ASSUME_NONNULL_BEGIN

@interface GamblingRoomTableViewCell : UITableViewCell

-(instancetype)initWithContext:(MLContext*)context roomArray : (NSArray *) roomArray;
@end

NS_ASSUME_NONNULL_END
