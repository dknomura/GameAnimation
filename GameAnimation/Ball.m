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

//-(void) changeBallColor: (UIColor*) color
//{
//    CGFloat red = arc4random_uniform(255) / 255.0;
//    CGFloat green = arc4random_uniform(255) / 255.0;
//    CGFloat blue = arc4random_uniform(255) / 255.0;
//    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(context, rect);
//    CGContextSetFillColor(context, CGColorGetComponents([randomColor CGColor]));
//    CGContextFillPath(context);
//}

@end
