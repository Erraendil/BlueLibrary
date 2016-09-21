//
//  HorizontalScroller.m
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "HorizontalScroller.h"

// Constants for propper view representation
#define VIEW_PADDING    10
#define VIEW_DIMENSIONS 100
#define VIEWS_OFFSET    100

// Add UIScrollViewDelegate to use scrolling
@interface HorizontalScroller() <UIScrollViewDelegate>

@end

@implementation HorizontalScroller {
    UIScrollView * scroller;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scroller.delegate = self;
        [self addSubview:scroller];
        
        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [scroller addGestureRecognizer:tapRecognizer];
    }
    
    return self;
}

- (void)didMoveToSuperview {
    [self reload];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self centerCurrentView];
}

#pragma mark - Custom Methods

- (void)scrollerTapped:(UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:gesture.view];
    
    for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index++) {
        UIView * view = scroller.subviews[index];
        if (CGRectContainsPoint(view.frame, location)) {
            [self.delegate horizontalScroller:self viewAtIndex:index];
            CGPoint offset = CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0);
            [scroller setContentOffset:offset animated:YES];
            break;
        }
    }
}

- (void)reload {
    // Do not download anything if there is no delegate
    if (self.delegate == nil) return;
    
    // Remove all subviews
    [scroller.subviews enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL * stop) {
        [obj removeFromSuperview];
    }];
    
    // Set initial point of all views in scroll
    CGFloat xValue = VIEWS_OFFSET;
    
    for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index++) {
        xValue += VIEW_PADDING;
        UIView * view = [self.delegate horizontalScroller:self viewAtIndex:index];
        view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        [scroller addSubview:view];
        xValue += VIEW_DIMENSIONS + VIEW_PADDING;
    }
    
    // When all views are set resetting scroller view
    [scroller setContentSize:CGSizeMake(xValue + VIEWS_OFFSET, self.frame.size.height)];
    
    // If initial view is defined setting it to center of scroller
    if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]) {
        int initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
        CGPoint offset = CGPointMake(initialView * (VIEW_DIMENSIONS + (2 * VIEW_PADDING)), 0);
        [scroller setContentOffset:offset animated:YES];
    }
}

- (void)centerCurrentView {
    int xFinal = scroller.contentOffset.x + (VIEWS_OFFSET / 2) + VIEW_PADDING;
    int viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    xFinal = viewIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    [scroller setContentOffset:CGPointMake(xFinal, 0) animated:YES];
    [self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
}

@end
