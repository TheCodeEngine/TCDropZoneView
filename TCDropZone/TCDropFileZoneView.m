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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventHandler:) name:@"TCDropbFileZoneGetFiles" object:nil];
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
        fileisEntered = NO;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    
    // Mitte berechnen
    CGPoint center;
    center.x = dirtyRect.size.width / 2;
    center.y = dirtyRect.size.height / 2;
    
    // Settings Rounded Rect
    CGFloat rectLength = 200;
    
    if ( fileisEntered == NO )
    { // Kein File is auf der Drag Zone
        //// Color Declarations
        NSColor* color = [NSColor colorWithCalibratedRed: 0.568 green: 0.577 blue: 0.585 alpha: 1];
        
        //// DropbZone
        {
            //// Pfeil Drawing
            NSBezierPath* pfeilPath = [NSBezierPath bezierPath];
            [pfeilPath moveToPoint: NSMakePoint(center.x, center.y)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 41.67 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 41.67 - 52.5, center.y + 78.5 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 60.67 - 52.5, center.y + 78.5 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 60.67 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 70.5 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 51.5 - 52.5, center.y + 25.5 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 32.5 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath closePath];
            [color setFill];
            [pfeilPath fill];
            
            //// Rounded Rectangle Drawing
            NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(center.x - rectLength/2, center.y - rectLength/2, rectLength, rectLength) xRadius: 7 yRadius: 7];
            [color setStroke];
            [roundedRectanglePath setLineWidth: 10];
            CGFloat roundedRectanglePattern[] = {24, 24, 24, 24};
            [roundedRectanglePath setLineDash: roundedRectanglePattern count: 4 phase: 2.3];
            [roundedRectanglePath stroke];
        }
    }
    else
    { // File befindet sich auf der Drag Zone
        //// Color Declarations
        NSColor* color = [NSColor whiteColor];
        
        [[NSColor colorWithSRGBRed:0.52f green:0.77f blue:0.94f alpha:1.00f] set];
        NSRectFill(dirtyRect);
        //// DropbZone
        {
            //// Pfeil Drawing
            NSBezierPath* pfeilPath = [NSBezierPath bezierPath];
            [pfeilPath moveToPoint: NSMakePoint(center.x, center.y)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 41.67 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 41.67 - 52.5, center.y + 78.5 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 60.67 - 52.5, center.y + 78.5 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 60.67 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 70.5 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 51.5 - 52.5, center.y + 25.5 - 46.44)];
            [pfeilPath lineToPoint: NSMakePoint(center.x + 32.5 - 52.5, center.y + 46.44 - 46.44)];
            [pfeilPath closePath];
            [color setFill];
            [pfeilPath fill];
            
            
            //// Rounded Rectangle Drawing
            NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(center.x - rectLength/2, center.y - rectLength/2, rectLength, rectLength) xRadius: 7 yRadius: 7];
            [color setStroke];
            [roundedRectanglePath setLineWidth: 10];
            CGFloat roundedRectanglePattern[] = {24, 24, 24, 24};
            [roundedRectanglePath setLineDash: roundedRectanglePattern count: 4 phase: 2.3];
            [roundedRectanglePath stroke];
        }
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TCDropbFileZoneGetFiles" object:files];
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
