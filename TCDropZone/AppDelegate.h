//
//  AppDelegate.h
//  TCDropZone
//
//  Created by Konstantin Stoldt on 24.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "TCDropFileZoneView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, TCDropFileZoneDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) TCDropFileZoneView *dropFileZoneView;

@end
