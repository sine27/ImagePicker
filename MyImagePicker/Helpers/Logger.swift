/**
 Literal        Type     Value
 
 #file          String   The name of the file in which it appears.
 #line          Int      The line number on which it appears.
 #column        Int      The column number in which it begins.
 #function      String   The name of the declaration in which it appears.
 #dsohandle     String   The dso handle.
 */


import Foundation

let Log = MyLogger()

enum Mark: String {
    case start = "\n🔻 "
    case note = "   * "
    case error = "\n❌ "
    case warning = "\n⚠️ "
    case message = "\n💚 "
    case todo = "\n🌵TODO: "
    case question = "\n❓"
    case tab = "    "
}

func + (left: Mark, right: String) -> String {
    switch left {
    case .start, .note, .error, .warning, .message, .todo:
        return left.rawValue + right
    default:
        return left.rawValue + " \(right) " + left.rawValue
    }
}

enum Seperator: String {
    case line = "----------"
    case start = ">>>>>>>>>>"
    case end = "<<<<<<<<<<"
    case dot = ".........."
    case space = "          "
    case star = "**********"
    case jing = "##########"
    case underline = "__________"
}

class MyLogger {
    
    let line = "\n"
    let end = "🔺"
    
    func error(funcName: String, data: Any) {
        print(Mark.error + funcName)
        print(data)
        print(Mark.error + Seperator.end.rawValue + line)
    }
    
    func warning(funcName: String, data: Any) {
        print(Mark.warning + funcName)
        print(data)
        print(Mark.warning + Seperator.end.rawValue + line)
    }
    
    func todo(funcName: String?, data: Any) {
        print(Mark.todo + (funcName ?? ""))
        print(data)
        print(Mark.todo + Seperator.end.rawValue + line)
    }
    
    func message(funcName: String?, data: Any) {
        print(Mark.message + (funcName ?? ""))
        print(data)
        print(Mark.message + Seperator.end.rawValue + line)
    }
    
    func question(funcName: String?, data: Any) {
        print(Mark.question + (funcName ?? ""))
        print(data)
        print(Mark.question + Seperator.end.rawValue + line)
    }

}
