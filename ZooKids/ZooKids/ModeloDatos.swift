//
//  ModeloDatos.swift
//  ZooKids
//
//  Created by Aula11 on 14/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import CoreData

class ModeloDatos: NSManagedObject {

    @NSManaged var animal: String
    @NSManaged var acuaticio: Bool
    @NSManaged var alas: Bool
    @NSManaged var aletas: Bool
    @NSManaged var dientes: Bool
    @NSManaged var esqueleto: Bool
    @NSManaged var leche: Bool
    @NSManaged var pulmones: Bool
    @NSManaged var piernas: Int16
    @NSManaged var resultado: String
}
