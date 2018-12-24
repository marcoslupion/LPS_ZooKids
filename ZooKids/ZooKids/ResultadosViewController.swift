//
//  ResultadosViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

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
        
    }
    
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
}
