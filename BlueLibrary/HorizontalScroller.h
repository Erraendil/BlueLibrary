//
//  HorizontalScroller.h
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalScrollerDelegate;

@interface HorizontalScroller : UIView

/*! 
 @brief     Delegate property for protocol HorizontalScrollerDelegate.
 */
@property (weak) id <HorizontalScrollerDelegate> delegate;

/*!
 @brief     Reloads data for HorizontalScroller.
 @return    Nothing.
 */
- (void)reload;

@end

@protocol HorizontalScrollerDelegate <NSObject>

@required

/*!
 @breif     Request from HorizontalScroller instace how many representations will be shown.
 @param     scroller - HorizontalScroller instance to work with.
 @return    Numeber of views to show in HorizontalScroller.
 */
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller;

/*!
 @breif     Request from HorizontalScroller instace for view to present by index.
 @param     scroller - HorizontalScrollerinstance to work with.
 @param     index - int index of view to present.
 @return    View for presentation.
 */
- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index;

/*!
 @breif     Pass to HorizontalScroller instace for view which were clicked by ind
 @param     scroller - HorizontalScrollerinstance to work with.
 @param     index - int index of view were clicked.
 @return    Nothing.
 */
- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(in)index;

@optional

/*!
 @breif     Request from HorizontalScroller instace which view to display after i
 @param     scroller - HorizontalScroller instance to work with.
 @return    Index of view to display.
 */
- (int)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller;

@end
