//
//  SelectedResultTableView.h
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/22.
//

#import <UIKit/UIKit.h>
#import <MyLife/MLSelectedNumModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface SelectedResultTableView : UITableView
-(instancetype)init;
-(void)addSelectedArray:(NSArray<MLSelectedNumModel *> *)selectedArray hitModel : (MLSelectedNumModel *) hitModel nameArray:(NSArray<NSString *> *)nameArray result : (int64_t) result;

@end

NS_ASSUME_NONNULL_END
