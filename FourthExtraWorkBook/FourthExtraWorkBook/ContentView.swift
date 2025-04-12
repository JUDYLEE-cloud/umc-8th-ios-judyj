import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    // 데이터를 수정, 삭제
    @Query(sort: \Task.createdAt, order: .reverse) private var tasks: [Task]
    // 데이터를 가져옴
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("할 일을 입력하세요", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("추가") {
                        addTask()
                    }
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Button {
                                toggleDone(task)
                            } label: {
                                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(task.isDone ? .green : .gray)
                                    .imageScale(.large)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .strikethrough(task.isDone)
                                Text(task.createdAt.formatted(date: .numeric, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("할 일 목록")
        }
    }
    
    private func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let task = Task(title: trimmed) //새로운 task 추가
        context.insert(task) // 데이터에 추가
        try? context.save() // 저장
        newTaskTitle = ""
    }
    
    // task의 isDone 속성을 바꾸는 함수
    private func toggleDone(_ task: Task) {
                        task.isDone.toggle()
                        try? context.save()
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
        context.delete(tasks[index]) // 삭제 요청
        }
        try? context.save() // 삭제 확정
    }
}

#Preview {
    ContentView()
}
