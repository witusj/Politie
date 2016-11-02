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
    'https://docs.google.com/spreadsheets/d/1gEz-Y9DIAwoz7WFkLFkkWPt0aYzE8axHm0bIf4suRss/pub?gid=0&single=true&output=csv'
  )

nodeData <-
  gsheet2tbl(
    'https://docs.google.com/spreadsheets/d/1gEz-Y9DIAwoz7WFkLFkkWPt0aYzE8axHm0bIf4suRss/pub?gid=887688557&single=true&output=csv'
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
    fillcolor = nodeData$Color,
    shape = nodeData$Shape,
    tooltip = nodeData$Value,
    width = 0.65,
    fixedsize = "true",
    fontsize = 8
  )

edges <-
  create_edges(
    from = edgeData$From_node,
    to = edgeData$To_node,
    color = edgeData$Color,
    penwidth = 1.5,
    fontsize = 6,
    label = edgeData$Label,
    tooltip = edgeData$Tooltip,
    style = edgeData$Style
  )


graph <-
  create_graph(
    nodes_df = nodes,
    edges_df = edges,
    graph_attrs = c("layout = neato", "tooltip = 'Beweeg over elementen voor meer informatie'"),
    node_attrs = "fontname = Helvetica",
    edge_attrs = c("arrowsize = 0.2", "fontname = Helvetica")
  )

fff1 <- render_graph(graph)
saveWidget(fff1, 'diagram2.html')

