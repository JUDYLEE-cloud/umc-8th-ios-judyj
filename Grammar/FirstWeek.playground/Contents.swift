// 변수
var name: String = "JudyJ"
var age: Int = 20
var dogage: Int = 2

name = "leejuhyun"
age = 23
dogage = 3
let ageBool = age > 20

print("name: \(name)")
print("age: \(age)")
print("주인과 개의 나의를 곱하면 \(age * dogage)입니다")
if ageBool {
    print("성인입니다")
} else {
    print("미성년자입니다")
}

// 상수
let pi: Double = 3.1434343
let birthYear: Int = 1999
print("pi: \(pi)")

// 타임 추론 type(of: 00)
var number = 42
var message = "Hello, world"
var isAvailable = true
print(type(of: number))
print(type(of: message))
print(type(of: isAvailable))

// 타입 변환
let intValue: Int = 30
let doubleValue: Double = Double(intValue)
let stringValue: String = String(intValue)

// 빈 문자열 " "
let emptyStringA: String = " "
let emptyStringB: String = String()

// 문자열 연결 +
let firstName: String = "Lee"
let lastName: String = "Juhyun"
let fullName: String = firstName + emptyStringA + lastName
print(fullName)

// 문자열 길이 확인 \(00.count)
let messageNumber: String = "Hello, world!"
print("Hello, world!의 알파벳 개수: \(messageNumber.count)")

// 문자열 비교 if A == B
let strA = "Hello"
let strB = "Hello"
if strA == strB {
    print("strA와 strB의 두 문자열 같음")
}

// 다중 문자열 """
let longMessage = """
 첫번째줄은 이렇게 쓰고
 두번째줄을 이렇게 쓰고
 계속 쓰고 써도 볼 수 있지롱
"""
print(longMessage)

// 문자열 포함 여부 확인 00.contains("00")
let profile = "hello my name is juhyun lee"
print("Does profile contains your name? \(profile.contains("juhyun"))")

// 문자열이 특정 문자열로 시작 또는 끝나는지 확인하는 hasPrefix, hasSuffix
let urlString: String = "www.naver.com"
if urlString.hasPrefix("www") {
    print("이 urlString은 www로 시작합니다")
} else {
    print("이 urlString은 www로 시작하지 않습니다")
}
if urlString.hasSuffix(".com") {
    print("이 urlString은 .com으로 끝납니다")
} else {
    print("이 urlString은 www로 끝나지 않습니다")
}
