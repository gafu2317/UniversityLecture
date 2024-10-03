void setup() {
System.setProperty("jogl.disable.openglcore", "false");
size(400, 400, P3D);
}
void draw() {
noStroke();
pushMatrix();
background(0);
ambientLight(20, 20, 20);
lightSpecular(255, 255, 255);
directionalLight(100, 100, 100, 0, 1, -1);
translate(100, 200, 0);
specular(200, 200, 200);
shininess(5.0);
sphere(50);
popMatrix();
pushMatrix();
translate(300, 200, 0);
specular(200, 200, 200);
shininess(100.0);
sphere(50);
popMatrix();
}