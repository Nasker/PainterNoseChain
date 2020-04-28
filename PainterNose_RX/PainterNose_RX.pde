NosePointsList nosePoints;
OSCCommunication oscComm;

String destIP = "localhost";
int portIn = 4321;
int portOut = 1234;


void setup() {
  size(640, 480);
  oscComm = new OSCCommunication(this, destIP, portIn, portOut);
  nosePoints = new NosePointsList();
}

void draw() {
  background(0);
  nosePoints.display();
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/painterNose/pos")) {
    int posX = theOscMessage.get(0).intValue()*2;
    int posY = theOscMessage.get(1).intValue()*2;
    int size = theOscMessage.get(2).intValue()*2;
    NosePoint nosePoint = new NosePoint(posX, posY, size);
    nosePoints.addNosePoint(nosePoint);
  }
  if (theOscMessage.checkAddrPattern("/painterNose/clear")) {
    nosePoints.clear();
  }
}

void keyPressed() {
  if (key == 'c') {
    nosePoints.clear();
  }
}
