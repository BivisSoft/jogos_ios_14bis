//
//  GameScene.m
//  bis
//

#import "GameScene.h"

@implementation GameScene

#pragma mark Construtor

// Helper class method that creates a Scene with the GameScene as the only child.
+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}


#pragma mark Inicialização

- (id)init
{
    self = [super init];
    if (self) {
        // Imagem de Background
        CCSprite *background = [CCSprite spriteWithFile:kBACKGROUND];
        background.position = ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() / 2.0f);
        [self addChild:background];
        
        // CCLayer para os Meteoros
        self.meteorsLayer = [CCLayer node];
        [self addChild:self.meteorsLayer];
        
        // CCLayer para o Jogador
        self.playerLayer = [CCLayer node];
        [self addChild:self.playerLayer];
        
        // CCLayer para os Tiros
        self.shootsLayer = [CCLayer node];
        [self addChild:self.shootsLayer];

        // CCLayer para o Placar
        self.scoreLayer = [CCLayer node];
        [self addChild:self.scoreLayer];

        // CCLayer para os Botões
        self.gameButtonsLayer = [CCLayer node];
        [self addChild:self.gameButtonsLayer];
        
        // CCLayer para o exibição da tela de Pause
        self.topLayer = [CCLayer node];
        [self addChild:self.topLayer];
        
        // Cria os botões
        CCMenuItemGameButton *leftControl = [CCMenuItemGameButton
                                             itemWithNormalSprite:[CCSprite spriteWithFile:kLEFTCONTROL]
                                             selectedSprite:[CCSprite spriteWithFile:kLEFTCONTROL]
                                             target:self
                                             selector:@selector(moveLeft:)];
        CCMenuItemGameButton *rightControl = [CCMenuItemGameButton
                                              itemWithNormalSprite:[CCSprite spriteWithFile:kRIGHTCONTROL]
                                              selectedSprite:[CCSprite spriteWithFile:kRIGHTCONTROL]
                                              target:self
                                              selector:@selector(moveRight:)];
        CCMenuItemGameButton *shootButton = [CCMenuItemGameButton
                                             itemWithNormalSprite:[CCSprite spriteWithFile:kSHOOTBUTTON]
                                             selectedSprite:[CCSprite spriteWithFile:kSHOOTBUTTON]
                                             target:self
                                             selector:@selector(shoot:)];
        CCMenuItemGameButton *pauseButton = [CCMenuItemGameButton
                                             itemWithNormalSprite:[CCSprite spriteWithFile:kPAUSE]
                                             selectedSprite:[CCSprite spriteWithFile:kPAUSE]
                                             target:self
                                             selector:@selector(pauseGame:)];
        
        // Define as posições dos botões
        leftControl.position = ccp(-110.0f,
                                   (SCREEN_HEIGHT() / -2.0f) + 50.0f);
        rightControl.position = ccp(-50.0f,
                                    (SCREEN_HEIGHT() / -2.0f) + 50.0f);
        shootButton.position = ccp((SCREEN_WIDTH() / 2.0f) - 50.0f,
                                   (SCREEN_HEIGHT() / -2.0f) + 50.0f);
        pauseButton.position = ccp(-120.0f,
                                   (SCREEN_HEIGHT() / 2.0f) - 30.0f);
        
        // Cria o menu que terá os botões
        // CCMenu *menu = [CCMenu menuWithItems:leftControl, rightControl, shootButton, nil];
        CCMenu *menu = [CCMenu menuWithItems:shootButton, pauseButton, nil];
        [self.gameButtonsLayer addChild:menu];
        
        [self addGameObjects];
        
        // Música do Jogo
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"music.wav" loop:YES];
        
        // Cache de sons do Jogo
        [self preloadCache];
    }
    return self;
}

- (void)addGameObjects
{
    // Inicializa os Arrays
    self.meteorsArray = [NSMutableArray array];
    self.shootsArray = [NSMutableArray array];

    // Inicializa a Engine de Meteoros
    self.meteorsEngine = [MeteorsEngine meteorEngine];
    
    // Cria o Player
    self.player = [Player player];
    self.player.delegate = self;
    [self.playerLayer addChild:self.player];
    
    // Insere o Player no array de Players
    self.playersArray = [NSMutableArray array];
    [self.playersArray addObject:self.player];
    
    // Cria o Placar
    self.score = [Score score];
    [self.scoreLayer addChild:self.score];
}

- (void)startGame
{
    // Configura o status do jogo
    [Runner sharedRunner].gamePaused = NO;
    
    // Sons
    [SimpleAudioEngine sharedEngine].effectsVolume = 1.0f;
    [SimpleAudioEngine sharedEngine].backgroundMusicVolume = 1.0f;

    // Inicia o monitoramento do Acelerômetro
    [self.player monitorAccelerometer];
    
    // Inicia a checagem de colisões
    [self schedule:@selector(checkHits:)];
    
    // Inicia as Engines do jogo
    [self startEngines];
}

- (void)onEnter
{
    [super onEnter];
    
    [self startGame];
}

- (void)startEngines
{
    // Inicia a Engine de Meteoros
    [self addChild:self.meteorsEngine];
    self.meteorsEngine.delegate = self;
}


#pragma mark Cache de Sons

- (void)preloadCache
{
    // Cache de sons do Jogo
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"shoot.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bang.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"over.wav"];
}


#pragma mark Collisions

- (BOOL)checkRadiusHitsOfArray:(NSArray *)array1 againstArray:(NSArray *)array2 withSender:(id)sender andCallbackMethod:(SEL)callbackMethod
{
    BOOL result = NO;
    
    for (int i = 0; i < [array1 count]; i++) {
        // Pega objeto do primeiro array
        CCSprite *obj1 = [array1 objectAtIndex:i];
        CGRect rect1 = obj1.boundingBox;
        
        for (int j = 0; j < [array2 count]; j++) {
            // Pega objeto do segundo array
            CCSprite *obj2 = [array2 objectAtIndex:j];
            CGRect rect2 = obj2.boundingBox;
            
            // Verifica colisão
            if (CGRectIntersectsRect(rect1, rect2)) {
                NSLog(@"Colisão Detectada: %@", NSStringFromSelector(callbackMethod));
                result = YES;

                // Se o sender possui o método indicado na chamada do método, executa o mesmo com os objetos encontrados nos arrays
                if ([sender respondsToSelector:callbackMethod]) {
                    [sender performSelector:callbackMethod withObject:[array1 objectAtIndex:i] withObject:[array2 objectAtIndex:j]];
                }
                
                // Se encontrou uma colisão, sai dos 2 loops
                i = [array1 count] + 1;
                j = [array2 count] + 1;
            }
        }
    }
    
    return result;
}

- (void)checkHits:(float)dt
{
    // Checa se houve colisão entre Meteoros e Tiros
    [self checkRadiusHitsOfArray:self.meteorsArray
                    againstArray:self.shootsArray
                      withSender:self
               andCallbackMethod:@selector(meteorHit:withShoot:)];

    // Checa se houve colisão entre Jogador(es) e Meteoros
    [self checkRadiusHitsOfArray:self.playersArray
                    againstArray:self.meteorsArray
                      withSender:self
               andCallbackMethod:@selector(playerHit:withMeteor:)];
}

- (void)meteorHit:(id)meteor withShoot:(id)shoot
{
    // Quando houve uma colisão entre Meteoro e Tiro, indica que o Meteoro foi atingido e que o Tiro deve explodir
    if ([meteor isKindOfClass:[Meteor class]]) {
        [(Meteor *)meteor gotShot];
    }
    if ([shoot isKindOfClass:[Shoot class]]) {
        [(Shoot *)shoot explode];
    }

    // Aumenta a pontuação
    [self.score increase];
    
    // Verifica o máximo score para vencer o jogo
    if (self.score.score >= 5) {
        [self startFinalScreen];
    }
}

- (void)playerHit:(id)player withMeteor:(id)meteor
{
    // Quando houve uma colisão entre Player e Meteoro, indica que ambos foram atingidos
    if ([player isKindOfClass:[Player class]]) {
        [(Player *)player explode];
    }
    if ([meteor isKindOfClass:[Meteor class]]) {
        [(Meteor *)meteor gotShot];
    }
    
    // Ao ser atingido, o Jogador é transferido à GameOverScreen
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverScreen scene]]];
}


#pragma mark Fim de Jogo

- (void)startFinalScreen
{
    // Transfere o Jogador para a FinalScreen
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FinalScreen scene]]];
}


#pragma mark Ações do Jogador

- (void)moveLeft:(id)sender
{
    NSLog(@"Botão selecionado: Esquerda");
    [self.player moveLeft];
}

- (void)moveRight:(id)sender
{
    NSLog(@"Botão selecionado: Direita");
    [self.player moveRight];
}

- (void)shoot:(id)sender
{
    NSLog(@"Botão selecionado: Atirar");
    [self.player shoot];
}

- (void)pauseGame:(id)sender
{
    NSLog(@"Botão selecionado: Pausa");
    if ([Runner sharedRunner].isGamePaused == NO) {
        [Runner sharedRunner].gamePaused = YES;
    }

    if ([Runner sharedRunner].isGamePaused == YES &&
        self.pauseScreen == nil) {
        
        self.pauseScreen = [PauseScreen pauseScreen];
        self.pauseScreen.delegate = self;
        [self.topLayer addChild:self.pauseScreen];
    }
}


#pragma mark MeteorsEngineDelegate

- (void)meteorsEngineDidCreateMeteor:(Meteor *)meteor
{
    // A Engine de Meteoros indicou que um novo Meteoro foi criado
    [self.meteorsLayer addChild:meteor];
    meteor.delegate = self;
    [meteor start];
    [self.meteorsArray addObject:meteor];
}


#pragma mark MeteorDelegate

- (void)meteorWillBeRemoved:(Meteor *)meteor
{
    // Após atingido, um Meteoro notifica a GameScene para que seja removido do Array
    meteor.delegate = nil;
    [self.meteorsArray removeObject:meteor];
}


#pragma mark PlayerDelegate

- (void)playerDidCreateShoot:(Shoot *)shoot
{
    // O Player indicou que um novo Tiro foi criado
    [self.shootsLayer addChild:shoot];
    shoot.delegate = self;
    [shoot start];
    [self.shootsArray addObject:shoot];
}


#pragma mark ShootDelegate

- (void)shootWillBeRemoved:(Shoot *)shoot
{
    // Após explodir, um Tiro notifica a GameScene para que seja removido do Array
    shoot.delegate = nil;
    [self.shootsArray removeObject:shoot];
}


#pragma mark PauseScreenDelegate

- (void)pauseScreenWillResumeGame:(PauseScreen *)pauseScreen
{
    if ([Runner sharedRunner].isGamePaused == YES) {
        // Continua o jogo
        self.pauseScreen.delegate = nil;
        self.pauseScreen = nil;
        
        [Runner sharedRunner].gamePaused = NO;
    }
}

- (void)pauseScreenWillQuitGame:(PauseScreen *)pauseScreen
{
    [SimpleAudioEngine sharedEngine].effectsVolume = 0.0f;
    [SimpleAudioEngine sharedEngine].backgroundMusicVolume = 0.0f;
    
    // Transfere o Jogador para a TitleScreen
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TitleScreen scene]]];
}


#pragma mark Gerenciamento de Memória

- (void)dealloc
{
    [_meteorsLayer release];
    [_playerLayer release];
    [_shootsLayer release];
    [_gameButtonsLayer release];
    [_scoreLayer release];
    [_topLayer release];

    [_meteorsEngine release];
    
    [_meteorsArray release];
    [_shootsArray release];
    [_playersArray release];
    
    [_pauseScreen release];
    
    [_player release];
    [_score release];
    
    [super dealloc];
}

@end
