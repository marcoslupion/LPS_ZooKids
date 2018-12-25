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
        
        //Guardar partida
        let partida = Partida(entity:entity!, insertIntoManagedObjectContext: managedContext)
        
        partida.fecha = NSDate()
        partida.id_partida = idPartida
        //partida.num_aciertos = 0
        //partia.num_fallos = 0
        
        
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
