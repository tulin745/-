//
//  ToolsView.m
//  TLS
//
//  Created by 屠淋 on 15/9/11.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ToolsView.h"

#import "ToolSelectedCell.h"
#import "ToolTextFCell.h"
#import "ToolResultCell.h"

@interface ToolsView()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *_arrayData;
    NSArray *_arraySection;

    NSString *frameSize;
    NSString *frameRateStr;
    NSString *NumberofCamsStr;
    NSString *HoursEachCameraStr;
    NSString *DesiredStorage;

    
    int CameraStream;
    int CameraResolution;
    int VideoQuality;
    
    NSString *StorageRequiredStr;
    NSString * TotalBandwidthRequiredvalueStr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectedCells0;
@property (nonatomic, strong) NSMutableArray *selectedCells1;
@property (nonatomic, strong) NSMutableArray *selectedCells2;

@end

@implementation ToolsView

- (NSMutableArray *)selectedCells0{
    
    if (!_selectedCells0) {
        _selectedCells0 = [NSMutableArray array];
        [self creatSelectedCellsWith:0 array:_selectedCells0];
    }
    return _selectedCells0;
}

- (NSMutableArray *)selectedCells1{
    
    if (!_selectedCells1) {
        _selectedCells1 = [NSMutableArray array];
        [self creatSelectedCellsWith:1 array:_selectedCells1];
    }
    return _selectedCells1;
}

- (NSMutableArray *)selectedCells2{
    
    if (!_selectedCells2) {
        _selectedCells2 = [NSMutableArray array];
        [self creatSelectedCellsWith:2 array:_selectedCells2];
    }
    return _selectedCells2;
    
}


#pragma mark - selectedCells

- (void)creatSelectedCellsWith:(NSInteger)section array:(NSMutableArray *)array{
    
//    for (int i = 0; i < 3; i ++) {
    
        NSArray *arr = _arrayData[section];

    for (int j = 0; j < arr.count; j ++ ) {
            
            ToolSelectedCell *cell = NIB_Load(@"ToolSelectedCell");
            [cell.button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if (j == 0) {
                [cell.button setImage:[UIImage imageNamed:@"kuang-moren"] forState:UIControlStateNormal];
            }else{
                [cell.button setImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal];
            }
            cell.titleLabel.text = arr[j];
        cell.button.tag = section * 10 + j;
            [array addObject:cell];

    }
    
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    CameraStream = 1;
    CameraResolution  = 1;
    VideoQuality  = 1;
    
    frameSize = [NSString stringWithFormat:@"%.6f",[self getAverageFrameSize]];
    frameRateStr = @"";
    NumberofCamsStr = @"";
    HoursEachCameraStr = @"";
    DesiredStorage = @"";
    
    _arrayData = @[@[@"H.264(LTS DVR)",@"MPEG-4"],
                   @[@"CIF (352×240)",@"HD1 (704×240)",@"D1 (704×480)",@"1.3 Megapixel (1280×1024)",@"2.1 Megapixel (1920×1980)",@"3 Megapixel (2048×1536)"],
                   @[@"Highest",@"Normal",@"Low"],
                   @[@[@"Average Frame Size",@"KB" ],@[@"Number of Cameras",@""],@[@"Frame Rate per Camera",@"FPS"],@[@"Hours Each Camera Will Record per Day",@"Hours"]],
                   @[@[@"Desired Storage(Number of Days) per Camera",@""],@[@"Total Bandwidth Required",@"Mbps"],@[@"Per Camera",@"Kbps"],@[@"Estimated Storage",@"GB"]]];
    _arraySection = @[@"Camera Stream",@"Camera Resolution",@"Video Quality"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView reloadData];
    
}




#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return _arraySection.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _arrayData[section];
    return arr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = _arrayData[indexPath.section];
    ToolSelectedCell *cell = nil;
    if (indexPath.section < 3) {
        switch (indexPath.section) {
            case 0:
            {
                cell = self.selectedCells0[indexPath.row];

            }
                break;
            case 1:
            {
                cell = self.selectedCells1[indexPath.row];
                
            }
                break;
                
            default:
            {
                cell = self.selectedCells2[indexPath.row];
                
            }
                
                break;
        }
        return cell;
    }else if(indexPath.section == 3){
        static NSString *cellIdentifier = @"ToolTextFCell";
        ToolTextFCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = NIB_Load(@"ToolTextFCell");
        }
        NSArray *array = arr[indexPath.row];
        cell.titleLabel.text = array[0];
        cell.unitLabel.text = array[1];
        if (indexPath.row == 0) {
            cell.textFeild.enabled = NO;
            cell.textFeild.text = frameSize;
        }else{
            cell.textFeild.enabled = YES;
            cell.textFeild.delegate = self;
            cell.textFeild.tag = indexPath.row;
            switch (indexPath.row) {
                case 1:
                {
                    cell.textFeild.text = NumberofCamsStr;
                }
                    break;
                case 2:
                {
                    cell.pickerDataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"];
                    cell.textFeild.text = frameRateStr;
                    
                }
                    break;
                default:
                    
                {
                    cell.pickerDataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
                    
                    cell.textFeild.text  = HoursEachCameraStr;
                }
                    break;
            }
        }
        
        return cell;
    }else{
        
        static NSString *cellIdentifier = @"ToolResultCell";
        ToolResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = NIB_Load(@"ToolResultCell");
        }
        if (indexPath.row == 0) {
            cell.resultTextFeild.enabled = YES;
            cell.resultTextFeild.text = DesiredStorage;
            cell.resultTextFeild.delegate = self;

        }else{
            cell.resultTextFeild.enabled = NO;
        }
        
        if (indexPath.row == 1) {
            cell.resultTextFeild.text = TotalBandwidthRequiredvalueStr;
        }else if(indexPath.row == 3){
            cell.resultTextFeild.text = StorageRequiredStr;
        }
        
        NSArray *array = arr[indexPath.row];

        cell.titleLabel.text = array[0];
        cell.unitLabel.text = array[1];

        return cell;
        
    }
    
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    headView.backgroundColor = Color_RGB(240, 240, 240);
    if (section < 3) {
        headView.height = 60;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 2, 60)];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.text = _arraySection[section];
        [headView addSubview:label];
    }else{
        headView.height = 10;
    }
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 3) {
        return 60;
        
    }
    return 10;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 60;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

- (void)selectAction:(UIButton*)button{
    
    if (button.tag < 10) {
        
        [self getSelectedCellsButton:self.selectedCells0 andSection:0 andButton:button];

    }else if (button.tag >= 10 && button.tag < 20){
        
        [self getSelectedCellsButton:self.selectedCells1 andSection:1 andButton:button];

    
    }else if(button.tag >= 20 ){
        [self getSelectedCellsButton:self.selectedCells2 andSection:2 andButton:button];

    }

//    
    CGFloat frameSizeF = [self getAverageFrameSize];
    frameSize = [NSString stringWithFormat:@"%.6f",frameSizeF];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self calculate];
}

- (void)getSelectedCellsButton:(NSMutableArray *) array andSection:(int)section andButton:(UIButton *)button{

    for (int j = 0; j < array.count; j ++) {
        ToolSelectedCell *cell = array[j];
        [cell.button setImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal];
        if (button.tag == cell.button.tag) {
            cell.button.selected = YES;
            //取值
            if (section == 0) {
                CameraStream = 1 + j;

            }else if (section == 1){
                CameraResolution  = 1 + j;

            }else{
                VideoQuality  = 1 + j;

            }
        }else{
            cell.button.selected = NO;
        }
    }
    
    
}


#pragma mark - textFeildDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self calculate];
    
}

- (void)calculate{
    
    ToolTextFCell *cell1 = (ToolTextFCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
    ToolTextFCell *cell2 = (ToolTextFCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]];
    ToolTextFCell *cell3 = (ToolTextFCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:3]];
    
    ToolResultCell *cell4 = (ToolResultCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    
    NumberofCamsStr = cell1.textFeild.text;
    frameRateStr = cell2.textFeild.text;
    HoursEachCameraStr = cell3.textFeild.text;
    
    DesiredStorage = cell4.resultTextFeild.text;
    
    double StorageRequired  = (((([frameSize doubleValue] * [frameRateStr doubleValue] * [NumberofCamsStr doubleValue] * 60 * 60 * 24 * [DesiredStorage doubleValue]) / 1000000) / 24) * [HoursEachCameraStr doubleValue]) * 3;
    StorageRequiredStr = [NSString stringWithFormat:@"%.6f",StorageRequired];
    
    double TotalBandwidthRequiredvalue =[frameSize doubleValue] * 12 * [frameRateStr doubleValue] * [NumberofCamsStr doubleValue] /1000;
   TotalBandwidthRequiredvalueStr = [NSString stringWithFormat:@"%.6f",TotalBandwidthRequiredvalue];
    
//     [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:4]] withRowAnimation:UITableViewRowAnimationAutomatic];
//     [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:4]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
}


//计算frame size
- (CGFloat)getAverageFrameSize{
    
    CGFloat framesize = 0.0f;
    
    if (CameraStream == 1) {
        // H264
        if (CameraResolution == 1) {
            if (VideoQuality == 1) {
                framesize = 1.5f;
            } else if (VideoQuality == 2) {
                framesize = 0.928571f;
            } else {
                framesize = 0.571428f;
            }
        } else if (CameraResolution == 2) {
            if (VideoQuality == 1) {
                framesize = 2.857142f;
            } else if (VideoQuality == 2) {
                framesize = 1.785714f;
            } else {
                framesize = 1.071428f;
            }
        } else if (CameraResolution == 3) {
            if (VideoQuality == 1) {
                framesize = 4.285714f;
            } else if (VideoQuality == 2) {
                framesize = 2.857142f;
            } else {
                framesize = 1.642857f;
            }
        } else if (CameraResolution == 4) {
            if (VideoQuality == 1) {
                framesize = 13.928571f;
            } else if (VideoQuality == 2) {
                framesize = 9.285714f;
            } else {
                framesize = 5.357142f;
            }
        } else if (CameraResolution == 5) {
            if (VideoQuality == 1) {
                framesize = 20.571428f;
            } else if (VideoQuality == 2) {
                framesize = 13.714285f;
            } else {
                framesize = 7.857142f;
            }
        } else if (CameraResolution == 6) {
            if (VideoQuality == 1) {
                framesize = 33.714285f;
            } else if (VideoQuality == 2) {
                framesize = 22.5f;
            } else {
                framesize = 13.0f;
            }
        }
    } else {
        // MPEG4
        if (CameraResolution == 1) {
            if (VideoQuality == 1) {
                framesize = 2.333333f;
            } else if (VideoQuality == 2) {
                framesize = 1.444444f;
            } else {
                framesize = 0.888888f;
            }
        } else if (CameraResolution == 2) {
            if (VideoQuality == 1) {
                framesize = 4.444444f;
            } else if (VideoQuality == 2) {
                framesize = 2.777777f;
            } else {
                framesize = 1.666666f;
            }
        } else if (CameraResolution == 3) {
            if (VideoQuality == 1) {
                framesize = 6.666666f;
            } else if (VideoQuality == 2) {
                framesize = 4.444444f;
            } else {
                framesize = 2.555555f;
            }
        } else if (CameraResolution == 4) {
            if (VideoQuality == 1) {
                framesize = 21.666666f;
            } else if (VideoQuality == 2) {
                framesize = 14.444444f;
            } else {
                framesize = 8.333333f;
            }
        } else if (CameraResolution == 5) {
            if (VideoQuality == 1) {
                framesize = 32.0f;
            } else if (VideoQuality == 2) {
                framesize = 21.333333f;
            } else {
                framesize = 12.222222f;
            }
        } else if (CameraResolution == 6) {
            if (VideoQuality == 1) {
                framesize = 52.444444f;
            } else if (VideoQuality == 2) {
                framesize = 35.0f;
            } else {
                framesize = 20.222222f;
            }
        }
    }
    return framesize;

}



@end
