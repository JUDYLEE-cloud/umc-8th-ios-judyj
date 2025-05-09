import UIKit

actor BankAccount {
    var balance: Int
    
    init(balance: Int) {
        self.balance = balance
    }
    
    // 금액 더하기
    func deposit(amount: Int) {
        balance += amount
    }
    
    // 금액 빼기
    func withdraw(amount: Int) {
        if amount <= balance {
            balance -= amount
        }
    }
    
    // 현재 잔액 반환
    func getBalance() -> Int {
        return balance
    }
}

let bankAccount = BankAccount(balance: 1000)
Task {
    let currentBalance = await bankAccount.getBalance()
    print("초기 잔액: \(currentBalance)")
    // 금액 500 추가
    await bankAccount.deposit(amount: 500)
    let updatedBalance = await bankAccount.getBalance()
    print("잔액: \(updatedBalance)")
}
