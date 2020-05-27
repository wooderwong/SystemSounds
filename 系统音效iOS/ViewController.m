//
//  ViewController.m
//  系统音效iOS
//
//  Created by BDKid on 2020/5/27.
//  Copyright © 2020 BDKid. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#define despacitoString @"despacito"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    SystemSoundID scoreClickBtnID;   // 自己设置的音效 (系统的振动音效 - kSystemSoundID_Vibrate)
}
@property(nonatomic, strong) NSArray *allSounds;

@end

@implementation ViewController

static NSString *cellId = @"cellId";
- (void)viewDidLoad {
    [super viewDidLoad];
    _allSounds = @[ @"1000", @"1001", @"1002", @"1003", @"1004", @"1005", @"1006", @"1007", @"1008", @"1009", @"1010", @"1011", @"1012", @"1013", @"1014", @"1015", @"1016", @"1020", @"1021", @"1022", @"1023", @"1024", @"1025", @"1026", @"1027", @"1028", @"1029",@"1030",@"1031",@"1032",@"1033",@"1034",@"1035",@"1036",@"1050",@"1051",@"1052",@"1053",@"1054",@"1055",@"1057",@"1070",@"1071",@"1072",@"1073",@"1074",@"1075",@"1100",@"1101",@"1102",@"1103",@"1104",@"1105",@"1106",@"1107",@"1108",@"1109",@"1110",@"1111",@"1112",@"1113",@"1114",@"1115",@"1116",@"1117",@"1118",@"1150",@"1151",@"1152",@"1153",@"1154",@"1200",@"1201",@"1202",@"1203",@"1204",@"1205",@"1206",@"1207",@"1208",@"1209",@"1210",@"1211",@"1254",@"1255",@"1256",@"1257",@"1258",@"1259",@"1300",@"1301",@"1302",@"1303",@"1304",@"1305",@"1306",@"1307",@"1308",@"1309",@"1310",@"1311",@"1312",@"1313",@"1314",@"1315",@"1320",@"1321",@"1322",@"1323",@"1324",@"1325",@"1326",@"1327",@"1328",@"1329",@"1330",@"1331",@"1332",@"1333",@"1334",@"1335",@"1336",@"1350",@"1351",@"4095", despacitoString];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%s", __func__);
     
    scoreClickBtnID = kSystemSoundID_Vibrate;
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
         AudioServicesPlaySystemSound(1000);
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received3.caf"]]), &scoreClickBtnID);
     
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSLog(@"_allSounds.count = %lu", (unsigned long)_allSounds.count);
    return self.allSounds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = self.allSounds[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = self.allSounds[indexPath.row];
    
    if ([cellId isEqualToString:despacitoString]) {
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:despacitoString ofType:@"mp3"]];
            SystemSoundID systemSound_id;
            AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &systemSound_id);
            AudioServicesAddSystemSoundCompletion(systemSound_id, NULL, NULL, SoundFinishedPlaying, NULL);
        //    AudioServicesPlaySystemSound(systemSound_id);////静音模式下不再播放
            AudioServicesPlayAlertSound(systemSound_id);//静音模式下照样播放
    }else{
        AudioServicesPlaySystemSound([cellId intValue]);
    }
}

void SoundFinishedPlaying(SystemSoundID sound_id, void *user_data){
    NSLog(@"%s", __func__);
    AudioServicesRemoveSystemSoundCompletion(sound_id);
    AudioServicesDisposeSystemSoundID(sound_id);
}
@end
