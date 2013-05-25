//
//  TCDropFileZoneView.m
//  TCDropZone
//
//  Created by Konstantin Stoldt on 24.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

#import "TCDropFileZoneView.h"

@implementation TCDropFileZoneView

- (id)initWithFrame:(NSRect)frame
{
    if ( self = [super initWithFrame:frame] )
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventHandler:) name:@"eventType" object:nil];
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
        fileisEntered = NO;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    NSEraseRect(dirtyRect);
    
    if ( fileisEntered == NO )
    { // Kein File is auf der Drag Zone
        [[NSColor whiteColor] set];
        NSRectFill(dirtyRect);
    }
    else
    { // File befindet sich auf der Drag Zone
        [[NSColor greenColor] set];
        NSRectFill(dirtyRect);
    }
}

#pragma mark - Drop Delegate

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSLog(@"Drag entered");
    
    fileisEntered = YES;
    [self setNeedsDisplay:YES];
    
    return NSDragOperationCopy;
}

- (void)draggingExited:(id < NSDraggingInfo >)sender
{
    fileisEntered = NO;
    [self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id)sender
{
    fileisEntered = NO;
    [self setNeedsDisplay:YES];
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        // Count testen ? int numberOfFiles = [files count];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"eventType" object:files];
        return YES;
    }
    return NO;
}

#pragma mark - Notification

- (void)eventHandler: (NSNotification *) notification
{
    if ( self.delegate && [self.delegate respondsToSelector:@selector(dropZoneGetFiles:)] )
    {
        [self.delegate dropZoneGetFiles:[notification object]];
    }
}
         

@end
