//
// ALAsset+FSClassExtensions.m
//
// The MIT License (MIT)
// 
// Copyright (c) 2014 FocalShift
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <FSClassExtensions/ALAsset+FSClassExtensions.h>
#import <FSClassExtensions/NSError+FSClassExtensions.h>

@implementation ALAsset (FSClassExtensions)

- (BOOL)writeToFileURL:(NSURL *)url error:(NSError * __autoreleasing *)error {
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    CGImageRef image = [assetRepresentation fullResolutionImage];
    NSDictionary *metadata = [assetRepresentation metadata];

    CGImageDestinationRef imageDestination = CGImageDestinationCreateWithURL((__bridge CFURLRef)url, kUTTypeJPEG , 1, NULL);
    if (imageDestination == NULL ) {
        *error = [NSError errorWithDomain:FSClassExtensionsErrorDomian code:FSClassExtensionsFailedToCreateImageDestination userInfo:nil];
        return NO;
    }
    
    CGImageDestinationAddImage(imageDestination, image, (__bridge CFDictionaryRef)metadata);
    
    if (CGImageDestinationFinalize(imageDestination) == NO) {
        *error = [NSError errorWithDomain:FSClassExtensionsErrorDomian code:FSClassExtensionsFailedToFinailzeImageDestination userInfo:nil];
        return NO;
    }
    
    CFRelease(imageDestination);
    return YES;
}

- (void)extractThumbnailImageForAsset:(NSURL *)url handler:(void (^)(UIImage *thumbnail))handler {
    ALAssetsLibraryAssetForURLResultBlock resultsBlock = ^(ALAsset *asset) {
        CGImageRef thumbnailRef = [asset aspectRatioThumbnail];
        UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailRef];
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(thumbnail);
            });
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        UIImage *missingImagePlaceholder = [UIImage imageNamed:@"MissingImage"];
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(missingImagePlaceholder);
            });
        }
    };
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url resultBlock:resultsBlock failureBlock:failureBlock];
}

- (void)extractFullResolutionImageForAsset:(NSURL *)url handler:(void (^)(UIImage *fullResolutionImage))handler {
    ALAssetsLibraryAssetForURLResultBlock resultsBlock = ^(ALAsset *asset) {
        
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        
        // Retrieve the image orientation from the ALAsset
        UIImageOrientation orientation = UIImageOrientationUp;
        NSNumber* orientationValue = [asset valueForProperty:@"ALAssetPropertyOrientation"];
        if (orientationValue != nil) {
            orientation = [orientationValue intValue];
        }
        
        CGFloat scale  = 1;
        UIImage* fullResolutionImage = [UIImage imageWithCGImage:[representation fullResolutionImage]
                                                           scale:scale orientation:orientation];
        
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(fullResolutionImage);
            });
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        UIImage *missingImagePlaceholder = [UIImage imageNamed:@"MissingImage"];
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(missingImagePlaceholder);
            });
        }
    };
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url resultBlock:resultsBlock failureBlock:failureBlock];
}


@end
