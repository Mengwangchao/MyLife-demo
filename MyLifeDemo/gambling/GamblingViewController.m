//
//  GamblingViewController.m
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/22.
//

#import "GamblingViewController.h"
#import "SelectedResultTableView.h"
@interface GamblingViewController ()

@property (nonatomic, strong) MLContext* mlContext;
@property (nonatomic, strong) NSArray* roomArray;
@property (nonatomic, strong) NSMutableArray<UIButton *>* selectedButtonArray;
@property (nonatomic, strong) SelectedResultTableView *resultTableView;
@end

@implementation GamblingViewController

-(instancetype)initWithContext:(MLContext*)context roomArray : (NSArray *) roomArray{
    self = [super init];
    if (self) {
        self.mlContext = context;
        self.roomArray = roomArray;
        self.selectedButtonArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, 60, 60, 30)];
    title.backgroundColor = [UIColor whiteColor];
    title.text = self.roomArray[0];
    title.textColor = [UIColor blackColor];
    [self.view addSubview:title];
    
    for (int i = 1; i< self.roomArray.count; i++) {
        UIButton* numButton = [[UIButton alloc] initWithFrame:CGRectMake(((i-1)%5)*(SCREEN_WIDTH - 6 * 10)/5 + 10 * ((i-1)%5) + 10, (i - 1) / 5 * 120 + 120, (SCREEN_WIDTH - 6 * 10)/5, 60)];
        numButton.backgroundColor = [UIColor grayColor];
        [numButton setTitle:self.roomArray[i] forState:UIControlStateNormal];
        [numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [numButton addTarget:self action:@selector(numButtonClick:) forControlEvents:UIControlEventTouchDown];
        numButton.tag = i -1;
        [self.view addSubview:numButton];
        [self.selectedButtonArray addObject:numButton];
    }
    
    UIButton* submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 90 + 180 * (self.roomArray.count -1) / 5, 100, 50)];
    submit.backgroundColor = [UIColor blueColor];
    [submit setTitle:@"确认" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submit];
    
    self.resultTableView = [[SelectedResultTableView alloc]init];
    self.resultTableView.frame = CGRectMake(0, submit.frame.size.height + submit.frame.origin.y + 10, SCREEN_WIDTH, SCREEN_HEIGHT - submit.frame.size.height - submit.frame.origin.y - 10);
    self.resultTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.resultTableView];
    // Do any additional setup after loading the view.
}

-(void)numButtonClick:(UIButton * )sender{
    for (int i = 0; i< [self.mlContext.controller getSelectedNumArray].count; i++) {
        if ([self.mlContext.controller getSelectedNumArray][i].selectedNum == sender.tag) {
            
            [self.mlContext.controller removeSelectedNum:[self.mlContext.controller getSelectedNumArray][i]];
            sender.backgroundColor = [UIColor grayColor];
            return;
        }
    }
    sender.backgroundColor = [UIColor redColor];
    MLSelectedNumModel * model = [[MLSelectedNumModel alloc]init];
    model.selectedNum = (int)sender.tag;
    model.putMoney = 100;
    [self.mlContext.controller addSelectedNum:model];
}

-(void)submitClick :(UIButton * )sender{
    [self.mlContext.controller selectedNumMin:0 selectedMax:10 callback:^(BOOL isHit, int64_t result , MLSelectedNumModel * _Nonnull selectedModel) {
        UILabel* resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        resultLabel.backgroundColor = [UIColor blueColor];
        resultLabel.textColor = [UIColor redColor];
        [self.view addSubview:resultLabel];
        if (isHit) {
            resultLabel.text = [NSString stringWithFormat:@"中了 : %d",selectedModel.selectedNum];
        }else{
            resultLabel.text = [NSString stringWithFormat:@"没中 : %d",selectedModel.selectedNum];
        }
        [self.resultTableView addSelectedArray:[self.mlContext.controller getSelectedNumArray]  hitModel:selectedModel nameArray:self.roomArray result:result];
        [NSTimer scheduledTimerWithTimeInterval:10 repeats:NO block:^(NSTimer * _Nonnull timer) {
                [resultLabel removeFromSuperview];
        }];
    }];
    for (UIButton * seletedButton in self.selectedButtonArray) {
        seletedButton.backgroundColor = [UIColor grayColor];
    }
    [self.mlContext.controller removeAllSelectedNum];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
