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
//@property (weak, nonatomic) IBOutlet UIView *topBarBoundary;
//
//@property (weak, nonatomic) IBOutlet UIView *bottomBarBoundary;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) UIPushBehavior *pushBallBehavior;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@property (nonatomic) float points;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (nonatomic) CGPoint originalBarViewOrigin;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.pointsLabel.text = @"Points: 0";
    
    // add a tap gesture recognizer
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.barView addGestureRecognizer:panGesture];
    
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    

    
//    UICollisionBehavior *ballCollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.barView, self.bottomView]];
//    ballCollisionBehavior.collisionDelegate = self;
//    ballCollisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//  
//    UIDynamicItemBehavior *barDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.barView, self.bottomView]];
//    barDynamicBehavior.anchored = YES;
//    barDynamicBehavior.friction = 1.0;
//    
//    [self.animator addBehavior:ballCollisionBehavior];
//    [self.animator addBehavior:barDynamicBehavior];
    
    self.originalBarViewOrigin = self.barView.frame.origin;
    
}

- (void) handlePan:(UIGestureRecognizer*)gestureRecognize
{
    CGPoint touchLocation = [gestureRecognize locationInView:self.view];
    if ((touchLocation.y < self.originalBarViewOrigin.y + self.barView.frame.size.height + 15) && (touchLocation.y > self.originalBarViewOrigin.y - 15)) {
        gestureRecognize.view.center = CGPointMake(touchLocation.x, touchLocation.y);
    } else if ((touchLocation.y >= self.originalBarViewOrigin.y + self.barView.frame.size.height + 15)) {
        gestureRecognize.view.center = CGPointMake(touchLocation.x, self.originalBarViewOrigin.y + self.barView.frame.size.height + 15);
    } else if (touchLocation.y <= self.originalBarViewOrigin.y - 15){
        gestureRecognize.view.center = CGPointMake(touchLocation.x, self.originalBarViewOrigin.y - 15);
    }
    
    [self.animator updateItemUsingCurrentState:self.barView];


}

-(void) collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
//    [self.animator removeBehavior:self.pushBallBehavior];
////    self.pushBallBehavior.angle = 2 * M_PI - (self.pushBallBehavior.angle);
//    self.pushBallBehavior.magnitude = .3;
//    [self.animator addBehavior:self.pushBallBehavior];
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1 ];

    Ball *view = (Ball*)item;
    view.backgroundColor = randomColor;
    [UIView animateWithDuration:1 animations:^{
        view.backgroundColor = [UIColor whiteColor];
    }];
    
    if ([(NSString*)identifier isEqualToString: @"bottom"]) {
        [self resetGame];
    }
}



-(void) collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(nonnull id<UIDynamicItem>)item1 withItem:(nonnull id<UIDynamicItem>)item2
{
    if (([item1 isEqual:self.ballView] && [item2 isEqual:self.barView]) || ([item2 isEqual:self.ballView] && [item1 isEqual:self.barView])){
        self.points += .5;
        self.pointsLabel.text = [NSString stringWithFormat:@"Points: %.0f", self.points];
        
        self.barView.backgroundColor = [UIColor yellowColor];
        [UIView animateWithDuration:.4 animations:^{
            self.barView.backgroundColor = [UIColor redColor];
        }];
//        [self.animator removeBehavior:self.pushBallBehavior];
////
////        self.pushBallBehavior.angle = 2 * M_PI - (self.pushBallBehavior.angle);
//        self.pushBallBehavior.magnitude = .3;
////
//        [self.animator addBehavior:self.pushBallBehavior];


    }
    if (([item1 isEqual:self.ballView] && [item2 isEqual:self.bottomView]) || ([item2 isEqual:self.ballView] && [item1 isEqual:self.bottomView])){
        [self resetGame];
        
        
    }
}

- (IBAction)resetGame:(id)sender {
    [self resetGame];
}

-(void) resetGame
{
    [self.animator removeAllBehaviors];
    
    CGFloat randomX = arc4random_uniform(self.view.frame.size.width);
    self.ballView.center = CGPointMake(randomX, 12);
    self.startButton.hidden = NO;
    self.gameOverLabel.hidden = NO;
}

- (IBAction)startGame:(id)sender
{
    self.pushBallBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBallBehavior.magnitude = .4;
    self.pushBallBehavior.angle =1.2  * M_PI;
    
    UIDynamicItemBehavior *ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    ballDynamicBehavior.elasticity = 1.05;
    ballDynamicBehavior.resistance = 0;
//    ballDynamicBehavior.allowsRotation = NO;

    UICollisionBehavior *ballCollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.barView]];
    CGPoint bottomLeft = CGPointMake(0, self.view.frame.size.height);
    CGPoint bottomRight = CGPointMake(self.view.frame.size.width, self.view.frame.size.height);
    [ballCollisionBehavior addBoundaryWithIdentifier:@"bottom" fromPoint:bottomLeft toPoint:bottomRight];
    ballCollisionBehavior.collisionDelegate = self;
    ballCollisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    UIDynamicItemBehavior *barDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.barView]];
    barDynamicBehavior.anchored = YES;
    barDynamicBehavior.friction = 1.0;
    
    [self.animator addBehavior:ballCollisionBehavior];
    [self.animator addBehavior:barDynamicBehavior];
    [self.animator addBehavior:self.pushBallBehavior];
    [self.animator addBehavior:ballDynamicBehavior];
    
    self.startButton.hidden = YES;
    self.gameOverLabel.hidden = YES;

    
    self.points = 0;
    self.pointsLabel.text = @"Points: 0";
    self.pointsLabel.adjustsFontSizeToFitWidth = YES;
    
//    NSArray *boundID = self.collisionBehavior.boundaryIdentifiers;

}

- (IBAction)restartGame:(id)sender
{
    
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
