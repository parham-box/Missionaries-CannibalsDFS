class State {
  //number of missionaries on the left side
  private int missionaries;
  //number of cannibals on the left side
  private int cannibals;
  //R or L indicating if the boat is on the Right side or the Left side
  private String side;
  //parent of this node
  private State parent;
  //constructor
  State(int missionaries, int cannibals, String side) {
    this.missionaries = missionaries;
    this.cannibals = cannibals;
    if (side == "L" || side == "R") {
      this.side = side;
    } else {
      println("Please enter L or R to declare which side is the boat");
    }
    parent = null;
  }
  //overloading
  State(int missionaries, int cannibals, String side, State parent) {
    this.missionaries = missionaries;
    this.cannibals = cannibals;
    if (side == "L" || side == "R") {
      this.side = side;
    } else {
      println("Please enter L or R to declare which side is the boat");
    }
    this.parent = parent;
  }
  //getters
  public int getMissionaries() {
    return this.missionaries;
  }
  public int getCannibals() {
    return this.cannibals;
  }
  public String getSide() {
    return this.side;
  }
  public State getParent() {
    return this.parent;
  }
  //setters
  public void setMissionaries(int missionaries) {
    this.missionaries = missionaries;
  }
  public void setCannibals(int cannibals) {
    this.cannibals = cannibals;
  }
  public void setSide(String side) {
    this.side = side;
  }
  public void setParent(State parent) {
    this.parent = parent;
  }
  //toggle where boat each with for the next state
  public String toggleSide() {
    String s = getSide();
    if (s == "R") {
      return "L";
    }
    if (s == "L") {
      return "R";
    }
    return "";
  }
  //constraints of the problem. Cannibals can not outnumber missionaries on either sides
  public boolean isValid() {
    int m = getMissionaries();
    int c = getCannibals();
    String s = getSide();
    //check the range
    if (m > 3 || m < 0 || c > 3 || c < 0) {
      return false;
    }
    if (!(s == "R" || s=="L")) {
      return false;
    }
    //check left side for constraints
    if (m < c && m > 0) {
      return false;
    }
    //check right side for constraints
    if (m > c && m < 3) {
      return false;
    }
    return true;
  }
  //this function goes through all possible actions that can be taken for this state and create the subsequent state
  public State[] nextStates() {
    State[] nextStates = new State[5];
    int i = 0;
    int m = getMissionaries();
    int c = getCannibals();
    String s = getSide();
    //if boat is on left side
    if (s == "L") {
      //if more than or equal of 2 missionaries on left side, move 2 of missionaries from left to right side
      if (m >=2) {
        nextStates[i] = new State(m-2, c, toggleSide(), this);
        println("Action: 2 missionaries from left to right");
        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 1 missionaries on left side, move 1 missonary from left to right side
      if (m >=1) {
        nextStates[i] = new State(m-1, c, toggleSide(), this);
        println("Action: 1 missionary from left to right");
        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 1 missionaries and 1 cannibals on left side, move 1 missonary and 1 cannibal from left to right side
      if (m >=1 && c>=1) {
        nextStates[i] = new State(m-1, c-1, toggleSide(), this);
        println("Action: 1 missionary and 1 cannibal from left to right");

        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 2 cannibals on left side, move 2 cannibals from left to right side
      if (c>=2) {
        nextStates[i] = new State(m, c-2, toggleSide(), this);
        println("Action: 2 cannibals from left to right");
        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 1 cannibals on left side, move 1 cannibal from left to right side
      if (c>=1) {
        nextStates[i] = new State(m, c-1, toggleSide(), this);
        println("Action: 1 cannibal from left to right");
        nextStates[i].printState();
        i++;
      }
    } else {
      //if boat is on right side
      //if more than or equal of 2 missionaries on right side, move 2 of missionaries from right to left side
      if (3-m >=2) {
        nextStates[i] = new State(m+2, c, toggleSide(), this);
        println("Action: 2 missionaries from right to left");
        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 1 missionaries on right side, move 1 missonary from right to left side
      if (3-m >=1) {
        nextStates[i] = new State(m+1, c, toggleSide(), this);
        println("Action: 1 missionary from right to left");

        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 1 missionaries and 1 cannibals on right side, move 1 missonary and 1 cannibal from right to left side
      if (3-m >=1 && 3-c>=1) {
        nextStates[i] = new State(m+1, c+1, toggleSide(), this);
        println("Action: 1 missionary and 1 cannibal from right to left");

        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 2 cannibals on right side, move 2 cannibals from right to left side
      if (3-c>=2) {
        nextStates[i] = new State(m, c+2, toggleSide(), this);
        println("Action: 2 cannibals from right to left");

        nextStates[i].printState();
        i++;
      }
      //if more than or equal of 1 cannibals on right side, move 1 cannibal from right to left side
      if (3-c>=1) {
        nextStates[i] = new State(m, c+1, toggleSide(), this);
        println("Action: 1 cannibal from right to left");

        nextStates[i].printState();
        i++;
      }
    }
    State[] nextState = new State[i];
    //resize the array
    for (int j =0; j < i; j++) {
      nextState[j] = nextStates[j];
    }
    //return all possible states
    return nextState;
  }
  //return state
  private String stateString() {
    return "("+getMissionaries()+", "+getCannibals()+", "+getSide()+")";
  }
  //print state
  private void printState() {
    println(this.stateString());
  }
  public boolean isEqual(State state) {
    return this.getMissionaries() == state.getMissionaries() && this.getCannibals() == state.getCannibals() && this.getSide() == state.getSide();
  }
}
