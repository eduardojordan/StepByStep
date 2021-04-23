//
//  Localisator.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit

let kNotificationLanguageChanged = "kNotificationLanguageChanged"

func localizedString(_ string: String) -> String {
    return Localisator.sharedInstance.localizedStringForKey(string)
}

func setLanguage(_ language: String) -> Bool {
    return Localisator.sharedInstance.setLanguage(language)
}

func getLanguage() -> String {
    return Localisator.sharedInstance.currentLanguage
}

class Localisator {

    // MARK: - Private properties

    fileprivate let userDefaults = UserDefaults.standard
    fileprivate var availableLanguagesArray = ["Spanish_es"]
    fileprivate var dicoLocalisation: NSDictionary!

    // MARK: - Public properties

    var currentLanguage = "DeviceLanguage" //"Spanish_es"

    // MARK: - Public computed properties

    var saveInUserDefaults: Bool {
        get {
            return (userDefaults.object(forKey: "kSaveLanguageDefaultKey") != nil)
        }
        set {
            if newValue {
                userDefaults.set(currentLanguage, forKey: "kSaveLanguageDefaultKey")
            } else {
                userDefaults.removeObject(forKey: "kSaveLanguageDefaultKey")
            }
            userDefaults.synchronize()
        }
    }

    // MARK: - Singleton method
    class var sharedInstance: Localisator {
        struct Singleton {
            static let instance = Localisator()
        }
        return Singleton.instance
    }

    // MARK: - Init method
    init() {
        currentLanguage = userDefaults.object(forKey: "kSaveLanguageDefaultKey") as? String ?? "Catalan_ca"

        if (loadDictionaryForLanguage(currentLanguage)) {
            NSLog("Dicionario de nuevo idioma encontrado")
        } else {
            NSLog("No existe el diccionario del nuevo idioma")
        }
    }

    // MARK: - Public custom getter
    func getArrayAvailableLanguages() -> [String] {
        return availableLanguagesArray
    }

    // MARK: - Private instance methods
    fileprivate func loadDictionaryForLanguage(_ newLanguage: String) -> Bool {
        let arrayExt = newLanguage.components(separatedBy: "_")

        for ext in arrayExt {
            if let path = Bundle(for: object_getClass(self)!).url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: ext)?.path {
                if FileManager.default.fileExists(atPath: path) {
                    currentLanguage = newLanguage
                    dicoLocalisation = NSDictionary(contentsOfFile: path)
                    return true
                }
            }
        }
        return false
    }

    fileprivate func localizedStringForKey(_ key: String) -> String {
        if currentLanguage.elementsEqual("Spanish_es") {
            UIApplication.shared.accessibilityLanguage = "es-ES"
        } else {
            UIApplication.shared.accessibilityLanguage = "es-ES"
        }
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            } else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }

    fileprivate func setLanguage(_ newLanguage: String) -> Bool {
        if (newLanguage == currentLanguage) || !availableLanguagesArray.contains(newLanguage) {
            return false
        }

        currentLanguage = newLanguage
        dicoLocalisation = nil
        NotificationCenter.default.post(name: Notification.Name(rawValue: kNotificationLanguageChanged), object: nil)
        userDefaults.set(currentLanguage, forKey: "kSaveLanguageDefaultKey")

        if loadDictionaryForLanguage(newLanguage) {
            if newLanguage == "Spanish_es" {
                UIApplication.shared.accessibilityLanguage = "es-ES"
            } else {
                UIApplication.shared.accessibilityLanguage = "es-ES"
            }
            return true
        }
        return false
    }

    static func getCurrentLanguage() -> String {
        return UserDefaults.standard.object(forKey: "kSaveLanguageDefaultKey") as? String ?? "Spanish_es"
    }

    static func getCurrentTagLanguage() -> String {
        return (UserDefaults.standard.object(forKey: "kSaveLanguageDefaultKey") as? String ?? "Spanish_es").components(separatedBy: "_")[1].lowercased()
    }

    static func getCurrentTagLanguageForDB() -> String {
        if let tagLanguage = UIApplication.shared.accessibilityLanguage {
            return tagLanguage.components(separatedBy: "-")[1]
        } else {
            return "ES"
        }
    }
    
}
