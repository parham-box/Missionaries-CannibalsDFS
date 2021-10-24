//Declaring variables
//index of last visited node
int lastVisited = 0;
//all the nodes in the memory
ArrayList<State> nodes = new ArrayList<State>();
//index of the goal state
int goalIndex = 0;
//the initial state of the game
State initalState = new State(3, 3, "L");
//the goal state of the game
State goalState = new State(0, 0, "R");
ArrayList<Integer> status = new ArrayList<Integer>();

void setup() {
  size(350, 700); //size of the window
  background(255);//setting white background
  //DFS Algorith:
  //add root to nodes
  nodes.add(initalState);
  /*Add status of root.
   
   0 is nodes with children,
   1 is goal node,
   -1 is not valid nodes,
   2 is already visited nodes
   */
  status.add(0);
  //loop until the algorithm finds the answer
  while (true) {
    //to check if node is already visited
    //if flag is true node has been visited before
    boolean flag = false;
    State cur = nodes.get(lastVisited);
    for (int i = 0; i < lastVisited; i++) {
      if (cur.isEqual(nodes.get(i))) {
        flag = true;
        break;
      }
    }
    //printing current node
    println("--------");
    print("Current state: ");
    cur.printState();
    //if current node is goal
    if (cur.isEqual(goalState)) {
      goalIndex = lastVisited;
      println("GOAL STATE");
      break;
    }
    //if current node is valid
    if (cur.isValid()) {
      //if current node is not visited
      if (!flag) {
        State[] nextStates = cur.nextStates();
        for (int i = 0; i < nextStates.length; i++) {
          //visit the node
          //add children right after parent node
          //by adding all of the children of a node after the parent node, it will search the tree DFS.
          nodes.add(lastVisited+i+1, nextStates[i]);
        }
      } else {
        //aready visited node
        println("Visited Before");
      }
    } else {
      //not a valid state
      println("Not a valid state");
    }
    //go to next state
    lastVisited++;
    println("--------");
  }

  //Visualizing the graph on GUI

  //Graph Legend:
  //LIGHT BLUE: Root node
  //RED: Not a valid node
  //BLUE: Previously visited node
  //BLACK: Node with children
  //GREEN: Path node

  //helpers to show the search tree coordinates
  int v = 1;
  int y = 0;
  //an array with id of each nodes parent in the array
  int[] parentNodeNumber = new int[goalIndex+1];
  //root node does not have a parent
  parentNodeNumber[0] = -1;
  //for every visited node
  for (int x = 1; x <= goalIndex; x++) {
    boolean flag = false;
    State cur = nodes.get(x);
    //add state of each node
    for (int i = 0; i < x; i++) {
      if (cur.isEqual(nodes.get(i))) {
        flag = true;
      }
    }
    //go through all the visited nodes and assign the status
    if (nodes.get(x).isValid()) {
      if (!flag) {

        status.add(0);
      } else {
        status.add(2);
      }
    } else {
      status.add(-1);
    }
    //to find parent index
    for (int k = 0; k < x; k++) {
      if (nodes.get(x).getParent().isEqual(nodes.get(k))) {
        parentNodeNumber[x] = k;
        break;
      }
    }
  }
  //color of forground is black
  fill(0);
  ArrayList<Integer> rowIndex = new ArrayList<Integer>();
  for (int i = 0; i <= goalIndex; i++) {
    //if not inital state
    if (i!=0) {
      //find rows of the tree base on change in boat side
      if (nodes.get(i).getSide() == nodes.get(i-1).getSide()) {
        //if items are in the same row
        //move items in same row to right everytime
        y++;
      } else {
        //if item is in a new row
        //go down
        v++;
        //start from the left
        y =0;
        rowIndex.add(i);
      }
      int parentIndex = parentNodeNumber[i];
      //find what number parents is in, in the previous row by subtracting its index from last the last item in previous row
      int li = 0;
      for (int x = 1; x < rowIndex.size(); x++) {
        if (parentIndex < rowIndex.get(x)) {
          li = parentIndex - rowIndex.get(x -1);
          break;
        }
      }
      //find path from inital state to goal state
      ArrayList<Integer> path = new ArrayList<Integer>();
      path.add(goalIndex);
      int parent = parentNodeNumber[goalIndex];
      path.add(parent);

      while (true) {
        if (parent != 0) {
          parent = parentNodeNumber[parent];
          path.add(parent);
        } else {
          break;
        }
      }
      stroke(0);
      //assign different color to each state
      if (i == goalIndex) {
        stroke(color(0, 150, 0));
        fill(color(0, 150, 0));
      } else if (path.contains(i)) {
        fill(color(0, 150, 0));
        stroke(color(0, 150, 0));
      } else if (status.get(i) == 2) {
        fill(color(0, 0, 256));
      } else if (status.get(i) == -1) {
        fill(color(256, 0, 0));
      } else {
        fill(0);
      }

      line(30+(li*50)+25, 30+((v-1)*50) + 10, 30+(y*50) + 25, 30+(v*50)-15);

      text(nodes.get(i).stateString(), 30+(y*50), 30+(v*50));
    } else {
      fill(color(0, 150, 200));
      text(nodes.get(i).stateString(), 30, 30+(v*50));
    }
  }
  int total = goalIndex+1;
  fill(0);
  text("Visited Nodes: "+total, width - 120, height - 20);
}
