//
//  HDBluetoothManage.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-7.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDBluetoothManager.h"
#import "HDMultiPointCallNode.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <Debug.h>

@interface HDBluetoothManager () <CBCentralManagerDelegate, CBPeripheralDelegate>
{
    HDMultiPointCallNode *_callNode;
}
@property (nonatomic, strong) NSString *devName;
@property (nonatomic, strong) NSString *devUUID;
@property (nonatomic, strong) CBCentralManager *manager;
@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic;
@property (strong ,nonatomic) CBCharacteristic *readCharacteristic;
@property (nonatomic, strong, readonly) CBPeripheral *peripheral; //连接中的设备

@end

@implementation HDBluetoothManager

#pragma mark - 生命周期

+ (instancetype)manager {
    static HDBluetoothManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _callNode = [[HDMultiPointCallNode alloc] init];
    }
    return self;
}

#pragma mark -

- (void)connect:(NSString *)name UUID:(NSString*)uuid {
    self.devName = name;
    self.devUUID = uuid;
     [self startScanService];
}

- (void)Disconnect {
    
}

- (void)sendWithData:(NSData *)data {
    
}

#pragma makr - 

- (void)startScanService {
    
}

#pragma mark - CBCentralManagerDelegate
//开始查看服务，蓝牙开启
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            DebugLog(@"蓝牙已打开,请扫描外设");
            break;
        default:
            DebugLog(@"蓝牙没打开");
           
            break;
    }
}

//查到外设
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    DebugLog(@"查到外设=%@", peripheral.name);
    
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    DebugLog(@"%@", [NSString stringWithFormat:@"成功连接 = %@", peripheral.name]);
    
    _peripheral.delegate = self;
    [self.peripheral discoverServices:nil];
    DebugLog(@"扫描服务");
}

//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    DebugLog(@"连接外设失败=%@",error);
    _peripheral = nil;
    _writeCharacteristic = nil;
    _readCharacteristic = nil;
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    DebugLog(@"蓝牙断开=%@",error);
    _writeCharacteristic = nil;
    _readCharacteristic = nil;
}

#pragma mark - CBPeripheralDelegate

//已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    DebugLog(@"发现服务");
    
//    if (error) {
//        _peripheral = nil;
//        
//        DebugLog(@"Error discovering services: %@", error);
//        return;
//    }
//    
//    for (CBService *s in [peripheral services]) {
//        if ([s.UUID isEqual:self.class.uartServiceUUID]) {
//            DLog(@"Found correct service");
//            self.uartService = s;
//            
//            [self.peripheral discoverCharacteristics:@[self.class.txCharacteristicUUID, self.class.rxCharacteristicUUID] forService:self.uartService];
//        } else if ([s.UUID isEqual:self.class.deviceInformationServiceUUID]) {
//            [self.peripheral discoverCharacteristics:@[self.class.hardwareRevisionStringUUID] forService:s];
//        }
//    }
}

//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
//    for (CBCharacteristic *c in [service characteristics]) {
//        
//        DLog(@"c.UUID[%@][%@]",c.UUID,peripheral.name);
//        
//        if ([c.UUID isEqual:self.class.rxCharacteristicUUID]) {
//            DLog(@"Found RX characteristic");
//            self.readCharacteristic = c;
//            [self.peripheral setNotifyValue:YES forCharacteristic:self.readCharacteristic];
//            
//        } else if ([c.UUID isEqual:self.class.txCharacteristicUUID]) {
//            DLog(@"Found TX characteristic");
//            self.writeCharacteristic = c;
//        } else if ([c.UUID isEqual:self.class.hardwareRevisionStringUUID]) {
//            DLog(@"Found Hardware Revision String characteristic");
//            [self.peripheral readValueForCharacteristic:c];
//        }
//    }
}

//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    DebugLog(@"中心读取外设实时数据[%@]",characteristic.UUID);
//    if (error) {
//        _peripheral = nil;
//        if (_statBlock) {
//            _statBlock(@"连接外设失败");
//        }
//        DLog(@"Error changing notification state: %@", error.localizedDescription);
//        return;
//    }
//    if (_statBlock) {
//        _statBlock(nil);
//    }
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

@end
