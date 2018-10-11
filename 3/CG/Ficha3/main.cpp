#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glew.h>
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>
#include <iostream>

using namespace std;

float angle = 0;
float translate = 0;
float alph = 1;
float beta = 1;
float r = 5;

void changeSize(int w, int h)
{
	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if (h == 0) h = 1;

	// compute window's aspect ratio 
	float ratio = w * 1.0 / h;

	// Set the projection matrix as current
	glMatrixMode(GL_PROJECTION);
	// Load Identity Matrix
	glLoadIdentity();
	
	// Set the viewport to be the entire window
    glViewport(0, 0, w, h);

	// Set perspective
	gluPerspective(45.0f ,ratio, 1.0f ,1000.0f);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}


void drawOcta(double length, double width, double height) {
    glBegin(GL_LINES);
    glColor3f(0,0,1);

    //main square
    glVertex3d(length, 0, width);
    glVertex3d(length, 0, -width);
    glVertex3d(-length, 0, width);

    glVertex3d(-length, 0, -width);
    glVertex3d(-length, 0, width);
    glVertex3d(length, 0, -width);

    //links to top
    //front
    glVertex3d(length, 0, width);
    glVertex3d(0, height, 0);
    glVertex3d(-length, 0, width);
    //right
    glVertex3d(length, 0, -width);
    glVertex3d(0, height, 0);
    glVertex3d(length, 0, width);
    //back
    glVertex3d(-length, 0, -width);
    glVertex3d(0, height, 0);
    glVertex3d(length, 0, -width);
    //left
    glVertex3d(-length, 0, -width);
    glVertex3d(0, height, 0);
    glVertex3d(-length, 0, width);

    //links to bottom
    //front
    glVertex3d(length, 0, width);
    glVertex3d(0, -height, 0);
    glVertex3d(-length, 0, width);
    //right
    glVertex3d(length, 0, -width);
    glVertex3d(0, -height, 0);
    glVertex3d(length, 0, width);
    //back
    glVertex3d(-length, 0, -width);
    glVertex3d(0, -height, 0);
    glVertex3d(length, 0, -width);
    //left
    glVertex3d(-length, 0, -width);
    glVertex3d(0, -height, 0);
    glVertex3d(-length, 0, width);

    glEnd();
}


void drawBox(double length, double width, double height, int divisions) {

    glBegin(GL_TRIANGLES);
    glColor3f(0, 0, 1);

    //base of the box
    glVertex3d(length, 0, width);
    glVertex3d(length, 0, -width);
    glVertex3d(-length, 0, width);
    glVertex3d(length, 0, -width);
    glVertex3d(-length, 0, -width);
    glVertex3d(-length, 0, width);

    //top of the box
    glVertex3d(length, height, width);
    glVertex3d(length, height, -width);
    glVertex3d(-length, height, width);
    glVertex3d(length, height, -width);
    glVertex3d(length, height, -width);
    glVertex3d(-length, height, width);

    //front face
    glVertex3d(length, 0, width);
    glVertex3d(length, height, width);
    glVertex3d(-length, 0, width);
    glVertex3d(length, height, width);
    glVertex3d(-length, height, width);
    glVertex3d(-length, 0, width);

    //back face
    glVertex3d(length, 0, -width);
    glVertex3d(length, height, -width);
    glVertex3d(-length, 0, -width);
    glVertex3d(length, height, -width);
    glVertex3d(-length, height, -width);
    glVertex3d(-length, 0, -width);

    //right face
    glVertex3d(length, 0, width);
    glVertex3d(length, 0, -width);
    glVertex3d(length, height, -width);
    glVertex3d(length, height, -width);
    glVertex3d(length, height, width);
    glVertex3d(length, 0, width);

    //left face
    glVertex3d(-length, 0, width);
    glVertex3d(-length, 0, -width);
    glVertex3d(-length, height, -width);
    glVertex3d(-length, height, -width);
    glVertex3d(-length, height, width);
    glVertex3d(-length, 0, width);

    glEnd();
}

void drawCylinder(float radius, float height, int slices)
{
    double alpha = 0;
    double delta = (2*M_PI) / slices;

    for (int i = 0; i < slices; i++) {
        glBegin(GL_TRIANGLES);
            glColor3f(0, 0, 1);
            glVertex3d(0, height, 0);
            glVertex3d(radius * sin(alpha), height, radius * cos(alpha));
            glVertex3d(radius * sin(alpha + delta), height, radius * cos(alpha + delta));

            glColor3f(1, 0, 0);
            glVertex3d(radius * sin(alpha + delta), height, radius * cos(alpha + delta));
            glVertex3d(radius * sin(alpha), height, radius * cos(alpha));
            glVertex3d(radius * sin(alpha), 0, radius * cos(alpha));

            glVertex3d(0, 0, 0);
            glVertex3d(radius * sin(alpha), 0, radius * cos(alpha));
            glVertex3d(radius * sin(alpha + delta), 0, radius * cos(alpha + delta));

            glVertex3d(radius * sin(alpha + delta), height, radius * cos(alpha + delta));
            glVertex3d(radius * sin(alpha), 0, radius * cos(alpha));
            glVertex3d(radius * sin(alpha + delta), 0, radius * cos(alpha + delta));

            alpha += delta;
        glEnd();
    }
}

void drawSphere(float radius, float height, int slices, int stacks){
    int i, j;
    double x, y, z;
    for(i = 0; i < stacks; i++){
        for(j = 0; j < slices; j++){
            glBegin(GL_TRIANGLES);
            glColor3f(0, 0, 1);
            y = -cos(M_PI * j / stacks);
            x = radius * sin(2.0 * M_PI * j / slices);
            z = radius * cos(2.0 * M_PI * j / slices);
            glVertex3d(0, y, 0);
            glVertex3d(x,y,z);
            glVertex3d(x,y,z);
            glEnd();
        }
    }
}
/*
for (stack = 0; stack < STACKS; ++stack) {
for (slice = 0; slice < SLICES; ++slice) {
y = 2.0 * stack / STACKS - 1.0;
/* for better distribution, use y = -cos(PI * stack / STACKS) */
/*r = sqrt(1 - y^2);
x = r * sin(2.0 * PI * slice / SLICES);
z = r * cos(2.0 * PI * slice / SLICES);

vertex = radius * (x, y, z);
}
}*/

void drawCone(double radius, float height, int slices, int stacks){
    double alpha = 0;
    double delta = (2*M_PI) / slices;
    double currHeight = 0, heightInc = height/stacks, radiusDec = radius/stacks;
    double currentX1, currentZ1, currentX2, currentZ2, color;
    double lastX1 = 0, lastZ1 = 0, lastX2 = 0, lastZ2 = 0, lastHeight = 0, lastRadius = 0;

    glBegin(GL_TRIANGLES);
    for(int i = 0; i <= stacks; i++) {
        for (int j = 0; j < slices; j++) {
            glColor3f(color, 0, 0);
            currentX1 = radius * sin(alpha);
            currentZ1 = radius * cos(alpha);
            currentX2 = radius * sin(alpha+delta);
            currentZ2 = radius * cos(alpha+delta);
            lastX1 = lastRadius * sin(alpha);
            lastZ1 = lastRadius * cos(alpha);
            lastX2 = lastRadius * sin(alpha+delta);
            lastZ2 = lastRadius * cos(alpha+delta);

            //draws a slice of the current stack of the cone
            glVertex3d(0, currHeight, 0);
            glVertex3d(currentX1, currHeight, currentZ1);
            glVertex3d(currentX2, currHeight, currentZ2);
            if(i != 0){
                //draws triangles that link current stack to previous stack
                //left triangle
                glVertex3d(currentX1, currHeight, currentZ1);
                glVertex3d(lastX1, lastHeight, lastZ1);
                glVertex3d(currentX2, currHeight, currentZ2);

                //right triangle
                glVertex3d(currentX2, currHeight, currentZ2);
                glVertex3d(lastX1, lastHeight, lastZ1);
                glVertex3d(lastX2, lastHeight, lastZ2);

                //left bottom triangle
                glVertex3d(currentX1, -currHeight, currentZ1);
                glVertex3d(lastX1, -lastHeight, lastZ1);
                glVertex3d(currentX2, -currHeight, currentZ2);

                //right bottom triangle
                glVertex3d(currentX2, -currHeight, currentZ2);
                glVertex3d(lastX1, -lastHeight, lastZ1);
                glVertex3d(lastX2, -lastHeight, lastZ2);
            }
            alpha += delta;
        }
        color += 0.1;
        lastHeight = currHeight;
        currHeight += heightInc;
        lastRadius = radius;
        std::cout << radius << " " << lastRadius << " " << " " << currHeight << " " << lastHeight;
        //radius = lastRadius*(height-currHeight)/(height-lastHeight);
        radius -= radiusDec;

    }
    glEnd();
}


void drawSphere(double radius, int slices, int stacks) {
    int flag = 0, stacksNew = 0;
    double baseRadius = radius;
    double alpha = 0;
    double delta = (2 * M_PI) / slices;
    double currHeight = 0, heightInc = radius / stacks*2, radiusDec = radius / stacks;
    double currentX1, currentZ1, currentX2, currentZ2, color = 0;
    double lastX1 = 0, lastZ1 = 0, lastX2 = 0, lastZ2 = 0, lastHeight = 0, lastRadius = 0;

    glBegin(GL_TRIANGLES);
    if(stacks % 2 != 0){
        stacksNew = stacks / 2;
        stacksNew++;
    }
    else stacksNew = stacks / 2;
    for(int i = 0; i <= stacksNew; i++) {
        glColor3f(1-color/2, 0, 0);
        for (int j = 0; j < slices; j++){
            if(stacks % 2 != 0 && i == 0 && j == 0) {
                lastHeight = currHeight;
                currHeight += heightInc/2;
                radius -= radiusDec/2;
                lastRadius = radius;
            }
            currentX1 = radius * sin(alpha);
            currentZ1 = radius * cos(alpha);
            currentX2 = radius * sin(alpha + delta);
            currentZ2 = radius * cos(alpha + delta);
            lastX1 = lastRadius * sin(alpha);
            lastZ1 = lastRadius * cos(alpha);
            lastX2 = lastRadius * sin(alpha+delta);
            lastZ2 = lastRadius * cos(alpha+delta);

            if(i == 0 && stacks % 2 == 0 && flag == 0){
                //draws a slice of center circle of the sphere
                glVertex3d(0, 0, 0);
                glVertex3d(currentX1, 0, currentZ1);
                glVertex3d(currentX2, 0, currentZ2);
            }
            if((stacks % 2 != 0) || (i > 0)){
                //draws upper circle
                glVertex3d(0, currHeight, 0);
                glVertex3d(currentX1, currHeight, currentZ1);
                glVertex3d(currentX2, currHeight, currentZ2);

                //draws lower circle
                glVertex3d(0, -currHeight, 0);
                glVertex3d(currentX1, -currHeight, currentZ1);
                glVertex3d(currentX2, -currHeight, currentZ2);
            }
            if(i != 0){
                //draws triangles that link current stack to previous stack
                //left top triangle
                glVertex3d(currentX1, currHeight, currentZ1);
                glVertex3d(lastX1, lastHeight, lastZ1);
                glVertex3d(currentX2, currHeight, currentZ2);

                //right top triangle
                glVertex3d(currentX2, currHeight, currentZ2);
                glVertex3d(lastX1, lastHeight, lastZ1);
                glVertex3d(lastX2, lastHeight, lastZ2);

                //left bottom triangle
                glVertex3d(currentX1, -currHeight, currentZ1);
                glVertex3d(lastX1, -lastHeight, lastZ1);
                glVertex3d(currentX2, -currHeight, currentZ2);

                //right top triangle
                glVertex3d(currentX2, -currHeight, currentZ2);
                glVertex3d(lastX1, -lastHeight, lastZ1);
                glVertex3d(lastX2, -lastHeight, lastZ2);
            }

            alpha += delta;
        }
        color += 0.0005;
        std::cout << radius << "\n" << baseRadius << "\n" << currHeight << "\n";
        if(flag || stacks % 2 == 0) {
            color += 0.1;
            lastHeight = currHeight;
            currHeight += heightInc;
            lastRadius = radius;
            radius = sqrt((baseRadius-currHeight)*(2*radius-(baseRadius-currHeight)));
            //radius = sqrt(currHeight*(2*radius-));
            //radius -= radiusDec;
        }
        if(flag == 0) flag = 1;
        //std::cout << radius << " " << lastRadius << " " << " " << currHeight << " " << lastHeight;
        //radius = lastRadius*(height-currHeight)/(height-lastHeight);
    }

    glEnd();
}


void drawSphere2(double radius, int slices, int stacks) {
    int i, j;
    double lng = 0, prevLng = 0;
    int color = 1;
    for(i = 0; i <= stacks; i++) {
        double lat0 = M_PI * (-radius + (double) (i - 1) / stacks);
        double z0  = sin(lat0);
        double zr0 =  cos(lat0);

        double lat1 = M_PI * (-radius + (double) i / stacks);
        double z1 = sin(lat1);
        double zr1 = cos(lat1);
/*
        glBegin(GL_QUAD_STRIP);
        glColor3f(0,color,0);
        for(j = 0; j <= slices; j++) {
            double lng = 2 * M_PI * (double) (j - 1) / slices;
            double x = cos(lng);
            double y = sin(lng);
            glNormal3f(x * zr0, y * zr0, z0);
            glVertex3f(x * zr0, y * zr0, z0);
            glNormal3f(x * zr1, y * zr1, z1);
            glVertex3f(x * zr1, y * zr1, z1);
        }
        glEnd();
*/
        glBegin(GL_TRIANGLES);
        glColor3f(0,color,0);
        for(j = 0; j <= slices; j++) {
            double lng = 2 * M_PI * (double) (j - 1) / slices;
            double x = cos(lng);
            double y = sin(lng);
            //glNormal3f(x * zr0, y * zr0, z0);
            glVertex3f(x * zr0, y * zr0, z0);
            //glNormal3f(x * zr1, y * zr1, z1);
            glVertex3f(x * zr1, y * zr1, z1);
        }
        glEnd();
    }
}


void drawSphere3(double radius, int slices, int stacks){
    int i, j;
    double lng = 0, prevLng = 0, delta1 = (2*M_PI) / slices, delta2 = M_PI / stacks;
    double phi1 = 0, phi2 = 0;
    int color = 1;
    for(i = 0; i <= stacks; i++) {
        phi2 = phi1;
        phi1 = delta1;
        double z0  = sin(phi1);
        double zr0 =  cos(phi1);

        double phi2 = M_PI * (-radius + (double) i / stacks);
        double z1 = sin(phi2);
        double zr1 = cos(phi2);

        glBegin(GL_TRIANGLES);
        glColor3f(0,color,0);
        for(j = 0; j <= slices; j++) {
            double lng = 2 * M_PI * (double) (j - 1) / slices;
            double x = cos(lng);
            double y = sin(lng);
            glVertex3f(0,0,0);
            //glNormal3f(x * zr0, y * zr0, z0);
            glVertex3f(x * zr0, y * zr0, z0);
            //glNormal3f(x * zr1, y * zr1, z1);
            glVertex3f(x * zr1, y * zr1, z1);
        }
        glEnd();
    }
}


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(r * cos(beta) * sin(alph), 0.5*r * sin(beta), r * cos(beta) * cos(alph),
		      0.0, 0.0, 0.0,
			  0.0f, 1.0f, 0.0f);
    r * cos(beta) * sin(alph);
    glRotatef(angle, 0, 1, 0); // Rodar sobre o eixo y.
    glTranslatef(0, translate, 0); // Sobe e desce a pirâmide.

	drawSphere(1,20,20);

	// End of frame
	glutSwapBuffers();
}


void processKeys(unsigned char c, int xx, int yy)
{

}


void processSpecialKeys(int key, int xx, int yy)
{
    switch (key) {
        case GLUT_KEY_RIGHT:
            alph += 100;
            glutPostRedisplay();
            break;
        case GLUT_KEY_LEFT:
            alph -= 100;
            glutPostRedisplay();
            break;
        case GLUT_KEY_UP:
            //beta += 100;
            r -= 0.1;
            glutPostRedisplay();
            break;
        case GLUT_KEY_DOWN:
            //beta -= 100;
            r += 0.1;
            glutPostRedisplay();
            break;
        default:
            cout << "Não conheço esse comando!" << "\n";
    }
}


int main(int argc, char **argv)
{
    // init GLEW
    //glewInit();

	// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
    // Required callback registry
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	
    // Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	glutSpecialFunc(processSpecialKeys);

    //  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);

    glPolygonMode(GL_FRONT, GL_LINE);

    // enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
