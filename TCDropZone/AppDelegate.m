//
//  AppDelegate.m
//  TCDropZone
//
//  Created by Konstantin Stoldt on 24.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.dropFileZoneView = [[TCDropFileZoneView alloc] init];
    self.dropFileZoneView.delegate = self;
}

#pragma mark - TCDropFileZoneDelegate

- (void)dropZoneGetFiles:(NSArray *)filePathArray
{
    NSLog(@"AppDelegateFiles: %@", filePathArray);
}

@end
