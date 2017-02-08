//
//  CollectionViewCell.m
//  InstaJEPG
//
//  Created by Siddharth Patel on 2/7/17.
//  Copyright © 2017 Siddharth Patel. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell () {
    UIImageView *imageView;
}

@end

@implementation CollectionViewCell


-(void) drawImage:(NSString *)theImage {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"default.jpg"];

    [self performSelectorInBackground:@selector(drawImageInBg:) withObject:theImage];

    [self addSubview:imageView];

}


-(void) drawImageInBg:(NSString *) img{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    
    [self performSelectorOnMainThread:@selector(drawOnMain:) withObject:data waitUntilDone:YES];

}

-(void)drawOnMain:(NSData *) data {
    imageView.image = [UIImage imageWithData:data];
}



@end






