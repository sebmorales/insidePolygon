////////
//  Check if a point is inside a random poligon
//  
//  Sebastia Morales
///////

PVector[] points=new PVector[0];

void setup() {
  size(600, 400);
  println("Click to add points");
  background(0);
  noStroke();
}

void draw() {
  background(0);
  beginShape();

  if (isInside()) {
    fill(10, 240, 10);
  } else {
    fill(200, 49, 20);
  }
  for (int i=0; i<points.length; i++) {
    vertex(points[i].x, points[i].y);
    ellipse(points[i].x, points[i].y, 8, 8);
  }
  endShape(CLOSE);
}

void mouseClicked() {
  PVector newPoint=new PVector(mouseX, mouseY);
  points=(PVector[]) append(points, newPoint);
}

boolean isInside() {
  float angle=0;
  if (points.length>2) {//ignore if there are less than 3 points
    PVector mousePos=new PVector(mouseX, mouseY);
    for (int i=0; i<points.length; i++) {
      if (i<points.length-1) {
        angle+=angleBetween3Points(points[i], mousePos, points[i+1]);
      } else {
        angle+=angleBetween3Points(points[i], mousePos, points[0]);
      }
    }
  }
  //Note that if the poligon self intersects the angle will be greater
  //to 2Pi or less than -2Pi
  if (angle>TWO_PI-.05 || angle<-TWO_PI+.05) {
    return (true);
  } else {
    return(false);
  }
}

float angleBetween3Points(PVector P1, PVector center, PVector P2) {
  float angle=0;
  PVector p1=PVector.sub(P1, center);
  PVector p2=PVector.sub(P2, center);
  float angleP1Xaxis=p1.heading();
  p1.rotate(-angleP1Xaxis);
  p2.rotate(-angleP1Xaxis);
  angle=p2.heading();
  p1.rotate(angleP1Xaxis);
  p2.rotate(angleP1Xaxis);
  return(angle);
}