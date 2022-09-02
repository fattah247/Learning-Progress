//
//  UIColor+Additions.m
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

#import "UIColor+Additions.h"


@implementation UIColor (Additions)

+ (UIColor *) colorFromHexString:(NSString *)hexString{
  NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
  if([cleanString length] == 3){
    cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@"], [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)];
  }
  if([cleanString length] == 6){
    cleanString = [cleanString stringByAppendingString:@"ff"];
  }
  
  unsigned int baseValue;
  [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
}

+(UIColor *) colorForNavigationBarBackground{
  return [self colorFromHexString:@"2A99E5"];
}

+(UIColor *) colorForFilterSegmentedControlBackground{
  return [self colorFromHexString:@"1a6fa8"];
}

@end
