//
//  Profesor.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class Profesor: NSManagedObject {

    @NSManaged var nombre_usuario: String
    @NSManaged var contrasenia: String
    @NSManaged var alumnos: [Alumno]
    @NSManaged var email: String
    @NSManaged var fallos: [Fallo]
}
