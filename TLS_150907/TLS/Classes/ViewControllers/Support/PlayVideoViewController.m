//
//  PlayVideoViewController.m
//  TLS
//
//  Created by newtouch on 15/8/25.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "PlayVideoViewController.h"

@interface PlayVideoViewController ()<UIWebViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIView *bgView;

@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
    
//    self.webView.scrollView.scrollEnabled = NO;
    [self loadHTMLString:_videoUrl];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav-logo"]];
    imageView.frame = CGRectMake(0,0, 90, 25);
    
    self.navigationItem.titleView = imageView;
    
}

-(void)loadHTMLString:(NSString *)videoUrl{
    
    self.webView.delegate = self;
    NSString *htmlPath = videoUrl;
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = [UIColor blackColor];
    [_bgView setAlpha:0.6];
    UIActivityIndicatorView *activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activeView.centerX = _bgView.centerX;
    activeView.centerY = _bgView.centerY-32;
    
    [activeView startAnimating];
    [_bgView addSubview:activeView];
    [self.webView addSubview:_bgView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载结束");
    [_bgView removeFromSuperview];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"ERROR:%@",error);
    NSLog(@"加载失败");
    [self.view  alertViewShowWithMessage:@"There was a problem, please try again later." View:self.navigationController.view];
    [_bgView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
