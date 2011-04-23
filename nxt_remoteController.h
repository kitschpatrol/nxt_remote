
//
//  nxt_remoteController.h
//  nxt_remote
//
//  Created by Alexander Zautke on 12.03.11.
//

/*
 Copyright (c) 2011 Alexander Zautke
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */


#import <Foundation/Foundation.h>
#import "nxt_remote.h"


@interface nxt_remoteController : NSObject {
    NXT* _nxt;
    
    Boolean programStarted;
    Boolean soundStarted;
    NSString* programNameC;
    
    IBOutlet NSTextField* deviceStatus;
    IBOutlet NSTextField* programName;
    IBOutlet NSTextField* errorField;
    IBOutlet NSTextField* soundFileField;
    IBOutlet NSTextField* inputValues;
    IBOutlet NSTextField* inputValues2;
    IBOutlet NSTextField* inputValues3;
    IBOutlet NSTextField* inputValues4;
    
    IBOutlet NSLevelIndicator* batterylevelIndicator;
    
    IBOutlet NSPopUpButton* popUpButton;
    IBOutlet NSPopUpButton* popUpButton2;
    IBOutlet NSPopUpButton* popUpButton3;
    IBOutlet NSPopUpButton* popUpButton4;
    
    IBOutlet NSButton* loopSound;
    IBOutlet NSButton* getInputValuesPort1;
    IBOutlet NSButton* getInputValuesPort2;
    IBOutlet NSButton* getInputValuesPort3;
    IBOutlet NSButton* getInputValuesPort4;
}

- (id)initNXT;

- (IBAction)startProgramm:(id)sender;
- (IBAction)doConnect:(id)sender;
- (IBAction)playSound:(id)sender;
- (IBAction)getBatteryLevelC:(id)sender;
- (IBAction)getInputValues:(id)sender;
- (IBAction)showExtraPanel:(id)sender;

- (void)setupInputValues:(UInt8)port;
- (void)stopProgram;

- (NSString*)whichSensor:(UInt8)port;

@end
