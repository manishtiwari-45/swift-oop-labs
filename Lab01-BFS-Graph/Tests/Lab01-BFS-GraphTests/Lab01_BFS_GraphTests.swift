import Testing
@testable import Lab01_BFS_Graph

@Test func example() async throws {
    let graph = Graph(numVertices: 5)

    try graph.addEdge(0, 1)
    try graph.addEdge(0, 2)
    try graph.addEdge(1, 3)
    try graph.addEdge(1, 4)

    try graph.bfs(startVertex: 0)
    
}
