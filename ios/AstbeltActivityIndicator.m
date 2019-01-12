//
// Created by Tigran Sahakyan on 2019-01-12.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "AstbeltActivityIndicator.h"
#import "Asteroid.h"

int const ASTEROID_COUNT = 100;
float const SPEED = 0.025;
float const MIN_REL_SIZE = 0.02;
float const MAX_REL_SIZE = 0.05;
float const CIRCLE_WIDTH_PERCENT = 0.5;
NSString *const BLANK_COLOR = @"#ffffff";
NSString *const PROGRESS_COLOR = @"#ff60ad";

@implementation AstbeltActivityIndicator

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

float _progress;
UIColor *__blankColor;
UIColor *__progressColor;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        __blankColor = [AstbeltActivityIndicator colorWithHexString:(BLANK_COLOR)];
        __progressColor = [AstbeltActivityIndicator colorWithHexString:(PROGRESS_COLOR)];
        _progress = 0;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAsteroids:[[NSMutableArray<Asteroid *> alloc]init]];
        for (int i = 0; i < ASTEROID_COUNT; ++i) {
            Asteroid *ast = [[Asteroid alloc] init];
            ast.rotation = (float) (2 * M_PI * [self randomFloat]);
            ast.distance = [self randomFloat] * (CIRCLE_WIDTH_PERCENT - MAX_REL_SIZE) + (1 - CIRCLE_WIDTH_PERCENT);
            ast.radius = [self randomFloat] * (MAX_REL_SIZE - MIN_REL_SIZE) + MIN_REL_SIZE;
            [_asteroids addObject:ast];
        }
    }
    return self;
}

- (void)setBlankColor:(NSString *)color {
    __blankColor = [AstbeltActivityIndicator colorWithHexString:(color)];
}

- (void)setProgressColor:(NSString *)color {
    __progressColor = [AstbeltActivityIndicator colorWithHexString:(color)];
}

- (void)setProgress:(float)progress {
    _progress = progress;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat cx = rect.size.width / 2;
    CGFloat cy = rect.size.height / 2;
    CGFloat size = cx > cy ? cy : cx;

    float currentProgressRadian = (float) (M_PI * 2 * _progress);

    for (Asteroid *asteroid in _asteroids) {
        CGFloat distFromCenter = cx * asteroid.distance;
        asteroid.rotation += SPEED / sqrtf(asteroid.distance - CIRCLE_WIDTH_PERCENT + 0.2f);
        asteroid.rotation = fmodf(asteroid.rotation, (float) (M_PI * 2));

        float fixedRotation = (float) (asteroid.rotation - M_PI_2);
        CGContextAddArc(context,
                cx + cosf(fixedRotation) * distFromCenter,
                cy + sinf(fixedRotation) * distFromCenter,
                asteroid.radius * size,
                0, M_PI * 2, true);
        [(asteroid.rotation < currentProgressRadian ? __progressColor : __blankColor) setFill];
        CGContextFillPath(context);
    }

    [NSTimer scheduledTimerWithTimeInterval: 1.0 / 60 repeats:false block:^(NSTimer* timer) {
        [self setNeedsDisplay];
    }];

}

- (float) randomFloat {
    return (float) (random() / (double) RAND_MAX);
}

@end
