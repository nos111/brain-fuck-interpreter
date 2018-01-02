<h1><span style="font-weight: 400;">A brain fuck interpreter written in assembly x86-64</span></h1>
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
<p><span style="font-weight: 400;">./brain m.b</span></p>
<h1><span style="font-weight: 400;">Tests:</span></h1>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">Calculate the e number with infinite precision</span><span style="font-weight: 400;"><img src="https://github.com/nos111/brain-fuck-interpreter/blob/master/photos/e.png?raw=true" alt="" width="734" height="462" /></span></li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">The towers of hanoi&nbsp;</span><span style="font-weight: 400;"><img src="https://github.com/nos111/brain-fuck-interpreter/blob/master/photos/hanoitowers.png?raw=true" alt="" width="734" height="499" /></span></li>
<li style="font-weight: 400;"><span style="font-weight: 400;">The mandelbrot&nbsp;</span><span style="font-weight: 400;"><br />
 <img src="https://github.com/nos111/brain-fuck-interpreter/blob/master/photos/mandelbrot.png?raw=true" alt="" width="734" height="499" /><br /></span></li>
</ul>
