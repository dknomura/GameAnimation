//
//  GameViewController.m
//  GameAnimation
//
//  Created by Aditya Narayan on 12/12/15.
//  Copyright (c) 2015 Daniel Nomura. All rights reserved.
//

#import "GameViewController.h"
#import "Ball.h"
@interface GameViewController()
@property (weak, nonatomic) IBOutlet Ball *ballView;
@property (weak, nonatomic) IBOutlet UIView *barView;
//@property (weak, nonatomic) IBOutlet UIView *upperBarBoundary;
//@property (weak, nonatomic) IBOutlet UIView *lowerBarBoundary;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
//@property (strong, nonatomic) UICollisionBehavior *collisionBehavior;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *topBarBoundary;

@property (weak, nonatomic) IBOutlet UIView *bottomBarBoundary;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add a tap gesture recognizer
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.barView addGestureRecognizer:panGesture];
    
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.barView, self.ballView]];
    collisionBehavior.collisionDelegate = self;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    
//    UIDynamicAnimator *barAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self.animator addBehavior:collisionBehavior];
    
}

- (void) handlePan:(UIGestureRecognizer*)gestureRecognize
{
    CGPoint touchLocation = [gestureRecognize locationInView:self.view];
    if (touchLocation.y > self.barView.frame.origin.y + self.barView.frame.size.height) {
        gestureRecognize.view.center = CGPointMake(touchLocation.x, self.barView.center.y);
    }
    if (touchLocation.x < self.barView.frame.origin.y) {
        gestureRecognize.view.center = CGPointMake(touchLocation.x, self.barView.center.y);
    }
}


- (IBAction)startGame:(id)sender
{
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.ballView]];
    self.startButton.hidden = YES;
    
    [self.animator addBehavior:self.gravityBehavior];
    
//    NSArray *boundID = self.collisionBehavior.boundaryIdentifiers;

}

//-(void) coll


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
