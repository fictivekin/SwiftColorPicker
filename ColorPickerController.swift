//
//  ColorPickerController.swift
//
//  Created by Matthias Schlemm on 24/03/15.
//  Copyright (c) 2015 Sixpolys. All rights reserved.
//

import UIKit

class ColorPickerController: NSObject {
    
    var onColorChange:((color:UIColor)->Void)? = nil
    
    // Hue Picker
    var huePicker:HuePicker
    
    // Color Well
    var colorWell:ColorWell
    
    
    // Color Picker
    var colorPicker:ColorPicker
    
    var color:UIColor? {
        set(value) {
            colorPicker.color = value!
            colorWell.color = value!
            huePicker.setHueFromColor(value!)
        }
        get {
            return colorPicker.color
        }
    }
    
    init(svPickerView:ColorPicker, huePickerView:HuePicker, colorWell:ColorWell) {
        self.huePicker = huePickerView
        self.colorPicker = svPickerView
        self.colorWell = colorWell
        self.colorWell.color = colorPicker.color
        self.huePicker.setHueFromColor(colorPicker.color)
        super.init()
        self.colorPicker.onColorChange = {(color, finished) -> Void in
            self.huePicker.setHueFromColor(color)
            self.colorWell.previewColor = (finished) ? nil : color
            if(finished) {self.colorWell.color = color}
        }
        self.huePicker.onHueChange = {(hue, finished) -> Void in
            self.colorPicker.h = CGFloat(hue)
            let color = self.colorPicker.color
            self.colorWell.previewColor = (finished) ? nil : color
            if(finished) {self.colorWell.color = color}
        }
    }
    
}