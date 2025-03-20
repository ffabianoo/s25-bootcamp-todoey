import SwiftUI
struct Todo: Identifiable {
    var id = UUID()
    var item: String
    var isDone: Bool
}
struct ContentView: View {
    @State private var todos: [Todo] = []
    @State private var todoText: String = ""
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea() // Full screen black background
            VStack {
                // Todo List
                List {
                    ForEach($todos) { $todo in
                        HStack {
                            // Toggle done/undone
                            Button {
                                todo.isDone.toggle()
                            } label: {
                                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.isDone ? .green : .yellow)
                                    .font(.title2)
                            }
                            // Editable task text
                            TextField("Enter task", text: $todo.item)
                                .strikethrough(todo.isDone)
                                .foregroundColor(todo.isDone ? .gray : .white)
                            Spacer()
                        }
                        .listRowBackground(Color.black) // Make list row black
                    }
                }
                .scrollContentBackground(.hidden) // Hide default list bg
                // Input bar at the bottom
                HStack {
                    // Plus button (left)
                    Button {
                        if !todoText.isEmpty {
                            let newTodo = Todo(item: todoText, isDone: false)
                            todos.append(newTodo)
                            todoText = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.yellow)
                            .padding(.horizontal)
                    }
                    // Text field (right)
                    TextField("Enter a task", text: $todoText)
                        .padding(10)
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                .padding()
                .background(Color.black)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom) // Keeps input bar above keyboard
        }
    }
}
#Preview {
    ContentView()
}
