import UIKit

actor OrderListActor {
    var orderList: [String] = []
    
    // 주문이 들어옴
    func addOrder(_ order: String) {
        orderList.append(order)
    }
    
    // 조리 완료. 가장 첫 주문 제거
    func processOrder() -> String? {
        guard !orderList.isEmpty else { return nil }
        
        let compeletedOrder = orderList.removeFirst()
        print("\(compeletedOrder) 제거됨.")
        return compeletedOrder
    }
    
    // 현재 주문 리스트 반환
    func printAllOrders() {
        print("남은 주문 목록: \(orderList)")
    }
}

let orderListActor = OrderListActor()
Task {
    await orderListActor.addOrder("Pizza")
    await orderListActor.addOrder("Burger")
    await orderListActor.addOrder("Pasta")
    
    // pizza 제거
    // pizza 제거 됐다고 출력
    await orderListActor.processOrder()
    
    // Burger 제거
    // burder 제거 됐다고 출력
    await orderListActor.processOrder()
    
    // printAllOrder로 남은 메뉴 pasta 출력
    await orderListActor.printAllOrders()
    // pasta 제거
    // pasta 제거 됐다고 출력
    await orderListActor.processOrder()
    
    // printAllOrder로 남은 메뉴 없다고 출력
    await orderListActor.printAllOrders()
}

