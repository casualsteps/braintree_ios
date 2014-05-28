#import "BTUICardHint.h"

#import "BTUI.h"

#import <Braintree/BTUICVVFrontVectorArtView.h>
#import <Braintree/BTUICVVBackVectorArtView.h>

@interface BTUICardHint ()
@property (nonatomic, strong) UIView *hintVectorArtView;
@property (nonatomic, strong) NSArray *hintVectorArtViewConstraints;
@end

@implementation BTUICardHint

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.layer.borderColor = [[BTUI braintreeTheme] cardHintBorderColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 2.0f;

    self.hintVectorArtView = [[BTUI braintreeTheme] vectorArtViewForPaymentMethodType:BTUIPaymentMethodTypeUnknown];
    [self.hintVectorArtView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.hintVectorArtView];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:87.0f/55.0f
                                                      constant:0.0f]];

    [self setNeedsLayout];
}

- (void)updateConstraints {
    if (self.hintVectorArtViewConstraints) {
        [self removeConstraints:self.hintVectorArtViewConstraints];
    }

    self.hintVectorArtViewConstraints = @[[NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.hintVectorArtView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0f
                                                                        constant:1.0f],

                                          [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.hintVectorArtView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.0f
                                                                        constant:0.0f],

                                          [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.hintVectorArtView
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1.0f
                                                                        constant:0.0f] ];

    [self addConstraints:self.hintVectorArtViewConstraints];

    [super updateConstraints];
}

- (void)updateViews {
    UIView *cardVectorArtView;
    switch (self.displayMode) {
        case BTCardHintDisplayModeCardType:
            cardVectorArtView = [[BTUI braintreeTheme] vectorArtViewForPaymentMethodType:self.cardType];
            break;
        case BTCardHintDisplayModeCVVHint:
            if (self.cardType == BTUIPaymentMethodTypeAMEX) {
                cardVectorArtView = [BTUICVVFrontVectorArtView new];
            } else {
                cardVectorArtView = [BTUICVVBackVectorArtView new];
            }
            break;
    }

    [self.hintVectorArtView removeFromSuperview];
    self.hintVectorArtView = cardVectorArtView;
    [self.hintVectorArtView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.hintVectorArtView];

    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

- (void)setCardType:(BTUIPaymentMethodType)cardType {
    _cardType = cardType;
    [self updateViews];
}

- (void)setCardType:(BTUIPaymentMethodType)cardType animated:(BOOL)animated {
    if (animated) {
        [UIView transitionWithView:self
                          duration:0.2f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self setCardType:cardType];
                        } completion:nil];
    } else {
        [self setCardType:cardType];
    }
}

- (void)setDisplayMode:(BTCardHintDisplayMode)displayMode {
    _displayMode = displayMode;
    [self updateViews];
}

- (void)setDisplayMode:(BTCardHintDisplayMode)displayMode animated:(BOOL)animated {
    if (animated) {
        [UIView transitionWithView:self
                          duration:0.2f
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [self setDisplayMode:displayMode];
                        } completion:nil];
    } else {
        [self updateViews];
    }
}

- (void)highlight:(BOOL)highlight {
    if ([self.hintVectorArtView respondsToSelector:@selector(setHighlightColor:)]) {
        UIColor *c = highlight ? [BTUI braintreeTheme].highlightColor : nil;

        [UIView transitionWithView:self.hintVectorArtView
                          duration:0.3f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self.hintVectorArtView performSelector:@selector(setHighlightColor:) withObject:c];
                            [self.hintVectorArtView setNeedsDisplay];
                        }
         completion:nil
         ];
    }
}

@end