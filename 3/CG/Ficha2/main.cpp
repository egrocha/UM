#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <math.h>

int xx = 0;
int yy = 0;
int zz = 0;
int angles = 0;
float zscale = 1;

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


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(5.0,3.0,5.0,
		      0.0,0.0,0.0,
			  0.0f,0.0f,1.0f);

// put the geometric transformations here
    glTranslatef(xx,yy,zz);
    glRotatef(angles,0,0,1);
    glScalef(1,1,zscale);

// put drawing instructions here

//Base
	glBegin(GL_TRIANGLES);
		glVertex3f(1,1,0);
		glVertex3f(-1,1,0);
		glVertex3f(-1,-1,0);
	glEnd();

	glBegin(GL_TRIANGLES);
		glVertex3f(1,1,0);
		glVertex3f(1,-1,0);
		glVertex3f(-1,-1,0);
	glEnd();

//Faces
    glBegin(GL_TRIANGLES);
        glVertex3f(1,1,0);
        glVertex3f(0,0,3);
        glVertex3f(-1,1,0);
    glEnd();

    glBegin(GL_TRIANGLES);
        glVertex3f(-1,-1,0);
        glVertex3f(0,0,3);
        glVertex3f(-1,1,0);
    glEnd();

    glBegin(GL_TRIANGLES);
        glVertex3f(-1,-1,0);
        glVertex3f(0,0,3);
        glVertex3f(1,-1,0);
    glEnd();

    glBegin(GL_TRIANGLES);
        glVertex3f(1,1,0);
        glVertex3f(0,0,3);
        glVertex3f(1,-1,0);
    glEnd();

	// End of frame
	glutSwapBuffers();
}



// write function to process keyboard events

void processKeys(unsigned char key, int x, int y){

    if(key == 'd') yy++;
    if(key == 's') xx++;
    if(key == 'w') xx--;
    if(key == 'a') yy--;

    if(key == 'l') angles -= 10;
    if(key == 'j') angles += 10;

    if(key == 'i') zscale += 0.1;
    if(key == 'k') zscale -= 0.1;

    glutPostRedisplay();

}




int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	
// put here the registration of the keyboard callbacks
    glutKeyboardFunc(processKeys);


//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	//glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
