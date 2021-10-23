class State {
  private int missionaries;
  private int cannibals;
  private String side;
  private State parent;
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

  public State[] nextStates() {
    State[] nextStates = new State[5];
    int i = 0;
    int m = getMissionaries();
    int c = getCannibals();
    String s = getSide();
    if (s == "L") {
      if (m >=2) {
        nextStates[i] = new State(m-2, c, toggleSide(),this);
        println("Action: 2 missionaries from left to right");
        nextStates[i].printState();
        i++;
      }
      if (m >=1) {
        nextStates[i] = new State(m-1, c, toggleSide(),this);
        println("Action: 1 missionary from left to right");
        nextStates[i].printState();
        i++;
      }
      if (m >=1 && c>=1) {
        nextStates[i] = new State(m-1, c-1, toggleSide(),this);
        println("Action: 1 missionary and 1 cannibal from left to right");

        nextStates[i].printState();
        i++;
      }
      if (c>=2) {
        nextStates[i] = new State(m, c-2, toggleSide(),this);
        println("Action: 2 cannibals from left to right");

        nextStates[i].printState();
        i++;
      }
      if (c>=1) {
        nextStates[i] = new State(m, c-1, toggleSide(),this);
        println("Action: 1 cannibal from left to right");

        nextStates[i].printState();
        i++;
      }
    } else {
      if (3-m >=2) {
        nextStates[i] = new State(m+2, c, toggleSide(),this);
        println("Action: 2 missionaries from right to left");
        nextStates[i].printState();
        i++;
      }
      if (3-m >=1) {
        nextStates[i] = new State(m+1, c, toggleSide(),this);
        println("Action: 1 missionary from right to left");

        nextStates[i].printState();
        i++;
      }
      if (3-m >=1 && 3-c>=1) {
        nextStates[i] = new State(m+1, c+1, toggleSide(),this);
        println("Action: 1 missionary and 1 cannibal from right to left");

        nextStates[i].printState();
        i++;
      }
      if (3-c>=2) {
        nextStates[i] = new State(m, c+2, toggleSide(),this);
        println("Action: 2 cannibals from right to left");

        nextStates[i].printState();
        i++;
      }
      if (3-c>=1) {
        nextStates[i] = new State(m, c+1, toggleSide(),this);
        println("Action: 1 cannibal from right to left");

        nextStates[i].printState();
        i++;
      }
    }
    State[] nextState = new State[i];
    for (int j =0; j < i; j++) {
      nextState[j] = nextStates[j];
    }
    return nextState;
  }
    private String stateString() {
    return "("+getMissionaries()+", "+getCannibals()+", "+getSide()+")";
  }
  private void printState() {
    println("("+getMissionaries()+", "+getCannibals()+", "+getSide()+")");
  }
  public boolean isEqual(State state) {
    return this.getMissionaries() == state.getMissionaries() && this.getCannibals() == state.getCannibals() && this.getSide() == state.getSide();
  }
}
