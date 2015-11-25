//
//  VideoViewController.m
//  TLS
//
//  Created by newtouch on 15/8/22.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "VideoViewController.h"
#import "PlayVideoViewController.h"


@interface VideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSString *cellIdentifier;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) BaseClass *homeInfo;
@property (strong, nonatomic) NSArray *dataAry;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
    cellIdentifier = @"cell";
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}
- (void)loadData{
    _homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
    _dataAry = _homeInfo.video;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataAry.count;
    
}

- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_dataAry[indexPath.row] dictionaryRepresentation];
    NSLog(@"%@",dic);
    /*
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, cell.width - 10, cell.height / 5 * 3)];
    if (indexPath.row%2==0) {
        imageV.image = [UIImage imageWithName:@"Video-1"];
    }else{
        imageV.image = [UIImage imageWithName:@"Video-2"];
    }
    */
    NSString *urlStr;
    NSString *urlStrfirst = [dic objectForKey:@"url"];
    NSArray *imageArray = [urlStrfirst componentsSeparatedByString:@"?"];
    for (NSString *urlString in imageArray) {
        if ([urlString hasPrefix:@"v"]) {
            urlStr = [urlString substringWithRange:NSMakeRange(2, 11)];
            NSLog(@"%@",urlStr);
        }
    }
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, cell.width - 10, cell.height / 5 * 3)];
    imageV.image = [UIImage imageWithName:@"nav-logo"];
    UIImageView *playImage = [[UIImageView alloc]init];
    playImage.size = CGSizeMake(40, 20);
    playImage.center = imageV.center;
    playImage.image = [UIImage imageNamed:@"play"];
    /*
     if (indexPath.row%2==0) {
     imageV.image = [UIImage imageWithName:@"Video-1"];
     }else{
     imageV.image = [UIImage imageWithName:@"Video-2"];
     }
     */
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        dispatch_sync(concurrentQueue, ^{
            /* Download the image here */
            /* iPad's image from Apple's website. Wrap it into two lines as the URL is too long to fit into one line */
            NSString *fileURL = [NSString stringWithFormat:@"http://i.ytimg.com/vi/%@/mqdefault.jpg",urlStr];
            NSURL *url = [NSURL URLWithString:fileURL];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSError *downloadError = nil;
            NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&downloadError];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (downloadError == nil && imageData != nil){
                    imageV.image = [UIImage imageWithData:imageData]; /* We have the image. We can use it now */
                }else if (downloadError != nil){
                    NSLog(@"Error happened = %@", downloadError);
                }
                else
                {
                    NSLog(@"No data could get downloaded from the URL.");
                }
            });
            
        });
    });
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(imageV.frame) , cell.width - 10, cell.height / 5 * 2)];
    label.text = [dic objectForKey:@"type"];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    
    
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:imageV];
    [cell.contentView addSubview:playImage];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_WIDTH / 2 - 20, SCREEN_HEIGHT / 4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_dataAry[indexPath.row] dictionaryRepresentation];
    NSString *urlStrfirst = [dic objectForKey:@"url"];
    NSLog(@"%@",urlStrfirst);
    PlayVideoViewController *playvideo = [[PlayVideoViewController alloc]init];
    playvideo.videoUrl = urlStrfirst;
    [self.navigationController pushViewController:playvideo animated:YES];
    
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
