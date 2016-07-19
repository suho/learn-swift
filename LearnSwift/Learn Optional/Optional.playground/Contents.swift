//: iOS Training - Optional

import Foundation
//: # Optional
//: Một người LUÔN LUÔN có một tên (name), CÓ THỂ có tên ở nhà (nickname) hoặc không.

class Person {
    var name: String
    var nickname: String?
    
    init(name: String) {
        self.name = name
    }
}

/*:
 - Trong Swift, ta dùng Optional để chỉ "absence of value".
 - Khi khai báo một property, dùng ? đằng sau kiểu dữ liệu để chỉ property đó là optional, có thể chứa một giá trị nào đó hoặc không chứa giá trị nào.
 - Như trong ví dụ: nickname là optional, ta thêm dấu ? vào sau String.
 */

//: Trong ví dụ trên, thử xoá bỏ dấu ? đằng sau kiểu dữ liệu String khi khai báo nickname. Chuyện gì sẽ xảy ra?
//: Complier Error: Return from initializer without initializing all stored properties. Lỗi này có nghĩa là bạn không khởi tạo giá trị cho các stored properties (bạn nào chưa biết về stored property và computed property thì tìm hiểu thêm nhé, ở đây cứ hiểu chung là properties). Trong Swift, khi khai báo property thì bạn khởi tạo giá trị cho nó.
//: Vì sao khi bỏ dấu ? đi thì lại gây ra lỗi này?
//: Bởi vì khi bỏ dấu ? đi, property nickname sẽ không còn là optional nữa, nghĩa là nó luôn luôn có giá trị, do đó bạn cần phải khởi tạo giá trị cho nó.
//: Với Optional, không bắt buộc phải khởi tạo giá trị cho property

//: # nil

//: Bây giờ, giả sử có em gái tên khai sinh là Hương, tên ở nhà là Mèo.
let person = Person(name: "Huong")
person.nickname = "Meo"

//: Sau này lơn lên, Hương không muốn dùng tên Mèo nữa vì xấu hổ. Bạn trai của Hương hỏi: "Tên ở nhà của em là gì", Hương trả lời: "Em không có tên ở nhà". Như vậy, ban đầu nickname chứa giá trị là Mèo, nhưng sau đó nickname không chứa giá trị nào nữa.

//: Trong Swift, ta dùng nil để chỉ optional variable không chứa giá trị nào cả
person.nickname = nil


//: # Unwrap optional

//: Bây giờ hãy xem đoạn code sau sẽ sinh ra compiler error "Value of optional type 'String?' is not unwrapped"
//let nickname: String = person.nickname
//: Vì khi khai báo 'let nickname: String' nghĩa là nickname là non-optional, trong khi person.nickname là optional.

//: Trong Swift, Chúng ta dùng dấu chấm than (!) để ép một optional thành non-optional. Việc đặt ! vào sao optional variable đề ép optional thành non-optional gọi là "Forced unwrap optional"
person.nickname = "Meo"
let nonOptionalNickname: String = person.nickname!

//: Nếu chúng ta forced unwrap optional không chứa giá trị (nil), runtime error sẽ xảy ra. Do đó, khi dùng forced unwrap optional, phải chắc chắn rằng optional có chứa giá trị.
//: Sử dụng If statement để kiểm tra optional có giá trị hay không
let optionalNickname = person.nickname
if optionalNickname != nil {
    //print(optionalNickname!) //sử dụng ! để forced unwrap optional
} else {
    //optionalNickname không chứa giá trị
}

//: Làm như vậy có nhược điểm là cứ mỗi khi cần dùng optionalNickname ta đều cần phải thêm ! vào sau để forced unwrap optional.
//: Có một cải tiến như sau
if optionalNickname != nil {
    let nonOptionalNickname = optionalNickname!
    //print(nonOptionalNickname) //không cần sử dụng ! nữa
} else {
    //optionalNickname không chứa giá trị
}

//: Đoạn code này có thể viết lại ngắn gọn và dễ hiểu hơn bằng việc áp dụng Optional binding như dưới đây.

//: # Optional Binding

//: Optional binding kiểm tra xem một optional có chứa giá trị hay không, nếu có thì gán giá trị đó cho một biến mới, và ta có thể sử dụng biến mới đó như là non-optional. Sự khác nhau giữa optinal binding và đoạn code trước là gộp chung việc gán giá trị của optional cho biến mới vào if statement luôn.
if let nonOptionalNickname = optionalNickname {
    //print(nonOptionalNickname)
} else {
    //optionalNickname không chứa giá trị
}

//: # Implicitly Unwrapped Optional

//: Implicitly unwrapped Optional nghĩa là optional được ngầm định được unwrap nên khi dùng ta không cần phải unwrap nữa, dùng như non-optional variable, không cần thêm dấu ! đằng sau. Tuy nhiên nó vẫn là optional nên có thể gán nil được trong khi non-optional thì không thể. Hãy xem ví dụ sau

var implicitlyUnwrappedOptionalString: String! = "An Optional String"
let forcedUnwrapOptionalString: String = implicitlyUnwrappedOptionalString // Không cần !, không cần unwrap
implicitlyUnwrappedOptionalString = nil // OK

//: Implicitly unwrapped optional được dùng trong trường hợp mà một optional CHẮC CHẮN LUÔN LUÔN có giá trị kể từ sau khi được gán giá trị lần đầu tiên. Hãy xem ví dụ sau:


 class Country {
 var city: City!
 init() {
 self.city = City(country: self)
 }
 }
 
 class City {
 unowned let country: Country // các bạn tìm hiểu thêm về unowned và weak nhé, sẽ có hướng dẫn sau
 init(country: Country) {
 self.country = country
 }
 }
 

//: Thoạt nhìn có vẻ đoạn code trên có vẻ OK, ta đểu khởi tạo đầy đủ cho các stored properties. Tuy nhiên có compiler error xảy ra: "self used before all stored properites are initialized"

//: Xem lại hàm init của Country class, ta init một City với tham số là một Country (self). Tuy nhiên self chưa thể dùng nếu tất cả các properties chưa được khởi tạo xong. Ở đây self cần city được khởi tạo, trong khi city lại cần dùng self để khởi tạo. Do đó đã xảy ra lỗi.

//: Cách giải quyết ở đây là dùng implicitly unwrapped optional cho city. Thêm `!` vào sau kiểu dữ liệu `City` trong khai báo `var city: City`. Vì sao cách này lại có thể giải quyết được vấn đề?

//: Bởi vì chuyển city thành optional, tất cả stored properties đã được khởi tạo, do đó self có thể được dùng trong việc init city

//: Chú ý: khi dùng implicitly unwrapped optional, phải chắc chắn rằng optional phải luôn luôn có giá trị sau lần gán giá trị đầu tiên, nếu vô tình optional được gán nil và sau được được truy cập đến, runtime error sẽ xảy ra -> crash chương trình


//: # BÀI TẬP

//: 1. Tìm hiểu optional chaining
//: 2. Những phần code sau OK hay có lỗi, lỗi compiler error hay runtime error, giải thích tại sao?

/*:
 ```
 var foo: Int = 10
 foo = nil
 ```
 */

/*:
 ```
 let foo: Int? = 10
 ```
 */

/*:
 ```
 class Foo {
 func bar()
 }
 let foo: Foo?
 foo?.bar()
 ```
 */

/*:
 ```
 class Foo {
 func bar()
 }
 let foo: Foo?
 foo!.bar()
 ```
 */

/*:
 ```
 class Foo {
 func bar()
 }
 let foo: Foo?
 foo.bar()
 ```
 */
