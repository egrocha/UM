#include <stdio.h>

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>
#include <iostream>

float alfa = 0.0f, beta = 0.5f, radius = 100.0f;
float camX, camY, camZ;

int treesX[100];
int treesZ[100];
double teta = 0;

void spherical2Cartesian() {

	camX = radius * cos(beta) * sin(alfa);
	camY = radius * sin(beta);
	camZ = radius * cos(beta) * cos(alfa);
}


void changeSize(int w, int h) {

	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
		h = 1;

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

void daRandX(int* y){
    int i = 0;
    while(i == 0) {
        int x = rand();
        int z = rand();
        x = x % 100;
        z = z % 100;

        if ( !(x >= 25 && x <= 75 && z >= 25 && z <= 75)) {
            y[0] = x;
            y[1] = z;
            i = 1;
        }
    }
}

void saveTrees() {
    int trees = 0;

    while(trees < 100){
        int x[2];
        daRandX(x);
        treesX[trees] = x[0];
        treesZ[trees] = x[1];
        trees++;
    }

}
void drawTrees(){
    int i = 0;
    while(i < 100) {
        glPushMatrix();
        glTranslatef(treesX[i], 0, treesZ[i]);
        glRotatef(-90,1,0,0);
        glColor3f(1,0,1);
        glutSolidCone(0.5, 5, 60, 15);
        glTranslatef(0, 0, 2);
        glColor3f(0,0,1);
        glutSolidCone(2, 5, 60, 15);
        glPopMatrix();
        i++;
    }
}

void drawMiddle() {

    glPushMatrix();
    glTranslatef(50,0,50);
    glutSolidTorus(2, 3, 100, 100);
    glPopMatrix();

    glTranslatef(50,1,50);

    double alpha = teta;

    for(int i = 0; i < 10; i++){
        glPushMatrix();
        glTranslatef(15*sin(alpha),1,15*cos(alpha));
        glColor3f(0.2,0.2,0.2);
        glutSolidTeapot(1);
        glPopMatrix();
        alpha += 2*M_PI/10;
    }

}

void idle(){
    teta += 0.01;
    glutPostRedisplay();
}

void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(camX, camY, camZ,
		50.0, 0, 50.0,
		0.0f, 1.0f, 0.0f);

	glColor3f(0.2f, 0.8f, 0.2f);
	glBegin(GL_TRIANGLES);
		glVertex3f(100, 0, 0);
		glVertex3f(0, 0, 0);
		glVertex3f(0, 0, 100);

		glVertex3f(100, 0, 0);
		glVertex3f(0, 0, 100);
		glVertex3f(100, 0, 100);
	glEnd();

    drawTrees();
    glColor3f(1,0,0);
    drawMiddle();
	// End of frame
	glutSwapBuffers();
}


void processKeys(unsigned char c, int xx, int yy) {

// put code to process regular keys in here

}


void processSpecialKeys(int key, int xx, int yy) {

	switch (key) {

	case GLUT_KEY_RIGHT:
		alfa -= 0.1; break;

	case GLUT_KEY_LEFT:
		alfa += 0.1; break;

	case GLUT_KEY_UP:
		beta += 0.1f;
		if (beta > 1.5f)
			beta = 1.5f;
		break;

	case GLUT_KEY_DOWN:
		beta -= 0.1f;
		if (beta < -1.5f)
			beta = -1.5f;
		break;

	case GLUT_KEY_PAGE_DOWN: radius -= 1.0f;
		if (radius < 1.0f)
			radius = 1.0f;
		break;

	case GLUT_KEY_PAGE_UP: radius += 1.0f; break;
	}
	spherical2Cartesian();
	glutPostRedisplay();

}


void printInfo() {

	printf("Vendor: %s\n", glGetString(GL_VENDOR));
	printf("Renderer: %s\n", glGetString(GL_RENDERER));
	printf("Version: %s\n", glGetString(GL_VERSION));

	printf("\nUse Arrows to move the camera up/down and left/right\n");
	printf("Home and End control the distance from the camera to the origin");
}


int main(int argc, char **argv) {

    saveTrees();

    for(int i = 0; i < 100; i++){
        std::cout << treesX[i] << " " << treesZ[i] << "\n";
    }


// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(1920,1080);
	glutCreateWindow("CG@DI-UM");
		
// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	
// Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	glutSpecialFunc(processSpecialKeys);
    glutIdleFunc(idle);

//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
    //glEnable(GL_LIGHTING);
    //glEnable(GL_LIGHT0);
    //glEnable(GL_COLOR_MATERIAL);
    //glColorMaterial(GL_FRONT,GL_AMBIENT_AND_DIFFUSE);
	spherical2Cartesian();

	printInfo();

// enter GLUT's main cycle
	glutMainLoop();

	return 1;
}
