//: Playground - noun: a place where people can play

import UIKit

var config = ScreenshotConfig()
config.backgroundColor = UIColor(red: 118.0 / 255.0, green: 122 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
config.fontSizeScaleY = 0.05
config.titles = [
    "edhita1" : "Text Editing",
    "edhita2" : "Preview",
    "edhita3" : "Text Editing",
    "edhita4" : "Live Preview",
]

let creator = ScreenshotCreator(config: config)
creator.preview()

creator.save()
