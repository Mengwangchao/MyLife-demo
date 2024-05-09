//
//  MainViewController.m
//  MyLifeDemo
//
//  Created by Dynasty Dream on 2024/5/9.
//

#import "MainViewController.h"

@interface MainViewController ()
<
MLMoneyChangeListener,
MLTimeChangeListener
>
@property (nonatomic, strong) UILabel* name;
@property (nonatomic, strong) UILabel* salary;
@property (nonatomic, strong) UILabel* saving;
@property (nonatomic, strong) UILabel* time;
@property (nonatomic, strong) MLContext* mlContext;
@property (nonatomic, strong) UIButton * gambleButton;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mlContext = [[MLContext alloc]initWithName:@"角色名11" salary:1000 savingMoney:1000];
    
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
    
    [self addAllListeners];
    // Do any additional setup after loading the view.
}

-(void)addAllListeners{
    [self.mlContext.controller addMoneyChangeListener:self];
    [self.mlContext.controller addTimeChangeListener:self];
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

# pragma 按钮点击事件
-(void)storeClick:(UIButton *) sender{
    
}
-(void)addressListClick:(UIButton *) sender{
    
}
-(void)creditClick:(UIButton *) sender{
    
}
-(void)gambleButtonClick:(UIButton *) sender{
    
}
-(void)sleepClick:(UIButton *) sender{
    
    [self.mlContext.controller sleep];
}

-(void)workClick:(UIButton *) sender{
    [self.mlContext.controller work];
}

# pragma 监听函数
- (void)onMoneyChange:(NSString *)name money:(int64_t)money{
    self.saving.text = [NSString stringWithFormat:@"存款：%lld 元",money];
}
- (void)onTimeChange:(NSString *)name time:(int64_t)time timeString:(NSString *)timeString{
    
    self.time.text = [NSString stringWithFormat:@"当前时间：%@",timeString];
}

@end

