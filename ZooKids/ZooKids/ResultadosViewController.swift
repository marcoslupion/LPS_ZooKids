//
//  ResultadosViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class ResultadosViewController: ViewController {
    
    @IBOutlet weak var porcentaje: UILabel!
    @IBOutlet weak var mensaje: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let porcentaje_obtenido = calcular_correctas()
        self.porcentaje.text = String(Int(porcentaje_obtenido)) + " %";
        if porcentaje_obtenido > 50{
            mensaje.text = "¡¡Enhorabuena!!";
        }else{
            mensaje.text = "Hay que estudiar más";
        }
        insertar_datos_bd();
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcular_correctas()-> Double {
        var aciertos = 0.0;
        for animal in animales{
            if animal.resultado == true{
                aciertos = aciertos + 1;
            }
        }
        return (aciertos / 5.0) * 100.0;
    }
    
    @IBAction func ir_perfil(sender: UIButton) {
        resetear_variables_globales();
    }
    
    @IBAction func nueva_partida(sender: UIButton) {
        resetear_variables_globales();
    }
    func insertar_datos_bd(){
        //se tiene que recorrer el array de animales, en el que se tienen todos los datos.
        print("UN EJEMPLO DEL PRIMER ANIMAL ES ")
        print(animales[0].respuesta_dada);
        print(animales[0].respuesta_verdadera);
        print(animales[0].imagen);
        print(animales[0].respuestas_dadas);
        print(animales[0].resultado);
        
        //se tiene que meter en la base de datos todos los datos que hay recogidos en animales
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Partida", inManagedObjectContext: managedContext)
        
        //Cargar partidas para coger el id de la última
        
        var idPartida:Int
        idPartida = -1
        
        
        let fetchRequestPartidas = NSFetchRequest(entityName: "Partida")
        do{
            let resultsPartidas = try managedContext.executeFetchRequest(fetchRequestPartidas)
            for partida in resultsPartidas as! [Partida]{
                if (partida.id_partida > idPartida){
                    idPartida = partida.id_partida
                }
            }
            
            idPartida+=1
            
        }catch{
            print("Error")
        }
        
        //Variables para guardar la partida en Core Data
        var numAciertos = 0
        var numFallos = 0
        
        for animal in animales{
            //Aciertos y fallos en las preguntas
            for respuestas in animal.respuestas_dadas{
                if (respuestas == true){
                    numAciertos+=1
                }else{
                    numFallos+=1
                }
            }
            
            //Fallos en la respuesta final
            if(animal.resultado == false){
                //Almacenar fallo en Core Data
                var numFallosAnimal = 0
                var tipoAnimalFallo = ""
                
                //Cargar el tipo de animal para añadir los valores
                let fetchRequestFalloAnimal = NSFetchRequest(entityName: "Fallo")
                do{
                    let resultsFalloAnimal = try managedContext.executeFetchRequest(fetchRequestFalloAnimal)
                    for falloAnimal in resultsFalloAnimal as! [Fallo]{
                        if (falloAnimal.tipo_animal == animal.respuesta_verdadera){
                            numFallosAnimal = falloAnimal.fallos
                            tipoAnimalFallo = falloAnimal.tipo_animal
                        }
                    }
                    
                }catch{
                    print("Error")
                }

                //Añadir un fallo al tipo de animal
                let entity = NSEntityDescription.entityForName("Fallo", inManagedObjectContext: managedContext)
                
                let fallo = Fallo(entity:entity!, insertIntoManagedObjectContext: managedContext)
                fallo.fallos = numFallosAnimal
                fallo.tipo_animal = tipoAnimalFallo
                
                do{
                    try managedContext.save()
                    
                }
                catch{
                    
                    print("error")
                }

            }
        }
        
        //Guardar partida
        let partida = Partida(entity:entity!, insertIntoManagedObjectContext: managedContext)
        
        partida.fecha = NSDate()
        partida.id_partida = idPartida
        partida.num_aciertos = numAciertos
        partida.num_fallos = numFallos
        
        
        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }

        //Resultados partida
        
        //Si se ha seleccionado mal es un fallo
        
    }
    
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
}
