import SwiftUI

struct BindableChildView: View {
    
    @Bindable var counter: Counter
    
    var body: some View {
        Button("Child Increment") {
            counter.count += 1
        }
    }
}
