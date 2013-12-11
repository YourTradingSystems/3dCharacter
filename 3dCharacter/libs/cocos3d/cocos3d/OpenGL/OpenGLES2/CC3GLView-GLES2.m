/*
 * CC3GLView-GLES2.m
 *
 * cocos3d 2.0.0
 * Author: Bill Hollings
 * Copyright (c) 2010-2013 The Brenwill Workshop Ltd. All rights reserved.
 * http://www.brenwill.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * http://en.wikipedia.org/wiki/MIT_License
 * 
 * See header file CC3GLView-GLES2.h for full API documentation.
 */

#import "CC3GLView-GLES2.h"

#if CC3_OGLES_2

#import "CC3OSExtensions.h"
#import "CC3Logging.h"

#if COCOS2D_VERSION < 0x020100
#	define CC2_REQUESTED_SAMPLES requestedSamples_
#	define CC2_PIXEL_FORMAT pixelformat_
#	define CC2_DEPTH_FORMAT depthFormat_
#	define CC2_CONTEXT context_
#	define CC2_SIZE size_
#	define CC2_PRESERVE_BACKBUFFER preserveBackbuffer_
#else
#	define CC2_REQUESTED_SAMPLES _requestedSamples
#	define CC2_PIXEL_FORMAT _pixelformat
#	define CC2_DEPTH_FORMAT _depthFormat
#	define CC2_CONTEXT _context
#	define CC2_SIZE _size
#	define CC2_PRESERVE_BACKBUFFER _preserveBackbuffer
#endif


#pragma mark -
#pragma mark CCGLView

@interface CCGLView (TemplateMethods)
-(unsigned int) convertPixelFormat:(NSString*) pixelFormat;
@end

@implementation CC3GLView

@synthesize surfaceManager=_surfaceManager;

-(void) dealloc {
	[_surfaceManager release];
	[super dealloc];
}

-(CAEAGLLayer*) layer { return (CAEAGLLayer*)super.layer; }

-(GLenum) colorFormat { return [self convertPixelFormat: CC2_PIXEL_FORMAT]; }

-(GLenum) depthFormat { return super.depthFormat; }

-(GLuint) requestedSamples { return CC2_REQUESTED_SAMPLES; }

-(GLuint) pixelSamples { return _surfaceManager.pixelSamples; }

-(BOOL) setupSurfaceWithSharegroup:(EAGLSharegroup*)sharegroup {
	self.layer.opaque = YES;
	self.layer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
									 [NSNumber numberWithBool: CC2_PRESERVE_BACKBUFFER],
									 kEAGLDrawablePropertyRetainedBacking,
									 CC2_PIXEL_FORMAT,
									 kEAGLDrawablePropertyColorFormat,
									 nil];

	CC2_CONTEXT = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2 sharegroup: sharegroup];
	if ( !CC2_CONTEXT || ![EAGLContext setCurrentContext: CC2_CONTEXT] ) {
		CC3Assert(NO, @"Could not create EAGLContext. OpenGL ES 2.0 is required.");
		[self release];
		return NO;
	}
	
	_surfaceManager = [[CC3GLViewSurfaceManager alloc] initWithView: self];
	return YES;
}

-(void) layoutSubviews {
	CC3IntSize size;
	CC3OpenGL* gl = CC3OpenGL.sharedGL;
	
	// Bind the renderbuffer that is the color attachment of the view and resize it from the layer
	[gl bindRenderbuffer: _surfaceManager.viewColorBuffer.renderbufferID];
	if( ![CC2_CONTEXT renderbufferStorage: GL_RENDERBUFFER fromDrawable: self.layer] ) {
		LogError(@"Failed to allocate renderbuffer storage in GL context.");
		return;
	}

	// Retrieve the new size of the renderbuffer from the GL engine
	// and resize all surfaces in the surface manager to that new size.
	size.width = [gl getRenderbufferParameterInteger: GL_RENDERBUFFER_WIDTH];
	size.height = [gl getRenderbufferParameterInteger: GL_RENDERBUFFER_HEIGHT];
	LogTrace(@"View resizing to %@", NSStringFromCC3IntSize(size));

	[_surfaceManager resizeTo: size];

	// Update the CCDirector with the new view size
	CC2_SIZE = CGSizeFromCC3IntSize(size);
	CCDirector *director = [CCDirector sharedDirector];
	[director reshapeProjection: CC2_SIZE];		// Issue #914 #924
	[director drawScene];						// avoid flicker
	
}

-(void) swapBuffers {
	[_surfaceManager resolveMultisampling];
	if( ![CC2_CONTEXT presentRenderbuffer: GL_RENDERBUFFER] )
		LogError(@"Failed to swap renderbuffer to screen.");
	
}

@end

#endif	// CC3_OGLES_2
