//
//  NXSegmentedControl.m
//  NXSegmentedControlDemo
//
//  Created by iNuoXia on 14-7-1.
//  Copyright (c) 2014年 NuoXia. All rights reserved.
//

#import "NXSegmentedControl.h"
#import "NXSegmentItem.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

typedef void(^SelectedBlock)(NSUInteger index);

@interface NXSegmentedControl ()

@property (nonatomic, strong) NSMutableArray *segments; // just support image or title
@property (nonatomic, strong) SelectedBlock selectedBlock;
@property (nonatomic, readwrite) NSUInteger numberOfSegments;

@property (nonatomic, strong) NXSegmentItem *selectedSegment;

@end

@implementation NXSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)itemsm selectedSegmentDelegate:(id)delegate {
    if (self = [super initWithFrame:CGRectZero]) {
        self.delegate = delegate;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray *)items selectedSgementIndex:(void (^)(NSUInteger))selectedBlock {
    if (self = [super initWithFrame:CGRectZero]) {
        
        if (items == nil || items.count == 0) {
            return nil;
        }
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4.f;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = RGB(0x5f, 0x64, 0x6e).CGColor;
        
        _numberOfSegments = [items count];
        _segments = [NSMutableArray arrayWithCapacity:0];
        for (NSUInteger index = 0; index < items.count; ++ index) {
            if ([items[index] isKindOfClass:[NSString class]]) {
                NXSegmentItem *segment = [[NXSegmentItem alloc]initWithTile:items[index]];
                [_segments addObject:segment];
                [self addSubview:segment];
            } else if ([items[index] isKindOfClass:[UIImage class]]) {
                NXSegmentItem *segment = [[NXSegmentItem alloc]initWithImage:items[index]];
                [_segments addObject:segment];
                [self addSubview:segment];
            }
        }
        
        _selectedSegmentIndex = 0;
        _selectedSegmentColor = RGB(0x5f, 0x64, 0x6e);
        _selectedTextColor = [UIColor whiteColor];
        _unselectedSegmentColor = [UIColor whiteColor];
        _unselectedTextColor = RGB(0x5f, 0x64, 0x6e);
        self.selectedSegment = _segments[0];
        if (self.selectedSegment && self.selectedSegment.titleLabel) {
            self.selectedSegment.titleLabel.backgroundColor = _selectedSegmentColor;
            self.selectedSegment.titleLabel.textColor = _selectedTextColor;
        }
        _selectedBlock = selectedBlock;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGFloat segmentWidth = (frame.size.width)/_segments.count;
    CGFloat segmentHeight = frame.size.height;

    for (NSUInteger i = 0; i < _segments.count; ++i) {
        NXSegmentItem *segment = _segments[i];
        segment.frame = CGRectMake(0.f + i * segmentWidth, 0.f, segmentWidth, segmentHeight);
    }
}

-(void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex {
    
    if (!_segments || selectedSegmentIndex >= _segments.count || selectedSegmentIndex == _selectedSegmentIndex) {
        return;
    }
    NSUInteger old_segment_index = _selectedSegmentIndex;
    _selectedSegmentIndex = selectedSegmentIndex;
    
    NXSegmentItem *old_segment = _segments[old_segment_index];
    if (old_segment && old_segment.titleLabel) {
        old_segment.titleLabel.backgroundColor = _unselectedSegmentColor;
        old_segment.titleLabel.textColor = _unselectedTextColor;
    }
    
    NXSegmentItem *segment = _segments[selectedSegmentIndex];
    if (segment && segment.titleLabel) {
        segment.titleLabel.backgroundColor = _selectedSegmentColor;
        segment.titleLabel.textColor = _selectedTextColor;
    }
}

- (void)insertSegmentTitle:(NSString *)title atIndex:(NSUInteger)index {
    if (title == nil || _segments == nil || index > _segments.count) {
        return;
    }
    
    NXSegmentItem *segment = [[NXSegmentItem alloc]initWithTile:title];
    [_segments insertObject:segment atIndex:index];
}

- (void)insertSegmentImage:(UIImage *)image atIndex:(NSUInteger)index {
    if (image == nil || _segments == nil || index > _segments.count) {
        return;
    }
    
    NXSegmentItem *segment = [[NXSegmentItem alloc]initWithImage:image];
    [_segments insertObject:segment atIndex:index];
}

- (void)layoutSubviews {
    
}

#pragma mark -
#pragma mark Tracking
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.bounds, point);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    for (NSUInteger i = 0; i < _segments.count; ++i) {
        CGPoint cPos = [touch locationInView:_segments[i]];
        if ([_segments[i] pointInside:cPos withEvent:event]) {
            self.selectedSegmentIndex = i;
            
            if (_selectedBlock) {
                _selectedBlock(i);
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControl:didSelectedIndex:)]) {
                [self.delegate segmentedControl:self didSelectedIndex:i];
            }
            
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
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
