import Foundation
import SwiftyJSON

public class Languages : FCModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let iso639_1 = "iso639_1"
        static let iso639_2 = "iso639_2"
        static let name = "name"
        static let nativeName = "nativeName"
    }
    
    public var iso639_1 : String?
    public var iso639_2 : String?
    public var name : String?
    public var nativeName : String?
  
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        iso639_1 = json[SerializationKeys.iso639_1].string
        iso639_2 = json[SerializationKeys.iso639_2].string
        name = json[SerializationKeys.name].string
        nativeName = json[SerializationKeys.nativeName].string
    }
}
