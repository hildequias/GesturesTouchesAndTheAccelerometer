#import "MainScene.h"
#import "cocos2d-ui.h"

@implementation MainScene

+ (CCScene *) scene {
    
    return [[self alloc] init];
}

- (void)onEnter{
    
    [super onEnter];
    self.userInteractionEnabled = YES;
}

- (void)onExit{
    
    [super onExit];
    self.userInteractionEnabled = NO;
}

-(id) init {
    
    if(self = [super init]){
        
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        CGPoint center = CGPointMake(winSize.width/2, winSize.height/2);
        self.contentSize = winSize;
        
        ////Basic CCSprite - Background Image
        backgroundImage = [CCSprite spriteWithImageNamed:@"Bg.png"];
        backgroundImage.position = CGPointMake(winSize.width/2, winSize.height/2);
        [self addChild:backgroundImage];
        
        // ** SWIPE ** //
        
        //swipe up
        UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
        swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:swipeUpGestureRecognizer];
        
        //swipe down
        UISwipeGestureRecognizer* swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownFrom:)];
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:swipeDownGestureRecognizer];
        
        //swipe left
        UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftFrom:)];
        swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:swipeLeftGestureRecognizer];
        
        //swipe Right
        UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightFrom:)];
        swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:swipeRightGestureRecognizer];
        
        // ** UITap ** //
        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:tapGestureRecognizer];
        
        // ** UILongPress ** //
        UILongPressGestureRecognizer* longTapRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
        longTapRecognizer.minimumPressDuration = 0.25; // seconds
        
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:longTapRecognizer];
        
        // ** PinchZoom ** //
        UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:pinchRecognizer];
        
        // ** rotation ** //
        UIRotationGestureRecognizer* rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:rotationRecognizer];
        
        // ** Pan ** //
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        [[UIApplication sharedApplication].delegate.window addGestureRecognizer:panGestureRecognizer];
    }
    
    return self;
}

- (void) handleSwipeUpFrom:(UIGestureRecognizer *)recognizer {
    
    NSLog(@"Swipe Up");
}

- (void) handleSwipeDownFrom:(UIGestureRecognizer *)recognizer {
    
    NSLog(@"Swipe Down");
}

- (void) handleSwipeLeftFrom:(UIGestureRecognizer *)recognizer {
    
    NSLog(@"Swipe Left");
}

- (void) handleSwipeRightFrom:(UIGestureRecognizer *)recognizer {

    NSLog(@"Swipe Right");
}

- (void) handleTap:(UIGestureRecognizer *)recognizer {
    
    NSLog(@"TAP");
}

- (void) handleLongPressFrom:(UILongPressGestureRecognizer *)recognizer {
    
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
        CCLOG(@"PRESS HOLD");
    }
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer *)recognizer {
    
    NSLog(@"pinch zoom");
    backgroundImage.scale = recognizer.scale;
}

- (void) handleRotationGesture:(UIRotationGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan){
        
        lastRotAngle = CC_RADIANS_TO_DEGREES([recognizer rotation]);
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        float rotation = CC_RADIANS_TO_DEGREES([recognizer rotation]);
        backgroundImage.rotation += rotation - lastRotAngle;
        lastRotAngle = rotation;
    }
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        // nothing here
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        
        // Invert Y since position and offset are calculated in gl coordinates
        translation = ccp(translation.x, -translation.y);
        
        backgroundImage.position = ccp(backgroundImage.position.x + translation.x,
                                       backgroundImage.position.y + translation.y);
        
        // Refresh pan gesture recognizer
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        // nothing here
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *) event {
    
    CCLOG(@"TOUCHES BEGAN");
    
    CGPoint touchLocation = [touch locationInNode:self];
    
    CCSprite* hero = [CCSprite spriteWithImageNamed:@"hero.png"];
    [self addChild:hero];
    hero.position = touchLocation;
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *) event {
    
    CCLOG(@"TOUCHES MOVED");
}

- (void) touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *) event {
    
    CCLOG(@"TOUCHES ENDED");
}

@end
