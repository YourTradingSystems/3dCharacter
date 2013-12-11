attribute vec4 a_cc3Position;
varying lowp vec4 v_color;
uniform highp mat4	u_cc3MatrixModelView;	
uniform highp mat4	u_cc3MatrixProj;


void main()
{
    v_color = vec4(0.4, 0.4, 0.0, 1.0);
    mat4 mvpMat = u_cc3MatrixModelView * u_cc3MatrixProj;
    gl_Position = mvpMat * a_cc3Position;
}
