import Foundation

do {

    let graph = Graph(numVertices: 4)

    try graph.addEdge(0, 1)
    try graph.addEdge(0, 2)
    try graph.addEdge(1, 3)
    try graph.addEdge(2, 3)

    print("Example 1")
    try graph.bfs(startVertex: 0)

} catch {

    print(error.localizedDescription)
}