//
//  SupportViewController.m
//  TLS
//
//  Created by newtouch on 15/8/18.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SupportViewController.h"

#import "VideoView.h"
#import "KnowledgeView.h"
#import "ToolsView.h"

#import "SearchResultViewController.h"
#import "NewMenuViewController.h"
#import "PlayVideoViewController.h"

@interface SupportViewController ()<NewMenuViewControllerDelegate,VideoViewDelegate>{
    NSArray *titlesArray;
    NSArray *titleImagesArray;
    VideoView *_videoView;
    KnowledgeView *_knowledgeView;
    ToolsView *_toolsView;
}
@property (nonatomic, strong) NSMutableArray *arrayBtn;
@property (nonatomic, strong) UIView* underLineView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (nonatomic, strong)  NewMenuViewController *menuViewController;

@end

@implementation SupportViewController

- (NewMenuViewController*)menuViewController{
    
    if (!_menuViewController ) {
        _menuViewController = [[NewMenuViewController alloc]init];
        _menuViewController.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _menuViewController.delegate = self;
        
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *WD in windows) {
            if (WD != nil) {
                
                [WD addSubview:self.menuViewController.view];
            }
        }
    }
    return _menuViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    
    [self setMenuLeftItem];
    [self setShopRightItem];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav-logo"]];
    imageView.frame = CGRectMake(0,0, 90, 25);
    
    self.navigationItem.titleView = imageView;
    
    [self creatButtonTabBarTexts:@[@"Video",@"Knowledge Base",@"Tools"] withTitleImagesName:@[@"video",@"know",@"tools"]];
    [self addChildVC];
}

- (void)creatButtonTabBarTexts:(NSArray* )texts withTitleImagesName:(NSArray *)imagesName{
    
    titlesArray = texts;
    titleImagesArray = imagesName;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0;  i < texts.count ; i++) {
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:texts[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesName[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (SCREEN_WIDTH == 320) {
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        }
        
        button.frame = CGRectMake(i * SCREEN_WIDTH / texts.count, 5, SCREEN_WIDTH / texts.count, 30);
        button.tag = i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
    }
    
    UIView* lView = [[UIView alloc]initWithFrame:CGRectMake(0, view.height - 2, SCREEN_WIDTH, 2)];
    lView.backgroundColor = Color_RGB(180, 180, 180);
    [view addSubview:lView];
    
    _underLineView = [[UIView alloc]initWithFrame:CGRectMake(0, view.height - 2, SCREEN_WIDTH / texts.count, 2)];
    _underLineView.backgroundColor = Color_RGB(255, 0, 0);
    [view addSubview:_underLineView];
    
    [self.view addSubview:view];
    
}

- (void)titleButtonClick:(UIButton*)btn{
    
    [UIView animateWithDuration:0.3 animations:^{
        _underLineView.frame = CGRectMake(btn.tag * SCREEN_WIDTH / titlesArray.count, _underLineView.y, _underLineView.width, _underLineView.height);
    }];
    
    switch (btn.tag) {
        case 0:
        {
            
            [self.backgroundView addSubview:_videoView];
        }
            break;
        case 1:
        {
            
            [self.backgroundView addSubview:_knowledgeView];
        }
            break;
        case 2:
        {
            
            [self.backgroundView addSubview:_toolsView];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)addChildVC{
    //Video
     _videoView = [[[NSBundle mainBundle]loadNibNamed:@"VideoView" owner:self options:nil] firstObject];
    _videoView.delegate = self;
    [self.backgroundView addSubview:_videoView];

    //Knowledge
    _knowledgeView = [[[NSBundle mainBundle]loadNibNamed:@"KnowledgeView" owner:self options:nil] firstObject];
    
    _knowledgeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 153);
    //Tools
    
    _toolsView = [[[NSBundle mainBundle]loadNibNamed:@"ToolsView" owner:self options:nil] firstObject];;
    _toolsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 153);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MenuViewControllerDelegate

- (void)menuVC:(NewMenuViewController *)vc andInfo:(CategorieInfo *)info{
    
    [vc hidden];
    
    SearchResultViewController *searchVC = [[SearchResultViewController alloc]initWithNibName:@"SearchResultViewController" bundle:nil];
    searchVC.title = info.name;
    searchVC.ID = info.entity_id;

    [self.navigationController pushViewController:searchVC animated:YES];
    
}

#pragma mark - 展开 / 隐藏  菜单

- (void)showMenu{
    
    [self.menuViewController show];
    [self.view endEditing:YES];
}

#pragma mark - VideoViewDelegate

- (void)VideoViewPush:(VideoView *)view andURl:(NSString *)url{
    
    PlayVideoViewController *playvideo = [[PlayVideoViewController alloc]init];
    playvideo.videoUrl = url;
    [self.navigationController pushViewController:playvideo animated:YES];

}




@end
