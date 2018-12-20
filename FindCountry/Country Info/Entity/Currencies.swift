
import Foundation
import SwiftyJSON

public class Currencies : FCModelMappable {
	
    // MARK: Declaration for string constants to be used to decode and also serialize.
	private struct SerializationKeys {

		static let code = "code"
		static let name = "name"
		static let symbol = "symbol"
	}
    
    public var code : String?
    public var name : String?
    public var symbol : String?
    
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
        code = json[SerializationKeys.code].string
        name = json[SerializationKeys.name].string
        symbol = json[SerializationKeys.symbol].string
    }
}
