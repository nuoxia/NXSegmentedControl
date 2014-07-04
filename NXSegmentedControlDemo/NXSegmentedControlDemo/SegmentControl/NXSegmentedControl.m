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

//@property (nonatomic, strong) NXSegmentItem *selectedSegment;

@end

@implementation NXSegmentedControl

#pragma mark -
#pragma mark Construct Functions
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.cornerRadius = 4.f;
        self.borderWidth = 1.f;
        self.borderColor = RGB(0x5f, 0x64, 0x6e);
        
        _segments = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items selectedSegmentDelegate:(id)delegate {
    if (self = [self initWithFrame:CGRectZero]) {
        
        if (items == nil || items.count == 0) {
            return nil;
        }
        
        [self createSegments:items];
        
        self.delegate = delegate;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray *)items selectedSgementIndex:(void (^)(NSUInteger))selectedBlock {
    if (self = [self initWithFrame:CGRectZero]) {
        
        if (items == nil || items.count == 0) {
            return nil;
        }
        
        [self createSegments:items];
        
        _selectedBlock = selectedBlock;
    }
    
    return self;
}

- (void)createSegments: (NSArray *)items {
    _numberOfSegments = [items count];
    for (NSUInteger index = 0; index < items.count; ++ index) {
        if ([items[index] isKindOfClass:[NSString class]]) {
            NXSegmentItem *segment = [[NXSegmentItem alloc]initWithTile:items[index]];
            [_segments addObject:segment];
            [self addSubview:segment];
        } else if ([items[index] isKindOfClass:[UIImage class]]) {
            NXSegmentItem *segment = [[NXSegmentItem alloc]initWithImage:items[index]];
            [_segments addObject:segment];
            [self addSubview:segment];
        } else {
            NSLog(@"Not Support Type!");
        }
    }
    
    _selectedSegmentIndex = 0;
    
    _selectedSegmentColor = RGB(0x5f, 0x64, 0x6e);
    _selectedTextColor = [UIColor whiteColor];
    _unselectedSegmentColor = [UIColor whiteColor];
    _unselectedTextColor = RGB(0x5f, 0x64, 0x6e);
    
    NXSegmentItem *segment = _segments[0];
    if (segment && segment.titleLabel) {
        segment.titleLabel.backgroundColor = _selectedSegmentColor;
        segment.titleLabel.textColor = _selectedTextColor;
    }
}

#pragma mark -
#pragma mark Set Functions
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setSegmentsFrame];
}

- (void)setSegmentsFrame {
    CGFloat segmentWidth = (self.frame.size.width)/_segments.count;
    CGFloat segmentHeight = self.frame.size.height;
    
    for (NSUInteger i = 0; i < _segments.count; ++i) {
        NXSegmentItem *segment = _segments[i];
        segment.frame = CGRectMake(0.f + i * segmentWidth, 0.f, segmentWidth, segmentHeight);
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setSelectedSegmentColor:(UIColor *)selectedSegmentColor {
    
    _selectedSegmentColor = selectedSegmentColor;
    
    if (_segments && _segments.count > 0) {
        NXSegmentItem *segment = _segments[_selectedSegmentIndex];
        if (segment && segment.titleLabel) {
            segment.titleLabel.backgroundColor = _selectedSegmentColor;
        }
    }
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor {
    _selectedTextColor = selectedTextColor;
    
    if (_segments && _segments.count > 0) {
        NXSegmentItem *segment = _segments[_selectedSegmentIndex];
        if (segment && segment.titleLabel) {
            segment.titleLabel.textColor = _selectedTextColor;
        }
    }
}

- (void)setUnselectedSegmentColor:(UIColor *)unselectedSegmentColor {
    _unselectedSegmentColor = unselectedSegmentColor;
    
    __weak NXSegmentedControl *wSelf = self;
    [_segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (wSelf.selectedSegmentIndex != idx) {
            NXSegmentItem *segment = wSelf.segments[idx];
            if (segment && segment.titleLabel) {
                segment.titleLabel.backgroundColor = unselectedSegmentColor;
            }
        }
    }];
}

- (void)setUnselectedTextColor:(UIColor *)unselectedTextColor {
    _unselectedTextColor = unselectedTextColor;
    
    __weak NXSegmentedControl *wSelf = self;
    [_segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (wSelf.selectedSegmentIndex != idx) {
            NXSegmentItem *segment = wSelf.segments[idx];
            if (segment && segment.titleLabel) {
                segment.titleLabel.textColor = unselectedTextColor;
            }
        }
    }];
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

#pragma mark -
#pragma mark Insert new Segment for SegmentedControl
- (void)insertSegmentTitle:(NSString *)title atIndex:(NSUInteger)index {
    if (title == nil || _segments == nil || index > _segments.count) {
        return;
    }
    
    NXSegmentItem *segment = [[NXSegmentItem alloc]initWithTile:title];
    [self insertSegment:segment atIndex:index];
}

- (void)insertSegmentImage:(UIImage *)image atIndex:(NSUInteger)index {
    if (image == nil || _segments == nil || index > _segments.count) {
        return;
    }
    
    NXSegmentItem *segment = [[NXSegmentItem alloc]initWithImage:image];
    [self insertSegment:segment atIndex:index];
}

- (void)insertSegment:(NXSegmentItem *)segment atIndex:(NSUInteger)idx {
    [_segments insertObject:segment atIndex:idx];
    [self addSubview:segment];
    
    if (!CGRectIsEmpty(self.frame)) {
        [self setSegmentsFrame];
    }
}

#pragma mark -
#pragma mark Handle Event ...
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.bounds, point);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    for (NSUInteger i = 0; i < _segments.count; ++i) {
        CGPoint cPos = [touch locationInView:_segments[i]];
        if ([_segments[i] pointInside:cPos withEvent:event]) {
            
            NXSegmentItem *segment = _segments[i];
            if (segment && segment.titleLabel) {
                segment.titleLabel.backgroundColor = [UIColor lightGrayColor];
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
