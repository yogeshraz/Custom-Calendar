//
//  ViewController.m
//  CustomCalender
//
//  Created by Yogesh Raj on 12/29/17.
//  Copyright © 2017 Yogesh Raj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int month;
    int year;
    int moyearStartednth;
    CGFloat buttonH;
    CGFloat buttonW;
    NSString *startDate;
    NSString *endDate;
    NSString *isFirstSelectedDate;
    NSString *isSecondSelectedDate;
    NSArray *weekArray;
    NSArray *monthArray;
    UILabel *label;
    
}

@property (nonatomic,strong) IBOutlet UIView *weeksView;
@property (nonatomic,strong) IBOutlet UIView *calenderView;
@property (nonatomic,strong) IBOutlet UILabel *yearWithMonth;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /////////// Set Button size ////////////////
    CGFloat width = self.view.frame.size.width - 30;
    buttonH = width/7;
    buttonW = buttonH;
    
    /////Week Array Month Array///////
    weekArray = [NSArray arrayWithObjects:@"S",@"M",@"T",@"W",@"T",@"F",@"S", nil];
    monthArray = [NSArray arrayWithObjects:@"",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    
    
    //// Create Weeks////////
    [self createWeeks];
    
    //// Create Calender////////
    [self createCalender];
}

#pragma mark - Create Weeks Names
-(void)createWeeks
{
    int xpos = 16;
    int ypos = 3;
    
    for (int i=0; i<weekArray.count; i++)
    {
        label = [[UILabel alloc]initWithFrame:CGRectMake(xpos, ypos, buttonW-5, buttonH-5)];
        
        label.text=[weekArray objectAtIndex:i];
        label.backgroundColor = [UIColor clearColor];
        label.font=[UIFont systemFontOfSize:17];
        label.layer.cornerRadius = label.frame.size.width / 2;
        label.clipsToBounds=YES;
        label.textAlignment = NSTextAlignmentCenter;
        if (i==0)
        {
            label.textColor=[UIColor redColor];
        }
        else
        {
            label.textColor=[UIColor colorWithRed:52/255.0 green:72/255.0 blue:94/255.0 alpha:0.50];
        }
        [self.weeksView addSubview:label];
        
        xpos = xpos+buttonW;
    }
}

-(void)createCalender
{
    NSString *currentDate = [[self returnDateFormatter] stringFromDate:[NSDate date]];
    NSLog(@"%@",currentDate);
    
    /////Current Date //////////
    NSArray *stringArray = [currentDate componentsSeparatedByString: @"/"];
    //NSString *currentDate = [stringArray objectAtIndex:0];
    NSString *currentMonth = [stringArray objectAtIndex:1];
    NSString *currenteYear = [stringArray objectAtIndex:2];
    
    month = [currentMonth intValue];
    year = [currenteYear intValue];
    moyearStartednth = [currenteYear intValue];
    
    self.yearWithMonth.text = [NSString stringWithFormat:@"%@ %d",[monthArray objectAtIndex:month],year];
    
    NSDate *date = [[self returnDateFormatter] dateFromString:[NSString stringWithFormat:@"1/%d/%d",month,year]
                    ];
    int numberOfDays = [self getNumberOfDays:month withDate:date];
    long index =  [self getFirstWeekDay:date];
    
    [self createButtonsAndLablesForNumberOfDays:numberOfDays withStartingAtDay:index];
    
}
#pragma mark - returnDateFormatter
-(NSDateFormatter *)returnDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return formatter;
}

#pragma mark - returnMonthFormatter
-(NSDateFormatter *)returnMonthFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return formatter;
}

#pragma mark - returnWeekDayArray
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

#pragma mark - createButtonsAndLablesForNumberOfDays
-(void)createButtonsAndLablesForNumberOfDays:(int)days withStartingAtDay:(long)startIndex
{
    for (UIView *v  in [self.calenderView subviews])
    {
        [v removeFromSuperview];
    }
    int xpos = 15;
    int ypos = 1;
    
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
        label.font=[UIFont systemFontOfSize:17];
        label.textColor=[UIColor colorWithRed:124/255.0 green:132/255.0 blue:162/255.0 alpha:1.0];
        label.layer.cornerRadius = label.frame.size.width / 2;
        label.clipsToBounds=YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self.calenderView addSubview:label];
        
        
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
            label.backgroundColor = [UIColor colorWithRed:26/255.0 green:178/255.0 blue:194/255.0 alpha:1];
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
        [dateButton addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.calenderView addSubview:dateButton];
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

#pragma mark - Date Selection
-(IBAction)dateSelected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (isFirstSelectedDate.length ==0)
    {
        isFirstSelectedDate = [NSString stringWithFormat:@"%ld/%d/%d",(long)btn.tag, month, year];
        label.backgroundColor = [UIColor orangeColor];
    }
    else
    {
        if (isFirstSelectedDate.length!=0 && isSecondSelectedDate.length!=0)
        {
            isFirstSelectedDate = [NSString stringWithFormat:@"%ld/%d/%d",(long)btn.tag, month, year];
            isSecondSelectedDate = nil;
        }
        else
        {
            NSDate *localstartDate = [[self returnDateFormatter] dateFromString:startDate];
            NSDate *localendDate = [[self returnDateFormatter] dateFromString:endDate];
            
            if ([localendDate compare:localstartDate]==NSOrderedAscending)
            {
                isFirstSelectedDate = [NSString stringWithFormat:@"%ld/%d/%d",(long)btn.tag, month, year];
            }
            else
            {
                isSecondSelectedDate = [NSString stringWithFormat:@"%ld/%d/%d",(long)btn.tag, month, year];
            }
        }
    }
    
    NSLog(@"%@\n%@",isFirstSelectedDate,isSecondSelectedDate);
    
    NSDate *date = [[self returnDateFormatter] dateFromString:[NSString stringWithFormat:@"1/%d/%d",month,year]
                    ];
    int numberOfDays = [self getNumberOfDays:month withDate:date];
    long index =  [self getFirstWeekDay:date];
    [self createButtonsAndLablesForNumberOfDays:numberOfDays withStartingAtDay:index];
}

#pragma mark - Press Left
- (IBAction)pressLeft:(id)sender {
    
    month = month-1;
    if (month<=0)
    {
        month = 12;
        year = year-1;
    }
    self.yearWithMonth.text = [NSString stringWithFormat:@"%@ %d",[monthArray objectAtIndex:month],year];
    NSLog(@"%d Month:-",month);
    NSLog(@"%d Year:-",year);
    
    NSDate *date = [[self returnDateFormatter] dateFromString:[NSString stringWithFormat:@"1/%d/%d",month,year]];
    
    
    int numberOfDays = [self getNumberOfDays:month withDate:date];
    long index =  [self getFirstWeekDay:date];
    
    [self createButtonsAndLablesForNumberOfDays:numberOfDays withStartingAtDay:index];
}

#pragma mark - Press Right
- (IBAction)pressRight:(id)sender {
    
    
    month = month+1;
    
    if (month>12)
    {
        month = 1;
        year = year+1;
    }
    self.yearWithMonth.text = [NSString stringWithFormat:@"%@ %d",[monthArray objectAtIndex:month],year];
    NSLog(@"%d Month:-",month);
    NSLog(@"%d Year:-",year);
    
    NSDate *date = [[self returnDateFormatter] dateFromString:[NSString stringWithFormat:@"1/%d/%d",month,year]];
    
    
    int numberOfDays = [self getNumberOfDays:month withDate:date];
    long index =  [self getFirstWeekDay:date];
    
    [self createButtonsAndLablesForNumberOfDays:numberOfDays withStartingAtDay:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
