//
//  ViewController.swift
//  BackgroundColor
//
//  Copyright (c) 2015 Koby Samuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var hueSlider: UISlider!
	@IBOutlet weak var saturationSlider: UISlider!
	@IBOutlet weak var brightnessSlider: UISlider!
	@IBOutlet weak var alphaSlider: UISlider!
	
    let kOnOffToggle="onOff"
    let kHueSetting="hue"
	let kSaturationSetting="saturation"
	let kBrightnessSetting="brightness"
	let kAlphaSetting="alpha"
	var hasNotEnabledHueYet: Bool = true
	
    @IBAction func setBackgroundHueValue(sender: AnyObject?) {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		let initialDefaults: [String: Float] = [kHueSetting: 0, kSaturationSetting: 0.75, kBrightnessSetting: 0.75, kAlphaSetting: 1.0, kOnOffToggle: Float(false)]
		userDefaults.registerDefaults(initialDefaults)
		userDefaults.setBool(toggleSwitch.on, forKey: kOnOffToggle)
        userDefaults.setFloat(hueSlider.value, forKey: kHueSetting)
		userDefaults.setFloat(saturationSlider.value, forKey: kSaturationSetting)
		userDefaults.setFloat(brightnessSlider.value, forKey: kBrightnessSetting)
		userDefaults.setFloat(alphaSlider.value, forKey: kAlphaSetting)
		hueSlider.value = userDefaults.floatForKey(kHueSetting)
		saturationSlider.value = userDefaults.floatForKey(kSaturationSetting)
		brightnessSlider.value = userDefaults.floatForKey(kBrightnessSetting)
		alphaSlider.value = userDefaults.floatForKey(kAlphaSetting)
		toggleSwitch.on = userDefaults.boolForKey(kOnOffToggle)
		userDefaults.synchronize()
        if toggleSwitch.on {
			if(hasNotEnabledHueYet) {
				hueSlider.enabled = true
				saturationSlider.enabled = true
				hasNotEnabledHueYet = false
			}
            view.backgroundColor=UIColor(hue: CGFloat(hueSlider.value),
                saturation: CGFloat(saturationSlider.value), brightness: CGFloat(brightnessSlider.value), alpha: CGFloat(alphaSlider.value))
			
        } else {
			hasNotEnabledHueYet = true
			alphaSlider.value = 1.0
			brightnessSlider.value = 1.0
			hueSlider.enabled = false
			saturationSlider.enabled = false
			userDefaults.setBool(toggleSwitch.on, forKey: kOnOffToggle)
			userDefaults.setFloat(brightnessSlider.value, forKey: kBrightnessSetting)
			userDefaults.setFloat(alphaSlider.value, forKey: kAlphaSetting)
            view.backgroundColor=UIColor.whiteColor()
        }
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		hueSlider.value=userDefaults.floatForKey(kHueSetting)
		saturationSlider.value=userDefaults.floatForKey(kSaturationSetting)
		brightnessSlider.value=userDefaults.floatForKey(kBrightnessSetting)
		alphaSlider.value=userDefaults.floatForKey(kAlphaSetting)
        toggleSwitch.on=userDefaults.boolForKey(kOnOffToggle)
        setBackgroundHueValue(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

