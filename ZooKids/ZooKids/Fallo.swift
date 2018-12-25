//
//  Fallo.swift
//  ZooKids
//
//  Created by Jose F. Ruiz Zamora on 25/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

@objc(Fallo)

class Fallo: NSManagedObject {

    @NSManaged var fallos: Int
    @NSManaged var tipo_animal: String
    
}
