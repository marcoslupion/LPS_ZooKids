//
//  Partida.swift
//  ZooKids
//
//  Created by Jose F. Ruiz Zamora on 25/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class Partida: NSManagedObject {
    
    @NSManaged var id_partida: Int16
    @NSManaged var num_aciertos: Int16
    @NSManaged var num_fallos: Int16
    @NSManaged var fecha: NSDate
    @NSManaged var alumno: Alumno


}
