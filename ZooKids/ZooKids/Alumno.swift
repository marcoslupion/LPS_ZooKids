//
//  Alumno.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

@objc(Alumno)

class Alumno: NSManagedObject {
    
    @NSManaged var contrasenia: String
    @NSManaged var fecha_nacimiento: NSDate
    @NSManaged var foto: String
    @NSManaged var nombre_usuario: String
    @NSManaged var sexo: String

}
