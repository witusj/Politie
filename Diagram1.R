###
# Create a graph with both nodes and edges
# defined, and, add some default attributes
# for nodes and edges
###

library(DiagrammeR)
library(gsheet)
library(htmlwidgets)

edgeData <-
  gsheet2tbl(
    'https://docs.google.com/spreadsheets/d/1h6dpyW5cxiGz0grEabKrzfyKBF7_Od583eQjvSZh-9I/pub?gid=0&single=true&output=csv'
  )

nodeData <-
  gsheet2tbl(
    'https://docs.google.com/spreadsheets/d/1h6dpyW5cxiGz0grEabKrzfyKBF7_Od583eQjvSZh-9I/pub?gid=887688557&single=true&output=csv'
  )

edgeData$From_node <- gsub(" ", "\n", edgeData$From_node)
edgeData$To_node <- gsub(" ", "\n", edgeData$To_node)
nodeData$Name <- gsub(" ", "\n", nodeData$Name)
nodeData$Text <- paste0(nodeData$Text)

# Create a node data frame
nodes <-
  create_nodes(
    nodes = nodeData$Name,
    label = FALSE,
    type = "lower",
    style = "filled",
    color = nodeData$Color,
    shape = nodeData$Shape,
    width = 1,
    fixedsize = "true",
    fontsize = 10
  )

edges <-
  create_edges(
    from = edgeData$From_node,
    to = edgeData$To_node,
    color = edgeData$Color,
    minlen = edgeData$Len,
    penwidth = 2,
    fontsize = 8,
    label = edgeData$Label,
    tooltip = edgeData$Tooltip,
    style = edgeData$Style
  )

graph <-
  create_graph(
    nodes_df = nodes,
    edges_df = edges,
    graph_attrs = c("layout = dot", "rankdir = LR", "tooltip = 'Beweeg over elementen voor meer informatie'"),
    node_attrs = "fontname = Helvetica",
    edge_attrs = c("arrowsize = 0.6", "fontname = Helvetica")
  )

# Examine the NDF within the
# graph object
graph$nodes_df


graph$edges_df

fff <- render_graph(graph)
saveWidget(fff, 'diagram.html')