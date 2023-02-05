//
//  Nota+Custom.swift
//  NotasCoreData
//
//  Created by David López on 5/2/23.
//

import Foundation

extension Nota {
    //Devuelve una subcadena solo con la primera letra del texto
    @objc var inicial: String? {
        if let textoNoNil = self.texto {
            return String(textoNoNil.first!)
        }
        else {
            return nil
        }
    }
}
