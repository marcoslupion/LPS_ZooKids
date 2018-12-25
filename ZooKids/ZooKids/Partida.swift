//
//  Partida.swift
//  ZooKids
//
//  Created by Jose F. Ruiz Zamora on 25/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

@objc(Partida)
final class Partida: NSManagedObject {
    
    @NSManaged var id_partida: Int
    @NSManaged var num_aciertos: Int
    @NSManaged var num_fallos: Int
    @NSManaged var fecha: NSDate


}
