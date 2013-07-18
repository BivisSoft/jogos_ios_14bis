//
//  GameScene.h
//  bis
//

#import "MeteorsEngine.h"
#import "Player.h"
#import "CCMenuItemGameButton.h"
#import "Score.h"
#import "FinalScreen.h"
#import "GameOverScreen.h"
#import "PauseScreen.h"

@interface GameScene : CCLayer <MeteorsEngineDelegate, MeteorDelegate, PlayerDelegate, ShootDelegate, PauseScreenDelegate>

+ (CCScene *)scene;

// Layers
@property (nonatomic, retain) CCLayer *meteorsLayer;
@property (nonatomic, retain) CCLayer *playerLayer;
@property (nonatomic, retain) CCLayer *shootsLayer;
@property (nonatomic, retain) CCLayer *gameButtonsLayer;
@property (nonatomic, retain) CCLayer *scoreLayer;
@property (nonatomic, retain) CCLayer *topLayer;

// Engines
@property (nonatomic, retain) MeteorsEngine *meteorsEngine;

// Arrays
@property (nonatomic, retain) NSMutableArray *meteorsArray;
@property (nonatomic, retain) NSMutableArray *shootsArray;
@property (nonatomic, retain) NSMutableArray *playersArray;

// Screens
@property (nonatomic, retain) PauseScreen *pauseScreen;

// Game Objects
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) Score *score;

@end
