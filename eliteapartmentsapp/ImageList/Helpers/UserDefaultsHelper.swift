//
//  UserDefaultsHelper.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private let userDefaults: UserDefaults

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save<T: Encodable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encodedObject = try? encoder.encode(object) {
            userDefaults.set(encodedObject, forKey: key)
        }
    }

    func fetch<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let savedObject = userDefaults.object(forKey: key) as? Data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: savedObject)
    }

    func delete(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
