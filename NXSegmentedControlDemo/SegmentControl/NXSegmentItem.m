//
//  NXSegmentItem.m
//  NXSegmentedControlDemo
//
//  Created by iNuoXia on 14-7-3.
//  Copyright (c) 2014年 NuoXia. All rights reserved.
//

#import "NXSegmentItem.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@implementation NXSegmentItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithTile:(NSString *)title {
    if (self = [self initWithFrame:CGRectZero]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        self.titleLabel.textColor = RGB(0x5f, 0x64, 0x6e);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [self initWithFrame:CGRectZero]) {
        self.imageView = [[UIImageView alloc]initWithImage:image];
        self.imageView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (self.titleLabel) {
        self.titleLabel.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
    } else if (self.imageView) {
        self.imageView.frame = frame;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.bounds, point);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
