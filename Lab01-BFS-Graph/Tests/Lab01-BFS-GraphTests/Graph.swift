// Graph.swift

import Foundation

class Graph {

    private let numVertices: Int
    private var adjacencyList: [[Int]]

    init(numVertices: Int) {

        guard numVertices > 0 else {
            fatalError("Number of vertices must be greater than 0")
        }

        self.numVertices = numVertices
        self.adjacencyList = Array(
            repeating: [],
            count: numVertices
        )
    }

    func addEdge(_ v1: Int, _ v2: Int) throws {

        guard isValidVertex(v1) else {
            throw GraphError.invalidVertex(v1)
        }

        guard isValidVertex(v2) else {
            throw GraphError.invalidVertex(v2)
        }

        adjacencyList[v1].append(v2)
        adjacencyList[v2].append(v1)
    }

    func bfs(startVertex: Int) throws {

        guard isValidVertex(startVertex) else {
            throw GraphError.invalidVertex(startVertex)
        }

        var visited = Array(
            repeating: false,
            count: numVertices
        )

        var queue: [Int] = []

        visited[startVertex] = true
        queue.append(startVertex)

        print("BFS Traversal:", terminator: " ")

        while !queue.isEmpty {

            let currentVertex = queue.removeFirst()

            print(currentVertex, terminator: " ")

            for neighbor in adjacencyList[currentVertex] {

                if !visited[neighbor] {

                    visited[neighbor] = true
                    queue.append(neighbor)
                }
            }
        }

        print()
    }

    private func isValidVertex(_ vertex: Int) -> Bool {

        return vertex >= 0 &&
               vertex < numVertices
    }
}

enum GraphError: Error {
    case invalidVertex(Int)
}

extension GraphError: LocalizedError {

    var errorDescription: String? {

        switch self {

        case .invalidVertex(let vertex):
            return "Invalid vertex: \(vertex)"
        }
    }
}