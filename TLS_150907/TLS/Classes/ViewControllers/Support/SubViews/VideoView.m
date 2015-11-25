//
//  VideoView.m
//  TLS
//
//  Created by 屠淋 on 15/9/11.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "VideoView.h"

#import "PlayVideoViewController.h"
#import "VideoCollectionViewCell.h"
#import "Video.h"

@interface VideoView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *cellIdentifier;

}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) BaseClass *homeInfo;
@property (strong, nonatomic) NSArray *dataAry;

@property (nonatomic, strong) NSMutableDictionary *dicBtn;
@end

@implementation VideoView

- (NSMutableDictionary *)dicBtn{
    
    if (!_dicBtn) {
        _dicBtn = [NSMutableDictionary dictionary];
    }
    return _dicBtn;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self loadData];
    cellIdentifier = @"cell";
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 153);
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    
}

- (void)loadData{
    
    _homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
    _dataAry = _homeInfo.video;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataAry.count;
    
}

- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Video *info = _dataAry[indexPath.row];
    VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:info.image]];
    cell.titleLabel.text = info.type;
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_WIDTH / 2 - 20, self.height / 4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Video *info = _dataAry[indexPath.row];
    
    if (self.delegate  && [self.delegate respondsToSelector:@selector(VideoViewPush:andURl:)]) {
        [self.delegate VideoViewPush:self andURl:info.url];
    }

}


@end
