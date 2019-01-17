//
//  BarrasAciertosTabla.swift
//  ZooKids
//
//  Created by Alberto Fuentes on 12/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit

class BarrasAciertosTabla: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    // MARK: atributos
    var botones = [UIButton]()
    let tamanio = CGRect(x: 0, y: 0, width: 35, height: 25)
    
    // MARK: inicialización
    
    /*override init(frame: CGRect){
     super.init(frame: frame)
     
     
     }*/
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        /*total = BarrasAciertosTabla.nAciertos + BarrasAciertosTabla.nErrores
        cantAciertos = (Double(BarrasAciertosTabla.nAciertos) / Double(total))*10*/
       // if(!cantAciertos.isNaN){
            /*print("Aciertos: ",BarrasAciertosTabla.nAciertos," total: ",total," porcentaje = ", cantAciertos, " de ", BarrasAciertosTabla.nombre)*/
            for i in 0..<10{
                let boton = UIButton(frame: tamanio)
                boton.adjustsImageWhenHighlighted = false
                boton.tag = i
                botones += [boton]
                addSubview(boton)
            }
        //}
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 17.5, height: 25)
    }
    
    
    //método para mostrar las vistas, por defecto lo hace de forma apilada.
    override func layoutSubviews() {
        for (i, boton) in botones.enumerate() {
            boton.frame.origin.x = CGFloat(i * (17 + 0))
        }
        
    }
}
