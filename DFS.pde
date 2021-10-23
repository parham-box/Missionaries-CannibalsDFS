import java.io.*;
import java.util.*;

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
  while (true) {
    //to check if node is already visited
    boolean flag = false;
    State cur = nodes.get(lastVisited);

    for (int i = 0; i < lastVisited; i++) {
      if (cur.isEqual(nodes.get(i))) {
        flag = true;
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
          nodes.add(nextStates[i]);
        }
      } else {
        println("Visited Before");
      }
    } else {
      println("Not a valid state");
    }

    lastVisited++;
    println("--------");
  }
}
