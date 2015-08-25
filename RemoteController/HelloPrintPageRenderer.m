//
//  Renderer.m
//  RemoteController
//
//  Created by will on 8/25/15.
//  Copyright © 2015 githubutilities. All rights reserved.
//

#import "HelloPrintPageRenderer.h"

@implementation HelloPrintPageRenderer

- (NSInteger) numberOfPages {
    return 5;
}

- (void) drawContentForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)contentRect {
    NSString *string = @"HELLO";
    [string drawAtPoint:CGPointZero withAttributes:nil];
}



@end
