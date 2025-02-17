import Foundation

public class Localization: LocalizationProvider {
    private static let selectedLanguageKey = "selectedLanguage"
    private static var bundle: Bundle?
    
    ///  Public initializer to allow access from other modules
    public init() {}  


    public func localized(_ key: String) -> String {
        return NSLocalizedString(key, tableName: nil, bundle: Localization.getCurrentBundle(), value: "**\(key)**", comment: "")
    }

    public static var currentLanguage: String {
        if let userSelectedLanguage = UserDefaults.standard.string(forKey: selectedLanguageKey) {
            return userSelectedLanguage
        }
        let systemLanguage = Locale.preferredLanguages.first ?? "en"
        let languageCode = systemLanguage.components(separatedBy: "-").first ?? "en"
        let supportedLanguages = ["en", "es", "fr", "de", "ja", "hi"]
        return supportedLanguages.contains(languageCode) ? languageCode : "en"
    }

    public static func setLanguage(_ language: String) {
        UserDefaults.standard.setValue(language, forKey: selectedLanguageKey)
        UserDefaults.standard.synchronize()
        bundle = getBundle(for: language)
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }

    public static func resetToSystemLanguage() {
        UserDefaults.standard.removeObject(forKey: selectedLanguageKey)
        UserDefaults.standard.synchronize()
        bundle = getBundle(for: currentLanguage)
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }

    private static func getCurrentBundle() -> Bundle {
        if let bundle = bundle {
            return bundle
        }
        return getBundle(for: currentLanguage)
    }

    private static func getBundle(for language: String) -> Bundle {
        if let path = Bundle.module.path(forResource: language, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }
        return Bundle.module
    }
}

extension Notification.Name {
    public static let languageChanged = Notification.Name("languageChanged")
}






//import Foundation
//
//public class Localization {
//    private static let selectedLanguageKey = "selectedLanguage"
//    private static var bundle: Bundle?
//
//    /// Returns the localized string
//    public static func localized(_ key: String, comment: String = "") -> String {
//        return NSLocalizedString(key, tableName: nil, bundle: getCurrentBundle(), value: "**\(key)**", comment: comment)
//    }
//
//    /// Get the currently set language, respecting system preferences
//    public static var currentLanguage: String {
//        let userSelectedLanguage = UserDefaults.standard.string(forKey: selectedLanguageKey)
//        let systemLanguage = Locale.preferredLanguages.first ?? "en"
//
//        if let userLang = userSelectedLanguage {
//            print("🔄 User-selected Language: \(userLang)")
//            return userLang
//        } else {
//            print("🌎 System Language: \(systemLanguage)")
//
//            // ✅ Extract only the language code (e.g., "fr" from "fr-FR")
//            let languageCode = systemLanguage.components(separatedBy: "-").first ?? "en"
//
//            // ✅ List of supported languages in the app
//            let supportedLanguages = ["en", "es", "fr", "de", "ja", "hi"] // Add more as needed
//
//            // ✅ If the detected language is in the supported list, return it. Otherwise, default to "en".
//            return supportedLanguages.contains(languageCode) ? languageCode : "en"
//        }
//    }
//
//
//    /// Change language dynamically and refresh UI
//    public static func setLanguage(_ language: String) {
//        print("🌍 Switching Language to: \(language)")
//        UserDefaults.standard.setValue(language, forKey: selectedLanguageKey)
//        UserDefaults.standard.synchronize()
//        bundle = getBundle(for: language)
//
//        NotificationCenter.default.post(name: .languageChanged, object: nil)
//    }
//
//    /// Get the correct localization bundle
//    private static func getCurrentBundle() -> Bundle {
//        if let bundle = bundle {
//            return bundle
//        }
//        return getBundle(for: currentLanguage)
//    }
//
//    /// Get the bundle for a specific language
//    private static func getBundle(for language: String) -> Bundle {
//        if let path = Bundle.module.path(forResource: language, ofType: "lproj"),
//           let bundle = Bundle(path: path) {
//            print("✅ Using Language Bundle: \(language)")
//            return bundle
//        }
//        print("❌ Missing Localization for \(language), falling back to default")
//        return Bundle.module
//    }
//}
//
//extension Notification.Name {
//    public static let languageChanged = Notification.Name("languageChanged")
//}
