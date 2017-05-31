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
        
    }
    
    return self;
}

- (void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer {
    
    NSLog(@"Swipe Up");
}

@end
