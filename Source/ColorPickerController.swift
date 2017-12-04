//
//  ColorPickerController.swift
//
//  Created by Matthias Schlemm on 24/03/15.
//  Copyright (c) 2015 Sixpolys. All rights reserved.
//

import UIKit

public class ColorPickerController: NSObject {
    
    public var onColorChange:((_ color:UIColor, _ finished:Bool)->Void)? = nil
    
    // Hue Picker
    public var huePicker:HuePicker
    
    // Color Well
    public var colorWell:ColorWell {
        didSet {
            huePicker.setHueFromColor(color: colorWell.color)
            colorPicker.color =  colorWell.color
        }
    }
    
    
    // Color Picker
    public var colorPicker:ColorPicker
    
    public var color:UIColor? {
        set(value) {
            colorPicker.color = value!
            colorWell.color = value!
            huePicker.setHueFromColor(color: value!)
        }
        get {
            return colorPicker.color
        }
    }
    
    public init(svPickerView:ColorPicker, huePickerView:HuePicker, colorWell:ColorWell) {
        self.huePicker = huePickerView
        self.colorPicker = svPickerView
        self.colorWell = colorWell
        self.colorWell.color = colorPicker.color
        self.huePicker.setHueFromColor(color: colorPicker.color)
        super.init()
        self.colorPicker.onColorChange = {(color, finished) -> Void in
            self.huePicker.setHueFromColor(color: color)
            self.colorWell.previewColor = (finished) ? nil : color
            if(finished) {self.colorWell.color = color}
            self.onColorChange?(color, finished)
        }
        self.huePicker.onHueChange = {(hue, finished) -> Void in
            self.colorPicker.h = CGFloat(hue)
            let color = self.colorPicker.color
            self.colorWell.previewColor = (finished) ? nil : color
            if(finished) {self.colorWell.color = color}
            self.onColorChange?(color, finished)
        }
    }
    
}
