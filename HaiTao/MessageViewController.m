//
//  MessageViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "MessageViewController.h"
#import "ChartMessage.h"
#import "ChartCellFrame.h"
#import "ChartCell.h"
#import "KeyBordVIew.h"
#import "UIImage+StrethImage.h"
#import "NSString+DocumentPath.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface MessageViewController()<UITableViewDataSource,UITableViewDelegate,KeyBordVIewDelegate,ChartCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) KeyBordVIew *keyBordView;
@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic,assign) BOOL recording;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;
@end

static NSString *const cellIdentifier=@"QQChart";

@implementation MessageViewController
@synthesize segmentedControl;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add UItableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    [self.tableView registerClass:[ChartCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
    //add keyBorad
    
    self.keyBordView=[[KeyBordVIew alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    self.keyBordView.delegate=self;
    [self.view addSubview:self.keyBordView];
    //初始化数据
    
    [self initwithData];
    
}
-(void)initwithData
{
    
    self.cellFrames=[NSMutableArray array];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *data=[NSArray arrayWithContentsOfFile:path];
    
    for(NSDictionary *dict in data){
        
        ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
        ChartMessage *chartMessage=[[ChartMessage alloc]init];
        chartMessage.dict=dict;
        cellFrame.chartMessage=chartMessage;
        [self.cellFrames addObject:cellFrame];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChartCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    cell.cellFrame=self.cellFrames[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellFrames[indexPath.row] cellHeight];
}
-(void)chartCell:(ChartCell *)chartCell tapContent:(NSString *)content
{
    if(self.player.isPlaying){
        
        [self.player stop];
    }
    //播放
    NSString *filePath=[NSString documentPathWith:content];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    [self initPlayer];
    NSError *error;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    [self.player setVolume:1];
    [self.player prepareToPlay];
    [self.player setDelegate:self];
    [self.player play];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice]setProximityMonitoringEnabled:NO];
    [self.player stop];
    self.player=nil;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledReturn:(UITextField *)textFiled
{
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int random=arc4random_uniform(2);
    NSLog(@"%d",random);
    chartMessage.icon=[NSString stringWithFormat:@"icon%02d.jpg",random+1];
    chartMessage.messageType=random;
    chartMessage.content=textFiled.text;
    cellFrame.chartMessage=chartMessage;
    
    [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    
    //滚动到当前行
    
    [self tableViewScrollCurrentIndexPath];
    textFiled.text=@"";
    
}
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledBegin:(UITextField *)textFiled
{
    [self tableViewScrollCurrentIndexPath];
    
}
-(void)beginRecord
{
    if(self.recording)return;
    
    self.recording=YES;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"rec_%@.wav",[dateFormater stringFromDate:now]];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
}
-(void)finishRecord
{
    self.recording=NO;
    [self.recorder stop];
    self.recorder=nil;
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int random=arc4random_uniform(2);
    NSLog(@"%d",random);
    chartMessage.icon=[NSString stringWithFormat:@"icon%02d.jpg",random+1];
    chartMessage.messageType=random;
    chartMessage.content=self.fileName;
    cellFrame.chartMessage=chartMessage;
    [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    [self tableViewScrollCurrentIndexPath];
    
}
-(void)tableViewScrollCurrentIndexPath
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.cellFrames.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
