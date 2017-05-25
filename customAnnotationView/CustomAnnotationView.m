//
//  CustomAnnotationView.m
//  IphoneMapSdkDemo
//
//  Created by Li,Shutong(MP) on 2017/5/25.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomPaopaotView.h"

#define kWidth  150.f
#define kHeight 60.f

#define kHoriMargin 8.f
#define kVertMargin 8.f

#define kPortraitWidth  40.f
#define kPortraitHeight 40.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface CustomAnnotationView ()
@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong, readwrite) CustomPaopaotView *paopaoView;

@end

@implementation CustomAnnotationView

@synthesize paopaoView;

@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;


#pragma mark - Handle Action

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override


- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.paopaoView == nil)
        {
            
            /* Construct custom callout. */
            self.paopaoView = [[CustomPaopaotView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.paopaoView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.paopaoView.bounds) / 2.f + self.calloutOffset.y);
            
            self.paopaoView.image = [UIImage imageNamed:@"poi_1.png"];
            self.paopaoView.title = self.annotation.title;
            self.paopaoView.subtitle = self.annotation.subtitle;
            
            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            btn.frame = CGRectMake(10, 10, 40, 40);
//            [btn setTitle:@"Test" forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//            [btn setBackgroundColor:[UIColor whiteColor]];
//            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.paopaoView addSubview:btn];
//            
//            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
//            name.backgroundColor = [UIColor clearColor];
//            name.textColor = [UIColor whiteColor];
//            name.font = [UIFont systemFontOfSize:13.f];
//            name.text = @"Hello Baidumap!";
//            [self.paopaoView addSubview:name];
        }
        
        [self addSubview:self.paopaoView];
    }
    else
    {
        [self.paopaoView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.paopaoView pointInside:[self convertPoint:point toView:self.paopaoView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor grayColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHoriMargin, kVertMargin, kPortraitWidth, kPortraitHeight)];
        [self addSubview:self.portraitImageView];
        
        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitWidth + kHoriMargin,
                                                                   kVertMargin,
                                                                   kWidth - kPortraitWidth - kHoriMargin,
                                                                   kHeight - 2 * kVertMargin)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:12.f];
        [self addSubview:self.nameLabel];
    }
    
    return self;
}


@end
