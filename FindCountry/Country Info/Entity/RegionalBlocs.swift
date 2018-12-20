import Foundation
import SwiftyJSON

public class RegionalBlocs : FCModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let acronym = "acronym"
        static let name = "name"
        static let otherAcronyms = "otherAcronyms"
        static let otherNames = "otherNames"
    }
    
    public var acronym : String?
    public var name : String?
    public var otherAcronyms : [String]?
    public var otherNames : [String]?
    
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
        acronym = json[SerializationKeys.acronym].string
        name = json[SerializationKeys.name].string
        if let items = json[SerializationKeys.otherAcronyms].array { otherAcronyms = items.map { $0.object} as? [String] }
        if let items = json[SerializationKeys.otherNames].array { otherNames = items.map { $0.object} as? [String] }
    }
}
