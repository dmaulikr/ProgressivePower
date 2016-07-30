//
//  PlateGenerator.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/29/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import Spring

class PlateGenerator: SpringView {
    let testWeight = 305 //test value
    
    let plateStart = 63 as CGFloat //This is the x position of the 5 px offset from the bar
    let plateOffset = 37.0 as CGFloat //35 + separation of 2 px

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
        self.animation = "squeezeLeft"
        self.animate()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        
    }
    override func drawRect(rect: CGRect) {
        //Draw bars
        drawLeftBar()
        drawRightBar()
        //Draw plates
        var spaceCounter = 0 as CGFloat
        let plates = Algorithm.plateArrayForWeight(testWeight)
        
        for _ in 0..<plates[0] {
            draw45(offset: spaceCounter)
            spaceCounter += 1
        }
        for _ in 0..<plates[1] {
            draw25(offset: spaceCounter)
            spaceCounter += 1
        }
        for _ in 0..<plates[2] {
            draw10(offset: spaceCounter)
            spaceCounter += 1
        }
        for _ in 0..<plates[3] {
            draw5(offset: spaceCounter)
            spaceCounter += 1
        }
        for _ in 0..<plates[4] {
            drawl25(offset: spaceCounter)
            spaceCounter += 1
        }
    }
    func drawLeftBar(){
        
        let color13 = UIColor(red: 0.398, green: 0.398, blue: 0.398, alpha: 1.000)

        //// Left Bar
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 312 - 133, 38, 18))
        UIColor.grayColor().setFill()
        rectanglePath.fill()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(38, 295 - 133, 20, 50))
        UIColor.grayColor().setFill()
        rectangle2Path.fill()
        
        
        
        //// Rectangle 4 Drawing
        let rectangle4Path = UIBezierPath(rect: CGRectMake(38, 297 - 133, 20, 24))
        UIColor.lightGrayColor().setFill()
        rectangle4Path.fill()
        
        
        
        //// Rectangle 5 Drawing
        let rectangle5Path = UIBezierPath(rect: CGRectMake(38, 338 - 133, 20, 7))
        color13.setFill()
        rectangle5Path.fill()
        
    }
    func drawRightBar(){
        let width = self.frame.width
        //// Right Bar
        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(rect: CGRectMake(58, 309 - 133, width - 100, 24))
        UIColor.grayColor().setFill()
        rectangle3Path.fill()
        
        
        //// Rectangle 6 Drawing
        let rectangle6Path = UIBezierPath(rect: CGRectMake(58, 309 - 133, width - 100, 12))
        UIColor.lightGrayColor().setFill()
        rectangle6Path.fill()

    }
    
    
    func draw45(offset offset: CGFloat){
        
        let startValue = ((plateOffset * offset) + plateStart)
        
        let context = UIGraphicsGetCurrentContext()
        let color4: UIColor = UIColor(red: 0.127, green: 0.290, blue: 0.600, alpha: 1.000)
        let color = UIColor(red: 0.197, green: 0.451, blue: 0.934, alpha: 1.000)

        //// 45 lbs
        //// Rectangle 7 Drawing
        let rectangle7Path = UIBezierPath(rect: CGRectMake(startValue, 133 - 133, 35, 375))
        color.setFill()
        rectangle7Path.fill()
        
        
        //// Rectangle 8 Drawing
        let rectangle8Path = UIBezierPath(rect: CGRectMake(startValue, 321 - 133, 35, 157))
        color4.setFill()
        rectangle8Path.fill()
        
        
        //// Rectangle 10 Drawing
        let rectangle10Path = UIBezierPath(rect: CGRectMake(startValue, 133 - 133, 35, 33))
        color4.setFill()
        rectangle10Path.fill()
        
        
        //// Text Drawing
        let textRect = CGRectMake(startValue + 4, 310 - 133, 30, 21)
        let textTextContent = NSString(string: "45")
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(22), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
    }
    func draw25(offset offset: CGFloat){
        
        let startValue = (plateOffset * offset) + plateStart
        
        let context = UIGraphicsGetCurrentContext()
        
        let color5 = UIColor(red: 1.000, green: 0.227, blue: 0.170, alpha: 1.000)
        var color5HueComponent: CGFloat = 1,
        color5SaturationComponent: CGFloat = 1,
        color5BrightnessComponent: CGFloat = 1
        color5.getHue(&color5HueComponent, saturation: &color5SaturationComponent, brightness: &color5BrightnessComponent, alpha: nil)
        let color6 = UIColor(hue: color5HueComponent, saturation: color5SaturationComponent, brightness: 0.7, alpha: CGColorGetAlpha(color5.CGColor))

        //// Group 25 lbs
        //// Rectangle 9 Drawing
        let rectangle9Path = UIBezierPath(rect: CGRectMake(startValue, 196 - 133, 35, 250))
        color5.setFill()
        rectangle9Path.fill()
        
        
        //// Rectangle 11 Drawing
        let rectangle11Path = UIBezierPath(rect: CGRectMake(startValue, 196 - 133, 35, 23))
        color6.setFill()
        rectangle11Path.fill()
        
        
        //// Rectangle 12 Drawing
        let rectangle12Path = UIBezierPath(rect: CGRectMake(startValue, 321 - 133, 35, 104))
        color6.setFill()
        rectangle12Path.fill()
        
        
        //// Text 2 Drawing
        let text2Rect = CGRectMake(startValue + 5, 310 - 133, 30, 21)
        let text2TextContent = NSString(string: "25")
        let text2Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text2Style.alignment = .Left
        
        let text2FontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(22), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: text2Style]
        
        let text2TextHeight: CGFloat = text2TextContent.boundingRectWithSize(CGSizeMake(text2Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text2Rect);
        text2TextContent.drawInRect(CGRectMake(text2Rect.minX, text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, text2Rect.width, text2TextHeight), withAttributes: text2FontAttributes)
        CGContextRestoreGState(context)
    }
    func draw10(offset offset: CGFloat){
        
        let startValue = (plateOffset * offset) + plateStart

        let context = UIGraphicsGetCurrentContext()

        let color7 = UIColor(red: 0.091, green: 0.800, blue: 0.328, alpha: 1.000)
        var color7HueComponent: CGFloat = 1,
        color7SaturationComponent: CGFloat = 1,
        color7BrightnessComponent: CGFloat = 1
        color7.getHue(&color7HueComponent, saturation: &color7SaturationComponent, brightness: &color7BrightnessComponent, alpha: nil)
        
        let color8 = UIColor(hue: color7HueComponent, saturation: color7SaturationComponent, brightness: 0.6, alpha: CGColorGetAlpha(color7.CGColor))
        
        //// Group 10 lbs
        //// Rectangle 13 Drawing
        let rectangle13Path = UIBezierPath(rect: CGRectMake(startValue, 242 - 133, 35, 160))
        color7.setFill()
        rectangle13Path.fill()
        
        
        //// Rectangle 14 Drawing
        let rectangle14Path = UIBezierPath(rect: CGRectMake(startValue, 243 - 133, 35, 16))
        color8.setFill()
        rectangle14Path.fill()
        
        
        //// Rectangle 15 Drawing
        let rectangle15Path = UIBezierPath(rect: CGRectMake(startValue, 321 - 133, 35, 64))
        color8.setFill()
        rectangle15Path.fill()
        
        
        //// Text 3 Drawing
        let text3Rect = CGRectMake(startValue + 5, 310 - 133, 25, 21)
        let text3TextContent = NSString(string: "10")
        let text3Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text3Style.alignment = .Left
        
        let text3FontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(22), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: text3Style]
        
        let text3TextHeight: CGFloat = text3TextContent.boundingRectWithSize(CGSizeMake(text3Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text3Rect);
        text3TextContent.drawInRect(CGRectMake(text3Rect.minX, text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, text3Rect.width, text3TextHeight), withAttributes: text3FontAttributes)
        CGContextRestoreGState(context)
    }
    func draw5(offset offset: CGFloat){
        
        let startValue = (plateOffset * offset) + plateStart
        
        let context = UIGraphicsGetCurrentContext()

        let color9 = UIColor(red: 0.666, green: 0.308, blue: 0.880, alpha: 1.000)
        var color9HueComponent: CGFloat = 1,
        color9SaturationComponent: CGFloat = 1,
        color9BrightnessComponent: CGFloat = 1
        color9.getHue(&color9HueComponent, saturation: &color9SaturationComponent, brightness: &color9BrightnessComponent, alpha: nil)
        
        let color10 = UIColor(hue: color9HueComponent, saturation: color9SaturationComponent, brightness: 0.7, alpha: CGColorGetAlpha(color9.CGColor))
        
        //// Group 5 lbs
        //// Rectangle 16 Drawing
        let rectangle16Path = UIBezierPath(rect: CGRectMake(startValue, 274 - 133, 35, 95))
        color9.setFill()
        rectangle16Path.fill()
        
        
        //// Rectangle 17 Drawing
        let rectangle17Path = UIBezierPath(rect: CGRectMake(startValue, 274 - 133, 35, 10))
        color10.setFill()
        rectangle17Path.fill()
        
        
        //// Rectangle 18 Drawing
        let rectangle18Path = UIBezierPath(rect: CGRectMake(startValue, 321 - 133, 35, 39))
        color10.setFill()
        rectangle18Path.fill()
        
        
        //// Text 4 Drawing
        let text4Rect = CGRectMake(startValue + 11, 311 - 133, 14, 21)
        let text4TextContent = NSString(string: "5")
        let text4Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text4Style.alignment = .Left
        
        let text4FontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(22), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: text4Style]
        
        let text4TextHeight: CGFloat = text4TextContent.boundingRectWithSize(CGSizeMake(text4Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text4FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text4Rect);
        text4TextContent.drawInRect(CGRectMake(text4Rect.minX, text4Rect.minY + (text4Rect.height - text4TextHeight) / 2, text4Rect.width, text4TextHeight), withAttributes: text4FontAttributes)
        CGContextRestoreGState(context)
    }
    func drawl25(offset offset: CGFloat){
        
        let startValue = (plateOffset * offset) + plateStart
        
        let context = UIGraphicsGetCurrentContext()

        let color11 = UIColor(red: 1.000, green: 0.948, blue: 0.284, alpha: 1.000)
        var color11HueComponent: CGFloat = 1,
        color11SaturationComponent: CGFloat = 1,
        color11BrightnessComponent: CGFloat = 1
        color11.getHue(&color11HueComponent, saturation: &color11SaturationComponent, brightness: &color11BrightnessComponent, alpha: nil)
        
        let color12 = UIColor(hue: color11HueComponent, saturation: color11SaturationComponent, brightness: 0.8, alpha: CGColorGetAlpha(color11.CGColor))
        
        
        //// Group 2.5 lbs
        //// Rectangle 19 Drawing
        let rectangle19Path = UIBezierPath(rect: CGRectMake(startValue, 282 - 133, 20, 80))
        color11.setFill()
        rectangle19Path.fill()
        
        
        //// Rectangle 20 Drawing
        let rectangle20Path = UIBezierPath(rect: CGRectMake(startValue, 282 - 133, 20, 10))
        color12.setFill()
        rectangle20Path.fill()
        
        
        //// Rectangle 21 Drawing
        let rectangle21Path = UIBezierPath(rect: CGRectMake(startValue, 321 - 133, 20, 31))
        color12.setFill()
        rectangle21Path.fill()
        
        
        //// Text 5 Drawing
        let text5Rect = CGRectMake(startValue + 4, 290 - 133, 16, 65)
        let text5TextContent = NSString(string: "2.\n5")
        let text5Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text5Style.alignment = .Left
        
        let text5FontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.buttonFontSize()), NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: text5Style]
        
        let text5TextHeight: CGFloat = text5TextContent.boundingRectWithSize(CGSizeMake(text5Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text5FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text5Rect);
        text5TextContent.drawInRect(CGRectMake(text5Rect.minX, text5Rect.minY + (text5Rect.height - text5TextHeight) / 2, text5Rect.width, text5TextHeight), withAttributes: text5FontAttributes)
        CGContextRestoreGState(context)

    }
    
}
