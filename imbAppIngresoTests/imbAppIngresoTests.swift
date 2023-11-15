//
//  imbAppIngresoTests.swift
//  imbAppIngresoTests
//
//  Created by yesid mendoza on 14/11/23.
//

import XCTest
@testable import imbAppIngreso
import CoreData

final class imbAppIngresoTests: XCTestCase {

    var loginInteractor: LoginInteractor!
       var mockContext: NSManagedObjectContext!
       var mockUserDefaults: UserDefaults!

       override func setUp() {
           super.setUp()
           // Inicializa el interactor y los mocks necesarios
           loginInteractor = LoginInteractor()
           mockContext = setUpMockContext() // Esta función debería crear un contexto simulado
           mockUserDefaults = UserDefaults(suiteName: "#testing") // UserDefaults aislados para pruebas
       }
        private func setUpMockContext() -> NSManagedObjectContext {
            // Crear un modelo de objeto gestionado en memoria
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!

            // Configurar el NSPersistentStoreCoordinator con un almacén en memoria
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            } catch {
                fatalError("Adding in-memory persistent store failed: \(error)")
            }

            // Crear y devolver el NSManagedObjectContext
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = persistentStoreCoordinator

        return context
    }
       override func tearDown() {
           loginInteractor = nil
           mockContext = nil
           mockUserDefaults.removePersistentDomain(forName: "#testing")
           mockUserDefaults = nil
           super.tearDown()
       }

       func testLoginSuccess() {
           // Configura un usuario de prueba en el contexto simulado
           let result = loginInteractor.login(email: "test@example.com", clave: "correctPassword")
           XCTAssertTrue(result, "Login debería ser exitoso con credenciales correctas")
       }

       func testLoginFailureWithWrongCredentials() {
           // Configura un usuario de prueba en el contexto simulado
           let result = loginInteractor.login(email: "test@example.com", clave: "wrongPassword")
           XCTAssertFalse(result, "Login debería fallar con credenciales incorrectas")
       }

       func testLoginFailureWithNoUser() {
           let result = loginInteractor.login(email: "nonexistent@example.com", clave: "password")
           XCTAssertFalse(result, "Login debería fallar si el usuario no existe")
       }


}
