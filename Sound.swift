//
//  Sound.swift
//  soundBoard
//
//  Created by Merritte on 2/18/15.
//  Copyright (c) 2015 Merritte. All rights reserved.
//

import Foundation
import CoreData

class Sound: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String

}
