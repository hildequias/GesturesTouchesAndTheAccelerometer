
#import <CoreMotion/CoreMotion.h>

@interface MainScene : CCNode {
    
    CGSize winSize;
    
    //DirectionalPad* dPad;
    float heroSpeed;
    
    CCSprite* accHero;
    CMMotionManager *_motionManager;
    
    //SSCustomSprite *hero;
    
    CCSprite* backgroundImage;
    
    //pinch/zoom
    float currentScale;
    
    //rotation
    float lastRotAngle;
}

+ (CCScene *) scene;

@end
