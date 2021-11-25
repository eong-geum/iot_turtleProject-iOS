import Foundation
import RealmSwift

class Person:Object{
    @Persisted var uid:String=""
//    @Persisted var name: String = ""
    @Persisted var count: Int?
    @Persisted var date:String?
}
