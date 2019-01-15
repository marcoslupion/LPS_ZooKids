import UIKit //Eliminamos Foundation

class Animal{
    //MARK: atributos
    var imagen: Int
    var respuesta_dada: String
    var respuesta_verdadera_establecida: String
    var respuesta_verdadera_algoritmo: String
    var respuestas_dadas = [Int]();
    var resultado : Bool;
    var nombre : String;
    //MARK: Inicialización
    init(){
        self.imagen = 0;
        self.respuesta_dada = "";
        self.respuesta_verdadera_algoritmo = "";
        self.respuesta_verdadera_establecida = "";
        self.resultado = false;
        self.nombre = "";
    }
    
    
}
