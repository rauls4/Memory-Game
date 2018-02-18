//
//  SoundHelper.swift
//  Memory
//
//  Created by Raul Silva on 2/17/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import Foundation
import AudioToolbox


class SoundHelper {
    class func playSound(name:String){
        if let customSoundUrl = Bundle.main.url(forResource: name, withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            AudioServicesPlaySystemSound(customSoundId)
        }
    }
}
