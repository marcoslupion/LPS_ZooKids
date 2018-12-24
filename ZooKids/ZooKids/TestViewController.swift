//
//  TestViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class TestViewController: ViewController {
    var respuesta_dada = "";
    var opciones_mostradas = [String]();
    var opciones_totales = [String]();
    var respuesta_correcta = "Ave";
    
    @IBOutlet weak var opcion_3: UIButton!
    @IBOutlet weak var opcion_2: UIButton!
    @IBOutlet weak var opcion_1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        calcular_correcta();
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func escoge_opcion_1(sender: UIButton) {
        respuesta_dada = (sender.titleLabel?.text)!;
        procesar_resultado();
        
    }
    
    @IBAction func escoge_opcion_2(sender: UIButton) {
        respuesta_dada = (sender.titleLabel?.text)!;
        procesar_resultado();
        
    }
    @IBAction func escoge_opcion_3(sender: UIButton) {
        respuesta_dada = (sender.titleLabel?.text)!;
        procesar_resultado();
        
    }
    func calcular_correcta(){
        //este es el método que calcula cuál es la respuesta correcta de entre todas.
        //respuesta_correctya = lo que salga del metodo
        respuesta_correcta = algoritmo();
        opciones_mostradas.append(respuesta_correcta);
        print("Opcion escogida : ");
        print("Ave");
        generar_2_opciones();
        insertar_botones();
        
    }
    func algoritmo() -> String {
        return "Ave";
    }
    func generar_2_opciones(){
        opciones_totales.append("Mamífero");
        opciones_totales.append("Pez");
        opciones_totales.append("Anfibio");
        opciones_totales.append("Reptil");
        opciones_totales.append("Invertebrado");
        opciones_totales.append("Insecto");
        opciones_totales.append("Ave");
        
        var contador = 0
        while contador<2 {
            let numAleatorio=Int(arc4random_uniform(6))
            if opciones_totales[numAleatorio] != respuesta_correcta && !opciones_mostradas.contains(opciones_totales[numAleatorio]) {
                opciones_mostradas.append(opciones_totales[numAleatorio]);
                print("Opcion escogida : ");
                print(opciones_totales[numAleatorio]);
                print(numAleatorio)
                contador=contador+1;
            }
        }
        
    }
    
    func insertar_botones(){
        print(opciones_mostradas);
        
        var contador = 0 ;
        var numeros_escogidos = [Int]();
        while contador<3 {
            let numAleatorio=Int(arc4random_uniform(3));
            print("Se muestran los numeros");
            if !numeros_escogidos.contains(numAleatorio){
                numeros_escogidos.append(numAleatorio);
                print(numAleatorio);
                contador = contador + 1;
            }
            
        }
        print(opciones_mostradas[numeros_escogidos[0]]);
        print(opciones_mostradas[numeros_escogidos[1]]);
        print(opciones_mostradas[numeros_escogidos[2]]);
        
        opcion_1.setTitle(opciones_mostradas[numeros_escogidos[0]], forState: UIControlState.Normal);
        opcion_2.setTitle(opciones_mostradas[numeros_escogidos[1]], forState: UIControlState.Normal);
        opcion_3.setTitle(opciones_mostradas[numeros_escogidos[2]], forState: UIControlState.Normal);
        
    }
    
    func procesar_resultado(){
        animales[estadoAnimal].respuesta_dada = respuesta_dada;
        animales[estadoAnimal].respuesta_verdadera = respuesta_correcta;
        if respuesta_dada == respuesta_correcta {
            animales[estadoAnimal].resultado = true;
        }else{
            animales[estadoAnimal].resultado = false;
        }
        estadoAnimal = estadoAnimal + 1 ;
        print("EL ANIMAL ACTUAL ES EL ANIMAL : ");
        print(estadoAnimal);
        
        if estadoAnimal == 5{
            print(animales);
            print("ESTE ES EL ULTIMO ANIMAL, POR LO QUE SE NAVEGA");
            //ya se han hecho 5 animales, se navega a la ventana de resultados;
            /*
             if presentingViewController is UINavigationController{
             dismissViewControllerAnimated(true, completion: nil)
             } else {
             navigationController!.popViewControllerAnimated(true)
             }*/
            
            let storyboard = UIStoryboard(name: "Juego", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("resultadosN") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
        }else{
            /*
             if presentingViewController is UINavigationController{
             dismissViewControllerAnimated(true, completion: nil)
             } else {
             navigationController!.popViewControllerAnimated(true)
             }
             */
            
            let storyboard = UIStoryboard(name: "Juego", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
            
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
