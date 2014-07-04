//
//  NXSegmentedControl.h
//  NXSegmentedControlDemo
//
//  Created by iNuoXia on 14-7-1.
//  Copyright (c) 2014年 NuoXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NXSegmentedControl;
@protocol NXSegmentedControlDelegate <NSObject>

-(void)segmentedControl:(NXSegmentedControl *)segmentedControl didSelectedIndex:(NSUInteger)index;

@end

@interface NXSegmentedControl : UIControl

@property (nonatomic, assign) CGFloat fontSize; // default 14.f
@property (nonatomic, strong) UIColor *selectedTextColor; // default white color
@property (nonatomic, strong) UIColor *selectedSegmentColor; // default RGB(0x5f, 0x64, 0x6e)
@property (nonatomic, strong) UIColor *unselectedTextColor;  // default RGB(0x5f, 0x64, 0x6e)
@property (nonatomic, strong) UIColor *unselectedSegmentColor; // default white color

@property (nonatomic, assign) CGFloat cornerRadius;     // default 4.0f
@property (nonatomic, assign) CGFloat borderWidth;      // default 1.0f
@property (nonatomic, strong) UIColor *borderColor;     // default RGB(0x5f, 0x64, 0x6e)

@property (nonatomic, assign) NSUInteger selectedSegmentIndex; // default 0
@property (nonatomic, readonly) NSUInteger numberOfSegments;
@property (nonatomic, weak) id<NXSegmentedControlDelegate> delegate;

/**
 *  constuct
 *
 *  @param items   just image or title, not both
 *  @param delegate for callback
 *
 *  @return self
 */
-(instancetype)initWithItems:(NSArray*)items selectedSegmentDelegate:(id)delegate;

/**
 *  construct
 *
 *  @param items         just support image or title
 *  @param selectedBlock for callback
 *
 *  @return self
 */
-(instancetype)initWithItems:(NSArray*)items selectedSgementIndex:(void (^)(NSUInteger index))selectedBlock;

/**
 *  insert an item. content: title
 *
 *  @param title item content
 *  @param index item position
 */
-(void)insertSegmentTitle:(NSString*)title atIndex:(NSUInteger)index;

/**
 *  insert an item. content: image
 *
 *  @param image item content
 *  @param index item position
 */
-(void)insertSegmentImage:(UIImage*)image atIndex:(NSUInteger)index;

@end
