//
//  AsyncImageView.h
//  ESIB_PAD_SOURCES
//
//  Created by Elias Medawar on 12.07.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView {

	NSURLConnection* connection;
	NSMutableData* data; //keep reference to the data so we can collect it as it downloads
	
}

- (void)loadImageFromURL:(NSURL*)url;

@end
