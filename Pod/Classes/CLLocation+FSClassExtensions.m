//
// CLLocation+FSClassExtensions.m
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

#import <FSClassExtensions/CLLocation+FSClassExtensions.h>
#import <FSClassExtensions/NSDate+FSClassExtensions.h>

#import <ImageIO/ImageIO.h>

@implementation CLLocation (FSClassExtensions)

- (NSDictionary*)EXIFMetadataWithHeading:(CLHeading*)heading {
    NSMutableDictionary *GPSMetadata = [NSMutableDictionary dictionary];
    
    NSNumber *altitudeRef = [NSNumber numberWithInteger: self.altitude < 0.0 ? 1 : 0];
    NSString *latitudeRef = self.coordinate.latitude < 0.0 ? @"S" : @"N";
    NSString *longitudeRef = self.coordinate.longitude < 0.0 ? @"W" : @"E";
    NSString *headingRef = @"T"; // T: true direction, M: magnetic
    
    // GPS metadata
    
    [GPSMetadata setValue:[NSNumber numberWithDouble:ABS(self.coordinate.latitude)] forKey:(NSString*)kCGImagePropertyGPSLatitude];
    [GPSMetadata setValue:[NSNumber numberWithDouble:ABS(self.coordinate.longitude)] forKey:(NSString*)kCGImagePropertyGPSLongitude];
    
    [GPSMetadata setValue:latitudeRef forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
    [GPSMetadata setValue:longitudeRef forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
    
    [GPSMetadata setValue:[NSNumber numberWithDouble:ABS(self.altitude)] forKey:(NSString*)kCGImagePropertyGPSAltitude];
    [GPSMetadata setValue:altitudeRef forKey:(NSString*)kCGImagePropertyGPSAltitudeRef];
    
    [GPSMetadata setValue:[self.timestamp ISOTime] forKey:(NSString*)kCGImagePropertyGPSTimeStamp];
    [GPSMetadata setValue:[self.timestamp ISODate] forKey:(NSString*)kCGImagePropertyGPSDateStamp];
    
    if (heading) {
        [GPSMetadata setValue:[NSNumber numberWithDouble:heading.trueHeading] forKey:(NSString*)kCGImagePropertyGPSImgDirection];
        [GPSMetadata setValue:headingRef forKey:(NSString*)kCGImagePropertyGPSImgDirectionRef];
    }
    
    return [GPSMetadata copy];
}

@end

