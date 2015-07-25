//
//  yDriveUser.m
//  yDriveData
//
//  Created by 张达棣 on 14-6-20.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "DriveCloudUser.h"
#import "UserInfo.h"
#import "LogOut.h"
#import "HDService.h"

using namespace iNetLib;

static NSString *keyUser = @"keyDriveCloudUser";

static NSString *keyToken       = @"keyToken";
static NSString *keyUid         = @"keyUid";
static NSString *keyUsername    = @"keyUsername";
static NSString *keyNickname    = @"keyNickname";
static NSString *keyUrl         = @"keyUrl";
static NSString *keySex         = @"keySex";
static NSString *keyTel         = @"keyTel";
static NSString *keyLastUserName   = @"keyLastUserName";


@interface DriveCloudUser ()<HDNetSerViceDelegate>

@end

@implementation DriveCloudUser


-(id)init
{
	self=[super init];
	if(self==nil)
		return nil;

	_userInfoCtrl = [[DCDataCtrl_UserInfo alloc] init];
	_userInfoCtrl.param.user = self;
    _userInfoCtrl.delegate = self;

    
    _logOutCtrl = [[DCDataCtrl_LogOut alloc] init];
    _logOutCtrl.param.user = self;
    _logOutCtrl.delegate = self;
    
    _token = iNetLib::OCDataCast<NSString *>([self getOutDataForKey:keyToken]);
    _uid = iNetLib::OCDataCast<int>([self getOutDataForKey:keyUid]);
    _username = iNetLib::OCDataCast<NSString *>([self getOutDataForKey:keyUsername]);
    _nickname = iNetLib::OCDataCast<NSString *>([self getOutDataForKey:keyNickname]);
    _iconUrl = OCDataCast<NSString *>([self getOutDataForKey:keyUrl]);
    _sex = OCDataCast<int>([self getOutDataForKey:keySex]);
    _tel = OCDataCast<NSString *>([self getOutDataForKey:keyTel]);
    _lastUserName = iNetLib::OCDataCast<NSString *>([self getOutDataForKey:keyLastUserName]);;
    
    if (_token == nil) {
        [self setNoneData];
    }

	return self;
}

- (void)setNoneData {
    self.token = nil;
    self.uid = -1;
    
    self.username = nil;
    self.nickname = nil;
    self.iconUrl = nil;
    self.sex = 0;
    self.tel = nil;
}

- (void)setUserData {
    self.username = self.userInfoCtrl.data.userName;
    self.nickname = self.userInfoCtrl.data.nickName;
    self.iconUrl = self.userInfoCtrl.data.icon;
    self.sex = self.userInfoCtrl.data.sex;
    self.tel = (self.userInfoCtrl.data.tel == nil ? @"暂无" : self.userInfoCtrl.data.tel);
    self.lastUserName = self.userInfoCtrl.data.userName;
    
}

#pragma mark - 数据持久化

- (void)setToken:(NSString *)token {
    if (_token != token) {
        _token = token;
        [self saveData:token forKey:keyToken];
    }
}

- (void)setUid:(int)uid {
    if (_uid != uid) {
        _uid = uid;
        [self saveData:[NSString stringWithFormat:@"%d", uid] forKey:keyUid];
    }
}

- (void)setUsername:(NSString *)username {
    if (![_username isEqualToString:username]) {
        _username = username;
        [self saveData:username forKey:keyUsername];
    }
}

- (void)setLastUserName:(NSString *)lastUserName {
    if (![_lastUserName isEqualToString:lastUserName]) {
        _lastUserName = lastUserName;
        [self saveData:lastUserName forKey:keyLastUserName];
    }
}

- (void)setNickname:(NSString *)nickname {
    if (![_nickname isEqualToString:nickname]) {
        _nickname = nickname;
        [self saveData:nickname forKey:keyNickname];
    }
}

- (void)setIconUrl:(NSString *)iconUrl {
    if (![_iconUrl isEqualToString:iconUrl]) {
        _iconUrl = iconUrl;
        [self saveData:iconUrl forKey:keyUrl];
    }
}

- (void)setSex:(int)sex {
    if (_sex != sex) {
        _sex = sex;
        [self saveData:[NSString stringWithFormat:@"%d", sex] forKey:keySex];
    }
}

- (void)setTel:(NSString *)tel {
    if (tel == nil || tel.length == 0) {
        tel = @"暂无";
    }
    if (![_tel isEqualToString:tel]) {
        _tel = tel;
        [self saveData:tel forKey:keyTel];
    }
}

- (void)saveData:(NSString *)data forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:keyUser]];
    if (userDict == nil) {
        userDict = [NSMutableDictionary dictionary];
    }
    [userDict setObject:data == nil ? [NSString string] : data forKey:key];
    [defaults setObject:userDict forKey:keyUser];
    //如果1秒内没有写入操作，才把数据同步到硬盘。
    [NSObject cancelPreviousPerformRequestsWithTarget:defaults selector:@selector(synchronize) object:nil];
    [defaults performSelector:@selector(synchronize) withObject:nil afterDelay:1];
}


- (NSString *)getOutDataForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [defaults objectForKey:keyUser];
    NSString *retuStr = userDict[key];
    if (retuStr.length == 0) {
        return nil;
    } else {
        return retuStr;
    }
}

#pragma mark - HDNetSerViceDelegate

- (void)HDNetSerViceUpdate:(HDNetServiceCtrl *)sender {
    if (sender == _logOutCtrl) {
        [self setNoneData];
    } else if (sender == _userInfoCtrl) {
        if (_userInfoCtrl.data != nil && _userInfoCtrl.data.error == nil) {
            [self setUserData];
        }
    }
}

@end
