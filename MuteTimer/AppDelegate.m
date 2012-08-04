//
//  AppDelegate.m
//  MuteTimer
//
//  Created by Cory Thomas on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import <AudioToolbox/AudioServices.h>

static AudioDeviceID GetDefaultAudioDevice() {
    AudioDeviceID device = 0;
    UInt32 size = sizeof(AudioDeviceID);
    AudioObjectPropertyAddress address = {
        kAudioHardwarePropertyDefaultOutputDevice,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMaster
    };
    
    if (AudioObjectGetPropertyData(kAudioObjectSystemObject, &address, 0, NULL, &size, &device)) {
        NSLog(@"could not get default audio output device");
    }
    
    return device;
}

static BOOL IsMute() {
    AudioDeviceID device = GetDefaultAudioDevice();
    UInt32 size = sizeof(UInt32);
    UInt32 muteVal = 0;
    AudioObjectPropertyAddress address = {
        kAudioDevicePropertyMute,
        kAudioDevicePropertyScopeOutput,
        0
    };
    
    if (device != 0 && AudioObjectGetPropertyData(device, &address, 0, NULL, &size, &muteVal)) {
        NSLog(@"Error while getting mute status");
    }
    
    return (BOOL)muteVal;
}

static void SetMute(BOOL mute) {
    AudioDeviceID device = GetDefaultAudioDevice();
    UInt32 muteVal = (UInt32)mute;
    AudioObjectPropertyAddress address = {
        kAudioDevicePropertyMute,
        kAudioDevicePropertyScopeOutput,
        0
    };
    
    if (device != 0 && AudioObjectSetPropertyData(device, &address, 0, NULL, sizeof(UInt32), &muteVal)) {
        NSLog(@"error while %@muting", (mute ? @"" : @"un"));
    }
}

@implementation AppDelegate

- (void)update {
    NSDateComponents *conversionInfo = [systemCalendar components:NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit fromDate:[NSDate date]  toDate:endTime  options:0];
    NSInteger hours = [conversionInfo hour];
    NSInteger seconds = [conversionInfo second];
    NSInteger minutes = [conversionInfo minute];
    
    if ((hours == 0 && minutes == 0 && seconds == 0) || !IsMute()) {
        SetMute(NO);
        exit(0);
    }
    
    NSString *title = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    [statusItem setTitle:title];   
}

- (void)awakeFromNib {
    SetMute(YES);
    
    endTime = [NSDate dateWithTimeIntervalSinceNow:28];
    systemCalendar = [NSCalendar currentCalendar];
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    NSBundle *bundle = [NSBundle mainBundle];
    statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"mute_16x16" ofType:@"png"]];
    [statusItem setImage:statusImage];
    
    [self update];
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

@end
