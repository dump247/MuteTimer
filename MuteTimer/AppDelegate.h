//
//  AppDelegate.h
//  MuteTimer
//
//  Created by Cory Thomas on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *statusItem;
    NSDate *endTime;
    NSCalendar *systemCalendar;
    NSTimer *updateTimer;
    NSImage *statusImage;
}

- (void)update;

@end
