//
//  RegisterInteractor.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import CryptoKit
import UIKit
import CoreData
/// PostUserInteractor Module Interactor
class RegisterInteractor: RegisterInteractorProtocol {
    
    func register(email: String, nombre: String, apellido: String, clave: String) -> Bool {
        guard !userExists(email: email) else {
            print("El usuario ya existe.")
            return false
        }

        let salt = generateSalt()
        let hashString = hashPassword(clave, with: salt)

        // Preparar el objeto User para CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)!

        let user = NSManagedObject(entity: userEntity, insertInto: context)
        user.setValue(email, forKey: "email")
        user.setValue(nombre, forKey: "nombre")
        user.setValue(apellido, forKey: "apellido")
        user.setValue(hashString, forKey: "passwordHash")
        user.setValue(salt, forKey: "salt")

        do {
            try context.save()
            return true
        } catch {
            print("Error al guardar: \(error)")
            return false
        }
    }
    
    private func generateSalt(size: Int = 32) -> Data {
        var salt = Data(count: size)
        let result = salt.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, size, $0.baseAddress!)
        }
        if result == errSecSuccess {
            return salt
        } else {
            fatalError("No se pudo generar el salt")
        }
    }

    private func hashPassword(_ password: String, with salt: Data) -> String {
        let passwordData = Data(password.utf8)
        let saltedPassword = salt + passwordData
        let hashedPassword = SHA256.hash(data: saltedPassword)

        return hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    private func userExists(email: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error al verificar la existencia del usuario: \(error)")
            return false
        }
    }
    
}
