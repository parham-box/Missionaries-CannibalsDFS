int lastVisited = 0;
ArrayList<State> nodes = new ArrayList<State>();
int goalIndex = 0;
State initalState = new State(3, 3, "L");
State goalState = new State(0, 0, "R");
ArrayList<Integer> status = new ArrayList<Integer>();

void setup() {
  size(350, 700); //size of the window
  background(255);
  frameRate(30);

  //add root
  nodes.add(initalState);
  //add status of root. 0 is normal nodes, 1 is goal node, -1 is not valid nodes, and 2 is already visited nodes
  status.add(0);
  int parent1 = 0;
  while (true) {
    //to check if node is already visited
    boolean flag = false;
    State cur = nodes.get(lastVisited);

    for (int i = 0; i < lastVisited; i++) {
      if (cur.isEqual(nodes.get(i))) {
        //parent1 = i;
        flag = true;
        break;
      }
    }

    println("--------");
    print("Current state: ");
    cur.printState();
    if (cur.isEqual(goalState)) {
      goalIndex = lastVisited;
      println("GOAL STATE");
      break;
    }
    //if valid
    if (cur.isValid()) {

      //if not visited
      if (!flag) {
        State[] nextStates = cur.nextStates();
        for (int i = 0; i < nextStates.length; i++) {
          //visit the node
          nodes.add(lastVisited+i+1,nextStates[i]);
        }
      } else {
        println("Visited Before");
      }
    } else {
      println("Not a valid state");
    }

    lastVisited++;
    //index++;
    println("--------");
  }

//Visualizing the graph on GUI

//Graph Legend:
//LIGHT BLUE: Root node
//RED: Not a valid node
//BLUE: Previously visited node
//BLACK: Node with children
//GRAY: A node on the answer path
//GREEN: Goal node

  int v = 1;
  int y = 0;
  int[] parentNodeNumber = new int[goalIndex+1];
  //root node
  parentNodeNumber[0] = -1;

  for (int x = 1; x <= goalIndex; x++) {
    boolean flag = false;
    State cur = nodes.get(x);

    for (int i = 0; i < x; i++) {
      if (cur.isEqual(nodes.get(i))) {
        flag = true;
      }
    }
    if (nodes.get(x).isValid()) {
      if (!flag) {

        status.add(0);
      } else {
        status.add(2);
      }
    } else {
      status.add(-1);
    }


    for (int k = 0; k < x; k++) {
      if (nodes.get(x).getParent().isEqual(nodes.get(k))) {
        parentNodeNumber[x] = k;
        break;
      }
    }
  }
  fill(0);
  ArrayList<Integer> rowIndex = new ArrayList<Integer>();
  for (int i = 0; i <= goalIndex; i++) {
    //nodes.get(i).printState();

    if (i!=0) {
      if (nodes.get(i).getSide() == nodes.get(i-1).getSide()) {
        y++;
      } else {
        v++;
        y =0;
        rowIndex.add(i);
      }
      int parentIndex = parentNodeNumber[i];
      int li = 0;
      for (int x = 1; x < rowIndex.size(); x++) {
        if (parentIndex < rowIndex.get(x)) {
          li = parentIndex - rowIndex.get(x -1);
          break;
        }
      }

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

      if (i == goalIndex) {
        stroke(color(0, 150, 0));
        fill(color(0, 150, 0));
      } else if (path.contains(i)) {
        fill(color(100, 100, 100));
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
  text("Visited Nodes: "+total,width - 120,height - 20);
}
