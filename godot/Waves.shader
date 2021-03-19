// The MIT License
//
// Copyright (c) 2021 Kevin Kuriakose (Technohacker)
//
// Permission is hereby granted, free of charge, 
// to any person obtaining a copy of this software and 
// associated documentation files (the "Software"), to 
// deal in the Software without restriction, including 
// without limitation the rights to use, copy, modify, 
// merge, publish, distribute, sublicense, and/or sell 
// copies of the Software, and to permit persons to whom 
// the Software is furnished to do so, 
// subject to the following conditions:
//
// The above copyright notice and this permission notice 
// shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Works on CanvasItems (Node2D and Control)
shader_type canvas_item;

// Pi
const float PI = 3.1415926538;

// How many waves are present throughout the object (Number)
uniform float WAVE_NUMBER = 5.0;

// How fast the wave completes a full cycle (Hertz)
uniform float WAVE_FREQUENCY = 1.0;

// How large the wave's side-to-side movement is (Texture Pixels)
uniform float WAVE_AMPLITUDE = 0.5;

void fragment() {
    // All this shader does is set the current pixel's colour to another pixel's colour, depending on a given offset
    // The offset is the required wave pattern
    COLOR = texture(
        // Take from the texture applied to it
		TEXTURE,
        // At the current pixel's coordinate plus the offset
		UV + vec2(
            // Where the offset is along the x axis and follows the standard wave equation
            //     A sin(kx - wt)
            // Where A = Amplitude of the wave
            //       k = 2 * PI * wave number
            //       w = 2 * PI * frequency
            //       x = required position coordinate
            //       t = time
            // The extra UV.y parameter makes the amplitude grow from 0 to 1 as it goes from top to bottom,
            // effectively pinning the wave at the top
			WAVE_AMPLITUDE * TEXTURE_PIXEL_SIZE.y * UV.y * sin(
				(2.0 * PI * WAVE_NUMBER * UV.y)
				- (2.0 * PI * WAVE_FREQUENCY * TIME)
            ),
            // No y coordinate offset
			0
		)
	);
}