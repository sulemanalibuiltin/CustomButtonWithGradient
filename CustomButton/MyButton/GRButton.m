//
//  GRButton.m
//  GridiPhone
//
//  Created by Waseem Khan on 03/02/2016.
//

#import "GRButton.h"


@implementation GRButton{
    CAGradientLayer *layer;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if(self.enabled == YES){
        if (self.highlighted == YES)
        {
            [self addGradientWithColors:@"044775" colorCode:@"09629f" locations:@[@0.25, @0.75]];
        } else  {
            [self addGradientWithColors:@"09629f" colorCode:@"044775" locations:@[@0, @0.5]];
        }
        self.layer.borderWidth = 0;
    } else {
        self.layer.borderColor = [self colorWithHexString:@"C3C4C6"].CGColor;
        self.layer.borderWidth = 1;
        [self addGradientWithColors:@"FFFFFF" colorCode:@"FFFFFF" locations:@[@0, @1]];
    }
    
    CALayer *btnLayer = [self layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:self.frame.size.height/2];
    
    [self setTitleColor:[self colorWithHexString:@"C3C4C6"] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted | UIControlStateNormal | UIControlStateSelected];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:NO];
    
    [layer removeFromSuperlayer];
    if (highlighted) {
        [self addGradientWithColors:@"044775" colorCode:@"09629f" locations:@[@0.5, @1.0]];
    } else {
        [self addGradientWithColors:@"09629f" colorCode:@"044775" locations:@[@0, @0.5]];
    }
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted | UIControlStateNormal | UIControlStateSelected];
    self.titleLabel.alpha = 1.0;
}

- (void) addGradientWithColors:(NSString*) colorCode1 colorCode:(NSString*) colorCode2 locations:(NSArray*) locations{
    if(layer != nil){
        [layer removeFromSuperlayer];
    }
    layer = [CAGradientLayer layer];
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[[self colorWithHexString:colorCode1] CGColor],
                       (id)[[self colorWithHexString:colorCode2] CGColor],
                       nil];
    [layer setColors:colors];
    layer.locations = locations;
    [layer setFrame:self.bounds];
    
    
    [self.layer insertSublayer:layer atIndex:0];
    self.clipsToBounds = YES; // Important!
    [self setNeedsDisplay];
}


- (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


- (void)dealloc
{
    // [self removeObserver:self forKeyPath:@"highlighted"];
    //[super dealloc];
}

@end
