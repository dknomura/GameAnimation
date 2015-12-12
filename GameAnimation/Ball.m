//
//  Ball.m
//  GameAnimation
//
//  Created by Aditya Narayan on 12/12/15.
//  Copyright © 2015 Daniel Nomura. All rights reserved.
//

#import "Ball.h"

@implementation Ball


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(context);
}


@end
