# ABC-RRT-STAR
A MATLAB implementation of our ABC-RRT-STAR planner

# How to use
- In our planner, the "abcRrtStar.m" file is serving as the main function, and other files are serving as the subfunctions of the main function 
- For single test, the reader can run the following code e.g. `statisticalResult = abcRrtStar( 'aaa\bbb\clutter1.png', 1, [1 1], [1100 800], 30000, 20, 20, 'test', 'test' )` in current directory of Matlab command line window 
- The meaning of the parameters is listed in the main function.
- Note that the first parameter needs to be corrected as right path of the map. The map format is limited to xxx.png. We also provide a map file (clutter1.png) with .png format to improve the reproducibility of the code
- After the code is executed, two image files (a "testxxx.fig" file and a "testxxx.png" file) will be generated in the current directory to visualize the planning results

# Requirements
- Matlab 2020b
- Windows 10 platform
- Ensure the input map with .png format

# Contact 
- imut_liujiarui@163.com

