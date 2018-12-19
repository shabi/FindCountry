import Foundation
import SwiftyJSON

public class Translations : SGModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let de = "de"
        static let es = "es"
        static let fr = "fr"
        static let ja = "ja"
        static let it = "it"
        static let br = "br"
        static let pt = "pt"
        static let nl = "nl"
        static let hr = "hr"
        static let fa = "fa"
    }
    
    public var de : String?
    public var es : String?
    public var fr : String?
    public var ja : String?
    public var it : String?
    public var br : String?
    public var pt : String?
    public var nl : String?
    public var hr : String?
    public var fa : String?
    
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
        de = json[SerializationKeys.de].string
        es = json[SerializationKeys.es].string
        fr = json[SerializationKeys.fr].string
        ja = json[SerializationKeys.ja].string
        it = json[SerializationKeys.it].string
        br = json[SerializationKeys.br].string
        pt = json[SerializationKeys.pt].string
        nl = json[SerializationKeys.nl].string
        hr = json[SerializationKeys.hr].string
        fa = json[SerializationKeys.fa].string
       
    }
}
