<p><span style="font-weight: 400;">A brain fuck interpreter written in assembly x86-64</span></p>
<p>&nbsp;</p>
<p><span style="font-weight: 400;">A brain fuck interpreter wrriten using assembly x86-64</span></p>
<p>&nbsp;</p>
<h1><span style="font-weight: 400;">Technical information:</span></h1>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">This interpreter provides a total of 300000 cells of 8 bits</span></li>
<li style="font-weight: 400;"><span style="font-weight: 400;">Cell pointer will start in the middle of the total (150000)</span></li>
<li style="font-weight: 400;"><span style="font-weight: 400;">There is no wrap in the cell pointer so make sure you don&rsquo;t go out of boundaries</span></li>
<li style="font-weight: 400;"><span style="font-weight: 400;">Reads up to 1 million commands</span></li>
</ul>
<p>&nbsp;</p>
<h1><span style="font-weight: 400;">Compile:</span></h1>
<p><span style="font-weight: 400;">gcc -o brain brain.s -no-pie</span></p>
<h1><span style="font-weight: 400;">Run:</span></h1>
<p><span style="font-weight: 400;">./brain hanoi.b</span></p>
<p>&nbsp;</p>
<p><span style="font-weight: 400;">./brain m.b</span></p>
<p>&nbsp;</p>
<h1><span style="font-weight: 400;">Tests:</span></h1>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">Calculate the e number with infinite precision</span></li>
</ul>
<p>&nbsp;</p>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">Ran the towers of hanoi all the way until the end</span></li>
<li style="font-weight: 400;"><span style="font-weight: 400;">Ran the mandelbrot and the extreme mandelbrot</span></li>
</ul>
<p><br /><br /></p>