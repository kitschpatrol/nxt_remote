//
//  nxt_remoteController.m
//  nxt_remote
//
//  Created by Alexander Zautke on 12.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "nxt_remoteController.h"


@implementation nxt_remoteController

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (IBAction)doConnect:(id)sender
{
    
    [deviceStatus setStringValue:(@"Connecting")];
    _nxt = [[NXT alloc] init];
    
    BOOL connected;
    connected = [_nxt connect:self];
    
    if (connected) {
        [deviceStatus setStringValue:(@"Connected to device")];
    }
    else {
        [deviceStatus setStringValue:(@"Failed to connect to device")];
    }
}

- (IBAction)close:(id)sender{
    [_nxt closeConnection];
    [deviceStatus setStringValue:@"Disconnected"];
}

-(IBAction)startProgramm:(id)sender
{
    
    NSString* programNameTextField;
    programNameTextField = [programName stringValue];
    
    NSRange rxeRange;
    rxeRange = [programNameTextField rangeOfString:@".rxe"];

    if (rxeRange.length == 0) {
        programNameTextField = [programNameTextField stringByAppendingString:@".rxe"];
    }
        
        
        if (programStarted == NO) {
            
            NSLog(@"%@",programNameTextField);
            
            if ([programNameTextField isEqualToString:@".rxe"]) {
                // make foo
            }
            
            else {
                
                [_nxt startProgram:programNameTextField];
                [sender setTitle:@"Stop programm"];
                programStarted = YES;
            }
            
        }
        else {
            [self stopProgram];
            [sender setTitle:@"Start programm"];
            programStarted = NO;
    }
}

-(IBAction)getBatteryLevelC:(id)sender{
    [_nxt getBatteryLevel];
}
-(IBAction)playSound:(id)sender {
    
    // stop Sound Button ohne loops
    Boolean loopB;
    if ([loopSound state] == YES) {
        loopB = YES;
     }
    else {
        loopB = NO;
    }
    
    NSString* soundFile;
    soundFile = [soundFileField stringValue];
    
    NSRange rsoRange;
    rsoRange = [soundFile rangeOfString:@".rso"];
    
    if (rsoRange.length == 0) {
        soundFile = [soundFile stringByAppendingString:@".rso"];
    }
    
    if (soundStarted == NO) {
        
        [_nxt playSoundFile:soundFile loop:loopB];
        [sender setTitle:@"Stop sound"];
        soundStarted = YES;
    }
    else {
        [_nxt stopSoundPlayback];
        [sender setTitle:@"Play SoundFile"];
        soundStarted = NO;
    }
}

-(void)stopProgram{
    [_nxt getCurrentProgramName];
    [_nxt stopProgram];
}

-(void)setupInputValues:(UInt8)port{
    NSString* sensorName = [self whichSensor:port];
    
    if ([sensorName isEqualToString:@"Touch"]){
        [_nxt setupTouchSensor:port];
        NSLog(@"Setup Touch");
    }
    if ([sensorName isEqualToString:@"Sound db"]) {
        [_nxt setupSoundSensor:port dbA:NO];
        NSLog(@"Setup Sound db");
    }
    if ([sensorName isEqualToString:@"Sound dbA"]) {
        [_nxt setupSoundSensor:port dbA:YES];
        NSLog(@"Setup Sound dbA");
    }
    if ([sensorName isEqualToString:@"Light"]) {
        [_nxt setupLightSensor:port active:YES];
        NSLog(@"Setup Light");
    }
    if ([sensorName isEqualToString:@"Light Passive"]) {
        [_nxt setupLightSensor:port active:NO];
        NSLog(@"Setup Light Passive");
    }
    if ([sensorName isEqualToString:@"Temperature Celcius"]) {
        [_nxt setupTemperatureSensor:port CelciusMode:YES];
        NSLog(@"Setup Temperature Celcius");
    }
    if ([sensorName isEqualToString:@"Temperature Fahrenheit"]) {
        [_nxt setupTemperatureSensor:port CelciusMode:NO];
        NSLog(@"Setup Temperature Fahrenheit");
    }
}

-(NSString*)whichSensor:(UInt8)port{
    if (port == kNXTSensor1) {
        NSString* sensorName;
        sensorName = [popUpButton titleOfSelectedItem];
        NSLog(@"Sensor selected: %@",sensorName);
        return sensorName; 
    }
    if (port == kNXTSensor2) {
        NSString* sensorName;
        sensorName = [popUpButton2 titleOfSelectedItem];
        NSLog(@"Sensor selected: %@",sensorName);
        return sensorName; 
    }
    if (port == kNXTSensor3) {
        NSString* sensorName;
        sensorName = [popUpButton3 titleOfSelectedItem];
        NSLog(@"Sensor selected: %@",sensorName);
        return sensorName; 
    }
    if (port == kNXTSensor4) {
        NSString* sensorName;
        sensorName = [popUpButton4 titleOfSelectedItem];
        NSLog(@"Sensor selected: %@",sensorName);
        return sensorName; 
    }
    return @"";
}

-(IBAction)getInputValues:(id)sender {
    UInt8 port;
    if ([sender tag] == 0) {
        port = kNXTSensor1;
        NSLog(@"Port 1");
    }
    if ([sender tag] == 1) {
        port = kNXTSensor2;
        NSLog(@"Port 2");
    }
    if ([sender tag] == 2) {
        port = kNXTSensor3;
        NSLog(@"Port 3");
    }
    if ([sender tag] == 3) {
        port = kNXTSensor4;
        NSLog(@"Port 4");
    }
    [self setupInputValues:port];
    [_nxt getInputValues:port];
}

- (void)NXTBatteryLevel:(NXT*)nxt batteryLevel:(UInt16)batteryLevel
{
    NSLog(@"%i",batteryLevel);
    [batterylevelIndicator setIntValue:batteryLevel];
}

- (void)NXTCommunicationError:(NXT*)nxt code:(int)code {
    
    [errorField setIntValue:code];
}

- (void)NXTCurrentProgramName:(NXT*)nxt currentProgramName:(NSString*)currentProgramName {
    
    programNameC = currentProgramName;
    
}

- (void) NXTDiscovered:(NXT*)nxt
    {

    
         
     }

-(void)NXTGetInputValues:(NXT *)nxt port:(UInt8)port isCalibrated:(BOOL)isCalibrated type:(UInt8)type mode:(UInt8)mode rawValue:(UInt16)rawValue normalizedValue:(UInt16)normalizedValue scaledValue:(SInt16)scaledValue calibratedValue:(SInt16)calibratedValue {
    
    switch (port) {
        case kNXTSensor1:
            [inputValues setIntValue:scaledValue];
            break;
        case kNXTSensor2:
            [inputValues2 setIntValue:scaledValue];
            break;
        case kNXTSensor3:
            [inputValues3 setIntValue:scaledValue];
            break;
        case kNXTSensor4:
            [inputValues4 setIntValue:scaledValue];
            break;
        default:
            break;
    }
}

// handle errors
- (void)NXTOperationError:(NXT*)nxt operation:(UInt8)operation status:(UInt8)status
    {
        // error code in hex
        NSLog(@"nxt error: operation=0x%x status=0x%x", operation, status);
        [errorField setIntValue:status];
   }

// disconnected
- (void) NXTClosed:(NXT*)nxt
{
    [deviceStatus setStringValue:@"Disconnected"];
}
@end