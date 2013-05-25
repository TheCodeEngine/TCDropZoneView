//
//  TCDropFileZoneView.h
//  TCDropZone
//
//  Created by Konstantin Stoldt on 24.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TCDropFileZoneDelegate <NSObject>
- (void)dropZoneGetFiles:(NSArray*)filePathArray;
@end

@interface TCDropFileZoneView : NSView
{
    BOOL fileisEntered;
}

@property (strong) id <TCDropFileZoneDelegate> delegate;

@end
