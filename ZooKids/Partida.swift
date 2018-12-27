//
//  Partida.swift
//  ZooKids
//
//  Created by Jose F. Ruiz Zamora on 26/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

@objc(Partida)

class Partida: NSManagedObject {
    
    @NSManaged var id_partida: Int16
    @NSManaged var num_aciertos: Int16
    @NSManaged var num_fallos: Int16
    @NSManaged var fecha: NSDate
    
    
}

