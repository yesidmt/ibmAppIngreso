//
//  LoginInteractor.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit
import CoreData
import CryptoKit

/// PostUserInteractor Module Interactor
class LoginInteractor: LoginInteractorProtocol {
 
    func login(email: String, clave: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)

        do {
            let result = try context.fetch(fetchRequest)
            if let user = result.first as? NSManagedObject {
                let storedSalt = user.value(forKey: "salt") as! Data
                let storedHash = user.value(forKey: "passwordHash") as! String
                let hashString = hashPassword(clave, with: storedSalt)
                saveLoginState(isLoggedIn: true)
                return hashString == storedHash
            }
        } catch {
            print("Error al recuperar usuario: \(error)")
        }

        return false
    }
    
    private func hashPassword(_ password: String, with salt: Data) -> String {
        let passwordData = Data(password.utf8)
        let saltedPassword = salt + passwordData
        let hashedPassword = SHA256.hash(data: saltedPassword)

        return hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
    }
    // Guardar el estado de la sesión
    private func saveLoginState(isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
    }
}
