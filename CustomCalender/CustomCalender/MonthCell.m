//
//  MonthCell.m
//  CustomCalender
//
//  Created by Yogesh Raj on 1/9/18.
//  Copyright © 2018 Yogesh Raj. All rights reserved.
//

#import "MonthCell.h"

@implementation MonthCell


-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)GetMonth:(int)month GetYear:(int)year
{
    NSDate *date = [[self returnDateFormatter] dateFromString:[NSString stringWithFormat:@"1/%d/%d",month,year]
                    ];
    int numberOfDays = [self getNumberOfDays:month withDate:date];
    long index =  [self getFirstWeekDay:date];
    
    NSLog(@"%d Month:-",month);
    NSLog(@"%d Year:-",year);
    
    CGFloat width = self.frame.size.width - 37;
    
    buttonH = width/7;
    buttonW = buttonH;
    
    [self createButtonsAndLablesForNumberOfDays:numberOfDays withStartingAtDay:index];
}

-(NSDateFormatter *)returnDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return formatter;
}

-(NSDateFormatter *)returnMonthFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return formatter;
}

-(NSArray *)returnWeekDayArray
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    return formatter.shortWeekdaySymbols;
}

-(int)getNumberOfDays:(int)month withDate:(NSDate *)date
{
    NSCalendar *cal = NSCalendar.currentCalendar;
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = month;
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay
                              inUnit:NSCalendarUnitMonth
                             forDate:date];
    return (int)range.length;
}

-(long)getFirstWeekDay:(NSDate *)date
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:date];
    return [comp weekday];
    
}

-(void)createButtonsAndLablesForNumberOfDays:(int)days withStartingAtDay:(long)startIndex
{
    for (UIView *v  in [self.scrollContentView subviews])
    {
        [v removeFromSuperview];
    }
    int xpos = 15;
    int ypos = 0;
    
    for (int xcount =1; xcount<=7; xcount++)
    {
        if (xcount==startIndex)
        {
            break;
        }
        xpos = xpos+buttonW;
    }
    
    for (int i = 1; i<=days; i++)
    {
        label = [[UILabel alloc]initWithFrame:CGRectMake(xpos, ypos, buttonW-5, buttonH-5)];
        label.text=[NSString stringWithFormat:@"%d",i];
        label.font=[UIFont boldSystemFontOfSize:14.0];
        label.textColor=[UIColor colorWithRed:87/255.0 green:212/255.0 blue:218/255.0 alpha:1.0];
        label.layer.cornerRadius = label.frame.size.width / 2;
        label.clipsToBounds=YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self.scrollContentView addSubview:label];
        
        
        UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dateButton.frame = CGRectMake(xpos, ypos, buttonW, buttonH);
        
        
        //compare date to place marker over current date
        NSString *actualDate = [[NSString alloc]initWithFormat:@"%d/%d/%d",i,month,year];
        NSDate *date = [[self  returnDateFormatter] dateFromString:actualDate];
        NSString *todayDatestr= [[self returnDateFormatter] stringFromDate:[NSDate date]];
        NSDate *todayDate = [[self returnDateFormatter]dateFromString:todayDatestr];
        NSComparisonResult result = [date compare:todayDate];
        // compare date with today date to display current date
        if (result==NSOrderedSame)
        {
            label.backgroundColor = [UIColor yellowColor];
        }
        
        if (isFirstSelectedDate!=nil)
        {
            NSDate *startDate = [[self returnDateFormatter] dateFromString:isFirstSelectedDate];
            if ([startDate compare:date]==NSOrderedSame)
            {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = [UIColor redColor];
                [label layoutIfNeeded];
            }
        }
        
        if (isSecondSelectedDate!=nil)
        {
            NSDate *endDate = [[self returnDateFormatter] dateFromString:isSecondSelectedDate];
            NSDate *startDate = [[self returnDateFormatter] dateFromString:isFirstSelectedDate];
            if ([endDate compare:date]==NSOrderedSame)
            {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = [UIColor redColor];
                [label layoutIfNeeded];
            }
            
            
            if ([date compare:endDate]==NSOrderedAscending && [date compare:startDate]==NSOrderedDescending)
            {
                label.textColor = [UIColor redColor];
            }
        }
        dateButton.tag=i;
        //[dateButton addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollContentView addSubview:dateButton];
        xpos=xpos+buttonW;
        startIndex=startIndex+1;
        
        if (startIndex==8)
        {
            xpos=15;
            ypos=ypos+buttonH;
            startIndex=1;
        }
        
    }
}
@end
