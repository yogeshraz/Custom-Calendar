//
//  ViewController.h
//  CustomCalender
//
//  Created by Yogesh Raj on 12/29/17.
//  Copyright © 2017 Yogesh Raj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) id delegate;
@property (nonatomic,assign) BOOL isShowPreviousNextMonthDays;
@property (nonatomic,assign) int currentMonth;
@property (nonatomic,assign) int currentYear;

@property (nonatomic,strong) NSArray *weekDayNamesArray;

@property (nonatomic,strong) NSString *firstDateSelected;
@property (nonatomic,strong) NSString *secondDateSelected;

@property (nonatomic,strong) UIColor *todayDateBackGroundColor;
@property (nonatomic,strong) UIColor *normalDateColor;
@property (nonatomic,strong) UIColor *selectedDateColor;
@property (nonatomic,strong) UIColor *highlightedDateColor;
@property (nonatomic,strong) UIColor *highlightedDateBackgroundColor;
@property (nonatomic,strong) UIColor *disableDateColor;

@property (nonatomic,strong) IBOutlet UIView *scrollContentView;
@property (nonatomic,strong) IBOutlet UILabel *lblMonthName;
@property (nonatomic,strong) IBOutlet UIView *weeks;
@end

