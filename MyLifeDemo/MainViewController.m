//
//  MainViewController.m
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/9.
//

#import "MainViewController.h"
#import "GamblingRoomTableViewController.h"
@interface MainViewController ()
<
MLMoneyChangeListener,
MLTimeChangeListener,
MLGameOverListener
>
@property (nonatomic, strong) UILabel* name;
@property (nonatomic, strong) UILabel* salary;
@property (nonatomic, strong) UILabel* saving;
@property (nonatomic, strong) UILabel* time;
@property (nonatomic, strong) MLContext* mlContext;
@property (nonatomic, strong) UIButton * gambleButton;
@property (nonatomic, strong) UIView* gameOverView;
@end

@implementation MainViewController
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)dealloc{
    NSLog(@"dealloc");
}
-(void)createMLContext{
    
    self.mlContext = [[MLContext alloc]initWithName:@"角色名11" salary:1000 savingMoney:1000];
    [self.mlContext.controller save];
    [self addAllListeners];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mlContext = [[MLContext alloc]initWithFile];
    [self addAllListeners];
    [self personView:CGRectMake(10, 80, SCREEN_WIDTH-20, 140)];
    
    UIButton* store = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 260, 200, 20)];
    store.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [store setTitle:@"商店" forState:UIControlStateNormal];
    [store setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [store addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:store];
    
    UIButton* addressList = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 300, 200, 20)];
    addressList.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [addressList setTitle:@"通讯录" forState:UIControlStateNormal];
    [addressList setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addressList addTarget:self action:@selector(addressListClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:addressList];
    
    UIButton* credit = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 340, 200, 20)];
    credit.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [credit setTitle:@"借贷" forState:UIControlStateNormal];
    [credit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [credit addTarget:self action:@selector(creditClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:credit];
    
    self.gambleButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 380, 200, 40)];
    self.gambleButton.backgroundColor = [UIColor redColor];
    [self.gambleButton setTitle:@"来挣大钱" forState:UIControlStateNormal];
    [self.gambleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.gambleButton.tag = 1;
    [self.gambleButton addTarget:self action:@selector(gambleButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.gambleButton];
    
    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.gambleButton.tag == 1) {
            weakSelf.gambleButton.backgroundColor = [UIColor blueColor];
            weakSelf.gambleButton.tag = 2;
        }else{
            weakSelf.gambleButton.backgroundColor = [UIColor redColor];
            weakSelf.gambleButton.tag = 1;
        }
    }];
    
    UIButton* work = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 460, 200, 20)];
    work.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [work setTitle:@"工作" forState:UIControlStateNormal];
    [work setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [work addTarget:self action:@selector(workClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:work];
    
    UIButton* sleep = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 500, 200, 20)];
    sleep.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [sleep setTitle:@"睡觉" forState:UIControlStateNormal];
    [sleep setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sleep addTarget:self action:@selector(sleepClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:sleep];
    
    
    UIButton* again = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 600, 200, 20)];
    again.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [again setTitle:@"重开" forState:UIControlStateNormal];
    [again setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [again addTarget:self action:@selector(againClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:again];
    
    UIButton* saveButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -100, 640, 200, 20)];
    saveButton.backgroundColor = BUTTON_BACKGROUNDCOLOR;
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:saveButton];
    self.gameOverView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, SCREEN_WIDTH - 200, SCREEN_HEIGHT - 400)];
    self.gameOverView.backgroundColor = [UIColor whiteColor];
    self.gameOverView.hidden = YES;
    [self.view addSubview:self.gameOverView];
    // Do any additional setup after loading the view.
}

-(void)addAllListeners{
    [self.mlContext.controller addMoneyChangeListener:self];
    [self.mlContext.controller addTimeChangeListener:self];
    [self.mlContext.controller addGameOverListener:self];
}
-(void)personView:(CGRect) frame{
    UIView *persionView = [[UIView alloc]initWithFrame:frame];
    persionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:persionView];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 20)];
    self.time.backgroundColor = [UIColor whiteColor];
    self.time.textColor = [UIColor blackColor];
    self.time.text = [NSString stringWithFormat:@"当前时间：%@",self.mlContext.controller.getTimeString];
    
    [persionView addSubview:self.time];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 20)];
    self.name.backgroundColor = [UIColor whiteColor];
    self.name.textColor = [UIColor blackColor];
    self.name.text = [NSString stringWithFormat:@"名称：%@",self.mlContext.controller.getPersonName];
    [persionView addSubview:self.name];
    
    self.salary = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, frame.size.width, 20)];
    self.salary.backgroundColor = [UIColor whiteColor];
    self.salary.textColor = [UIColor blackColor];
    self.salary.text = [NSString stringWithFormat:@"工资：%lld 元/日",self.mlContext.controller.getSalary];
    [persionView addSubview:self.salary];
    
    self.saving = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, frame.size.width, 20)];
    self.saving.backgroundColor = [UIColor whiteColor];
    self.saving.textColor = [UIColor blackColor];
    self.saving.text = [NSString stringWithFormat:@"存款：%lld 元",self.mlContext.controller.getSavingMoney];
    [persionView addSubview:self.saving];
    
    
}

-(void)gameOver:(NSString *) gameOverStr{
    self.gameOverView.hidden = NO;
    UILabel* gameOverTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.gameOverView.frame.size.width /2 - 40, 10, 80, 30)];
    gameOverTitle.backgroundColor = [UIColor whiteColor];
    gameOverTitle.text = @"游戏结束";
    gameOverTitle.textColor = [UIColor redColor];
    [self.gameOverView addSubview:gameOverTitle];

    UITextView* gameOver = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, self.gameOverView.frame.size.width - 20, 100)];
    gameOver.backgroundColor = [UIColor whiteColor];
    gameOver.font = [UIFont systemFontOfSize:20];
    gameOver.textContainer.maximumNumberOfLines = 0;
    gameOver.textContainer.widthTracksTextView = true;
    gameOver.contentSize = CGSizeMake(gameOver.frame.size.width, gameOver.frame.size.height);
    gameOver.text = [NSString stringWithFormat:@"%@",gameOverStr];
    gameOver.textColor = [UIColor redColor];
    gameOver.userInteractionEnabled = false;
    gameOver.editable = false;
    
    [self.gameOverView addSubview:gameOver];
    
    UIButton* gameOverOkButton = [[UIButton alloc] initWithFrame:CGRectMake(self.gameOverView.frame.size.width/2 - 30, self.gameOverView.frame.size.height - 100, 60, 60)];
    gameOverOkButton.backgroundColor = COLOR_RGB(59, 135, 247, 1);
    [gameOverOkButton setTitle:@"确认" forState:UIControlStateNormal];
    [gameOverOkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gameOverOkButton addTarget:self action:@selector(gameOverOkButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.gameOverView addSubview:gameOverOkButton];
    
}
# pragma mark 按钮点击事件
-(void)storeClick:(UIButton *) sender{
    
}
-(void)addressListClick:(UIButton *) sender{
    
}
-(void)creditClick:(UIButton *) sender{
    
}
-(void)gambleButtonClick:(UIButton *) sender{
    GamblingRoomTableViewController * gambling = [[GamblingRoomTableViewController alloc]initWithContext:self.mlContext];
    [self.navigationController pushViewController:gambling animated:YES];
}
-(void)saveButtonClick:(UIButton *)sender{
    [self.mlContext.controller save];
}
-(void)sleepClick:(UIButton *) sender{
    
    [self.mlContext.controller sleep];
}
-(void)againClick:(UIButton *)sender{
    [self createMLContext];
}
-(void)workClick:(UIButton *) sender{
    [self.mlContext.controller work];
}

-(void)gameOverOkButtonClick:(UIButton *) sender{
    self.gameOverView.hidden = YES;
}
# pragma mark 监听函数
- (void)onMoneyChange:(NSString *)name money:(int64_t)money{
    self.saving.text = [NSString stringWithFormat:@"存款：%lld 元",money];
}
- (void)onTimeChange:(NSString *)name time:(int64_t)time timeString:(NSString *)timeString{
    
    self.time.text = [NSString stringWithFormat:@"当前时间：%@",timeString];
}

- (void)onGameOverFailedWithType:(MLGameFailedType)type{
    switch (type) {
        case NO_SLEEP_TOO_LONG:
            [self gameOver:@"太长时间未睡觉，过劳死"];
            break;
            
        default:
            break;
    }
}
@end

