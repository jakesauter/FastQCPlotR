<!DOCTYPE html>

<html>

<head>

<meta charset="utf-8" />
<meta name="generator" content="pandoc" />
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />

<meta name="viewport" content="width=device-width, initial-scale=1" />

<meta name="author" content="Jake Sauter" />


<title>FastqPlotR Vignette</title>

<script>// Hide empty <a> tag within highlighted CodeBlock for screen reader accessibility (see https://github.com/jgm/pandoc/issues/6352#issuecomment-626106786) -->
// v0.0.1
// Written by JooYoung Seo (jooyoung@psu.edu) and Atsushi Yasumoto on June 1st, 2020.

document.addEventListener('DOMContentLoaded', function() {
  const codeList = document.getElementsByClassName("sourceCode");
  for (var i = 0; i < codeList.length; i++) {
    var linkList = codeList[i].getElementsByTagName('a');
    for (var j = 0; j < linkList.length; j++) {
      if (linkList[j].innerHTML === "") {
        linkList[j].setAttribute('aria-hidden', 'true');
      }
    }
  }
});
</script>

<style type="text/css">
  code{white-space: pre-wrap;}
  span.smallcaps{font-variant: small-caps;}
  span.underline{text-decoration: underline;}
  div.column{display: inline-block; vertical-align: top; width: 50%;}
  div.hanging-indent{margin-left: 1.5em; text-indent: -1.5em;}
  ul.task-list{list-style: none;}
    </style>


<style type="text/css">code{white-space: pre;}</style>
<style type="text/css" data-origin="pandoc">
code.sourceCode > span { display: inline-block; line-height: 1.25; }
code.sourceCode > span { color: inherit; text-decoration: inherit; }
code.sourceCode > span:empty { height: 1.2em; }
.sourceCode { overflow: visible; }
code.sourceCode { white-space: pre; position: relative; }
div.sourceCode { margin: 1em 0; }
pre.sourceCode { margin: 0; }
@media screen {
div.sourceCode { overflow: auto; }
}
@media print {
code.sourceCode { white-space: pre-wrap; }
code.sourceCode > span { text-indent: -5em; padding-left: 5em; }
}
pre.numberSource code
  { counter-reset: source-line 0; }
pre.numberSource code > span
  { position: relative; left: -4em; counter-increment: source-line; }
pre.numberSource code > span > a:first-child::before
  { content: counter(source-line);
    position: relative; left: -1em; text-align: right; vertical-align: baseline;
    border: none; display: inline-block;
    -webkit-touch-callout: none; -webkit-user-select: none;
    -khtml-user-select: none; -moz-user-select: none;
    -ms-user-select: none; user-select: none;
    padding: 0 4px; width: 4em;
    color: #aaaaaa;
  }
pre.numberSource { margin-left: 3em; border-left: 1px solid #aaaaaa;  padding-left: 4px; }
div.sourceCode
  {   }
@media screen {
code.sourceCode > span > a:first-child::before { text-decoration: underline; }
}
code span.al { color: #ff0000; font-weight: bold; } /* Alert */
code span.an { color: #60a0b0; font-weight: bold; font-style: italic; } /* Annotation */
code span.at { color: #7d9029; } /* Attribute */
code span.bn { color: #40a070; } /* BaseN */
code span.bu { } /* BuiltIn */
code span.cf { color: #007020; font-weight: bold; } /* ControlFlow */
code span.ch { color: #4070a0; } /* Char */
code span.cn { color: #880000; } /* Constant */
code span.co { color: #60a0b0; font-style: italic; } /* Comment */
code span.cv { color: #60a0b0; font-weight: bold; font-style: italic; } /* CommentVar */
code span.do { color: #ba2121; font-style: italic; } /* Documentation */
code span.dt { color: #902000; } /* DataType */
code span.dv { color: #40a070; } /* DecVal */
code span.er { color: #ff0000; font-weight: bold; } /* Error */
code span.ex { } /* Extension */
code span.fl { color: #40a070; } /* Float */
code span.fu { color: #06287e; } /* Function */
code span.im { } /* Import */
code span.in { color: #60a0b0; font-weight: bold; font-style: italic; } /* Information */
code span.kw { color: #007020; font-weight: bold; } /* Keyword */
code span.op { color: #666666; } /* Operator */
code span.ot { color: #007020; } /* Other */
code span.pp { color: #bc7a00; } /* Preprocessor */
code span.sc { color: #4070a0; } /* SpecialChar */
code span.ss { color: #bb6688; } /* SpecialString */
code span.st { color: #4070a0; } /* String */
code span.va { color: #19177c; } /* Variable */
code span.vs { color: #4070a0; } /* VerbatimString */
code span.wa { color: #60a0b0; font-weight: bold; font-style: italic; } /* Warning */

</style>
<script>
// apply pandoc div.sourceCode style to pre.sourceCode instead
(function() {
  var sheets = document.styleSheets;
  for (var i = 0; i < sheets.length; i++) {
    if (sheets[i].ownerNode.dataset["origin"] !== "pandoc") continue;
    try { var rules = sheets[i].cssRules; } catch (e) { continue; }
    for (var j = 0; j < rules.length; j++) {
      var rule = rules[j];
      // check if there is a div.sourceCode rule
      if (rule.type !== rule.STYLE_RULE || rule.selectorText !== "div.sourceCode") continue;
      var style = rule.style.cssText;
      // check if color or background-color is set
      if (rule.style.color === '' && rule.style.backgroundColor === '') continue;
      // replace div.sourceCode by a pre.sourceCode rule
      sheets[i].deleteRule(j);
      sheets[i].insertRule('pre.sourceCode{' + style + '}', j);
    }
  }
})();
</script>




<style type="text/css">body {
background-color: #fff;
margin: 1em auto;
max-width: 700px;
overflow: visible;
padding-left: 2em;
padding-right: 2em;
font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
font-size: 14px;
line-height: 1.35;
}
#TOC {
clear: both;
margin: 0 0 10px 10px;
padding: 4px;
width: 400px;
border: 1px solid #CCCCCC;
border-radius: 5px;
background-color: #f6f6f6;
font-size: 13px;
line-height: 1.3;
}
#TOC .toctitle {
font-weight: bold;
font-size: 15px;
margin-left: 5px;
}
#TOC ul {
padding-left: 40px;
margin-left: -1.5em;
margin-top: 5px;
margin-bottom: 5px;
}
#TOC ul ul {
margin-left: -2em;
}
#TOC li {
line-height: 16px;
}
table {
margin: 1em auto;
border-width: 1px;
border-color: #DDDDDD;
border-style: outset;
border-collapse: collapse;
}
table th {
border-width: 2px;
padding: 5px;
border-style: inset;
}
table td {
border-width: 1px;
border-style: inset;
line-height: 18px;
padding: 5px 5px;
}
table, table th, table td {
border-left-style: none;
border-right-style: none;
}
table thead, table tr.even {
background-color: #f7f7f7;
}
p {
margin: 0.5em 0;
}
blockquote {
background-color: #f6f6f6;
padding: 0.25em 0.75em;
}
hr {
border-style: solid;
border: none;
border-top: 1px solid #777;
margin: 28px 0;
}
dl {
margin-left: 0;
}
dl dd {
margin-bottom: 13px;
margin-left: 13px;
}
dl dt {
font-weight: bold;
}
ul {
margin-top: 0;
}
ul li {
list-style: circle outside;
}
ul ul {
margin-bottom: 0;
}
pre, code {
background-color: #f7f7f7;
border-radius: 3px;
color: #333;
white-space: pre-wrap; 
}
pre {
border-radius: 3px;
margin: 5px 0px 10px 0px;
padding: 10px;
}
pre:not([class]) {
background-color: #f7f7f7;
}
code {
font-family: Consolas, Monaco, 'Courier New', monospace;
font-size: 85%;
}
p > code, li > code {
padding: 2px 0px;
}
div.figure {
text-align: center;
}
img {
background-color: #FFFFFF;
padding: 2px;
border: 1px solid #DDDDDD;
border-radius: 3px;
border: 1px solid #CCCCCC;
margin: 0 5px;
}
h1 {
margin-top: 0;
font-size: 35px;
line-height: 40px;
}
h2 {
border-bottom: 4px solid #f7f7f7;
padding-top: 10px;
padding-bottom: 2px;
font-size: 145%;
}
h3 {
border-bottom: 2px solid #f7f7f7;
padding-top: 10px;
font-size: 120%;
}
h4 {
border-bottom: 1px solid #f7f7f7;
margin-left: 8px;
font-size: 105%;
}
h5, h6 {
border-bottom: 1px solid #ccc;
font-size: 105%;
}
a {
color: #0033dd;
text-decoration: none;
}
a:hover {
color: #6666ff; }
a:visited {
color: #800080; }
a:visited:hover {
color: #BB00BB; }
a[href^="http:"] {
text-decoration: underline; }
a[href^="https:"] {
text-decoration: underline; }

code > span.kw { color: #555; font-weight: bold; } 
code > span.dt { color: #902000; } 
code > span.dv { color: #40a070; } 
code > span.bn { color: #d14; } 
code > span.fl { color: #d14; } 
code > span.ch { color: #d14; } 
code > span.st { color: #d14; } 
code > span.co { color: #888888; font-style: italic; } 
code > span.ot { color: #007020; } 
code > span.al { color: #ff0000; font-weight: bold; } 
code > span.fu { color: #900; font-weight: bold; } 
code > span.er { color: #a61717; background-color: #e3d2d2; } 
</style>




</head>

<body>




<h1 class="title toc-ignore">FastqPlotR Vignette</h1>
<h4 class="author">Jake Sauter</h4>
<h4 class="date">2/19/2021</h4>



<p>Welcome to <code>FastQCPlotR</code>! The heart of this package is the <code>reading_in(file,test)</code> utility that we will soon review, however at a high level this function can aid the user for reading in the results of their <code>FastQC</code> runs over NGS data, as well as <strong>plotting</strong> this data!</p>
<p>Before we continue, we will have to import a few packages that this vignette relies on.</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">library</span>(FastQCPlotR)</span>
<span id="cb1-2"><a href="#cb1-2"></a><span class="kw">library</span>(magrittr)</span>
<span id="cb1-3"><a href="#cb1-3"></a><span class="kw">library</span>(ggplot2)</span>
<span id="cb1-4"><a href="#cb1-4"></a><span class="kw">library</span>(dplyr)</span>
<span id="cb1-5"><a href="#cb1-5"></a><span class="kw">library</span>(knitr)</span></code></pre></div>
<div id="function-reading_infile-test" class="section level2">
<h2><strong>Function: reading_in(file, test)</strong></h2>
<p>The heart of the <code>FastQCPlotR</code> package is the <code>reading_in</code> function. This function takes as arguments:</p>
<div id="arguments" class="section level3">
<h3><strong>Arguments</strong></h3>
<div class="sourceCode" id="cb2"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb2-1"><a href="#cb2-1"></a><span class="kw">args</span>(reading_in)</span></code></pre></div>
<pre><code>## function (file, test = &quot;Per base sequence quality&quot;, sample_name = NULL) 
## NULL</code></pre>
<ul>
<li><code>file</code>: The <code>FastQC</code> output file to read in. This file is usually named <code>fastqc_data.txt</code> in the output directory of your <code>FastQC</code> run.</li>
<li><code>test</code>: The test results data to read from the <code>FastQC</code> results file. By default this is “Per base sequence quality”, however the user can pass any valid <code>FastQC</code> section identifier.</li>
<li><code>sample_name</code>: (optional) A name to give the sample, this name will be appended as a new column to every row.</li>
</ul>
<p>We can see the function in action, and observe a few resultant rows of output below.</p>
<div class="sourceCode" id="cb4"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb4-1"><a href="#cb4-1"></a>fastqc_data_file &lt;-<span class="st"> </span></span>
<span id="cb4-2"><a href="#cb4-2"></a><span class="st">   </span><span class="kw">system.file</span>(<span class="st">&#39;extdata&#39;</span>, </span>
<span id="cb4-3"><a href="#cb4-3"></a>            <span class="st">&#39;/fastqc_files/ERR458493_fastqc_data.txt&#39;</span>, </span>
<span id="cb4-4"><a href="#cb4-4"></a>            <span class="dt">package =</span> <span class="st">&quot;FastQCPlotR&quot;</span>)</span>
<span id="cb4-5"><a href="#cb4-5"></a></span>
<span id="cb4-6"><a href="#cb4-6"></a><span class="kw">reading_in</span>(fastqc_data_file) <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb4-7"><a href="#cb4-7"></a><span class="st">   </span><span class="kw">head</span>() <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb4-8"><a href="#cb4-8"></a><span class="st">   </span><span class="kw">kable</span>()</span></code></pre></div>
<table>
<thead>
<tr class="header">
<th align="right">Base</th>
<th align="right">Mean</th>
<th align="right">Median</th>
<th align="right">Lower Quartile</th>
<th align="right">Upper Quartile</th>
<th align="right">10th Percentile</th>
<th align="right">90th Percentile</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">1</td>
<td align="right">30.50709</td>
<td align="right">31</td>
<td align="right">30</td>
<td align="right">33</td>
<td align="right">28</td>
<td align="right">34</td>
</tr>
<tr class="even">
<td align="right">2</td>
<td align="right">28.67558</td>
<td align="right">31</td>
<td align="right">28</td>
<td align="right">31</td>
<td align="right">16</td>
<td align="right">34</td>
</tr>
<tr class="odd">
<td align="right">3</td>
<td align="right">27.46926</td>
<td align="right">31</td>
<td align="right">25</td>
<td align="right">31</td>
<td align="right">16</td>
<td align="right">34</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="right">31.09976</td>
<td align="right">35</td>
<td align="right">28</td>
<td align="right">37</td>
<td align="right">19</td>
<td align="right">37</td>
</tr>
<tr class="odd">
<td align="right">5</td>
<td align="right">33.49616</td>
<td align="right">35</td>
<td align="right">33</td>
<td align="right">37</td>
<td align="right">28</td>
<td align="right">37</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">34.46542</td>
<td align="right">35</td>
<td align="right">35</td>
<td align="right">37</td>
<td align="right">31</td>
<td align="right">37</td>
</tr>
</tbody>
</table>
<p>Now that we have seen this function in action, we can review how exactly it works. First, lets take a look at the body of the function.</p>
</div>
<div id="body" class="section level3">
<h3><strong>Body</strong></h3>
<div class="sourceCode" id="cb5"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb5-1"><a href="#cb5-1"></a><span class="kw">body</span>(reading_in)</span></code></pre></div>
<pre><code>## {
##     syscommand &lt;- paste0(&quot;sed -n &#39;/&quot;, test, &quot;/,/END_MODULE/p&#39; &quot;, 
##         file, &quot; | grep -v &#39;^&gt;&gt;&#39;&quot;)
##     df &lt;- data.table::fread(cmd = syscommand, header = TRUE) %&gt;% 
##         as.data.frame() %&gt;% rename(Base = `#Base`)
##     if (!is.null(sample_name) &amp;&amp; is.character(sample_name)) {
##         df &lt;- cbind(df, sample_name)
##     }
##     else if (!is.character(sample_name)) {
##         message(paste(&quot;sample_name parameter must be a character vector!&quot;), 
##             &quot; sample_name will not be included!&quot;)
##     }
##     return(df)
## }</code></pre>
<p>We can see above that the <code>reading_in()</code> command makes use of a <code>Unix</code> system command making using of <code>sed</code>. In order to fully understand what the <code>reading_in()</code> function is doing, we will explain the use of <code>sed</code> in this context.</p>
<p>Given the functions arguments of <code>test</code> and <code>file</code>, the function forms a command that will look similar to below for the following inputs:</p>
<div class="sourceCode" id="cb7"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb7-1"><a href="#cb7-1"></a>test =<span class="st"> &quot;Per base sequence quality&quot;</span></span>
<span id="cb7-2"><a href="#cb7-2"></a>file =<span class="st"> &#39;/home/x1/Documents/Weill_Cornell/ANGSD/homework/FastQCPlotR/data/ERR458497_fastqc/fastqc_data.txt&#39;</span></span>
<span id="cb7-3"><a href="#cb7-3"></a></span>
<span id="cb7-4"><a href="#cb7-4"></a><span class="kw">paste0</span>(<span class="st">&quot;sed -n &#39;/&quot;</span>, test, <span class="st">&quot;/,/END_MODULE/p&#39; &quot;</span>, </span>
<span id="cb7-5"><a href="#cb7-5"></a>        file, <span class="st">&quot; | grep -v &#39;^&gt;&gt;&#39;&quot;</span>)</span></code></pre></div>
<pre><code>## [1] &quot;sed -n &#39;/Per base sequence quality/,/END_MODULE/p&#39; /home/x1/Documents/Weill_Cornell/ANGSD/homework/FastQCPlotR/data/ERR458497_fastqc/fastqc_data.txt | grep -v &#39;^&gt;&gt;&#39;&quot;</code></pre>
<p>About the <code>sed</code> command:</p>
<ul>
<li><code>sed</code> – stream editor</li>
<li><code>-n</code> – silent option</li>
</ul>
<p>In this case, <code>sed</code> is being used to extract the “Per base sequence quality” section from the <code>fastqc_data.txt</code> file. From the <code>sed</code> manual page, we can find that the <code>p</code> option tells <code>sed</code> to <strong>Print the current pattern space</strong>. Thus this command returns the whole matching subsection of the <code>FastQC</code> results file that we are interested in.</p>
<p>From section 5.1 of the <code>sed</code> manual, accessed through the <code>info sed</code> command,</p>
<div class="sourceCode" id="cb9"><pre class="sourceCode bash"><code class="sourceCode bash"><span id="cb9-1"><a href="#cb9-1"></a><span class="ex">5.1</span> Overview of regular expression in <span class="st">&#39;sed&#39;</span></span>
<span id="cb9-2"><a href="#cb9-2"></a>===========================================</span>
<span id="cb9-3"><a href="#cb9-3"></a></span>
<span id="cb9-4"><a href="#cb9-4"></a><span class="ex">To</span> know how to use <span class="st">&#39;sed&#39;</span>, people should understand regular expressions</span>
<span id="cb9-5"><a href="#cb9-5"></a><span class="kw">(</span><span class="st">&quot;regexp&quot;</span> <span class="kw">for</span> <span class="ex">short</span><span class="kw">)</span><span class="bu">.</span>  <span class="ex">A</span> regular expression is a pattern that is matched</span>
<span id="cb9-6"><a href="#cb9-6"></a><span class="ex">against</span> a subject string from left to right.  Most characters are</span>
<span id="cb9-7"><a href="#cb9-7"></a><span class="st">&quot;ordinary&quot;</span>: <span class="ex">they</span> stand for themselves in a pattern, and match the</span>
<span id="cb9-8"><a href="#cb9-8"></a><span class="ex">corresponding</span> characters.  Regular expressions in <span class="st">&#39;sed&#39;</span> are specified</span>
<span id="cb9-9"><a href="#cb9-9"></a><span class="ex">between</span> two slashes.</span>
<span id="cb9-10"><a href="#cb9-10"></a></span>
<span id="cb9-11"><a href="#cb9-11"></a>   <span class="ex">The</span> following command prints lines containing the word <span class="st">&#39;hello&#39;</span>:</span>
<span id="cb9-12"><a href="#cb9-12"></a></span>
<span id="cb9-13"><a href="#cb9-13"></a>     <span class="fu">sed</span> -n <span class="st">&#39;/hello/p&#39;</span></span>
<span id="cb9-14"><a href="#cb9-14"></a></span>
<span id="cb9-15"><a href="#cb9-15"></a>   <span class="ex">The</span> above example is equivalent to this <span class="st">&#39;grep&#39;</span> command:</span>
<span id="cb9-16"><a href="#cb9-16"></a></span>
<span id="cb9-17"><a href="#cb9-17"></a>     <span class="fu">grep</span> <span class="st">&#39;hello&#39;</span></span></code></pre></div>
<p>More specifically, this command uses <code>regular expressions</code> contained within <code>/.../</code> forward slashes to dictate to <code>sed</code> the starting and ending patterns, followed by <code>p</code> telling <code>sed</code> to print all of the lines in this section. This function in particular uses a variable that allows for parsing the file to isolate different sections, with each section always ending with <code>END_MODULE</code>.</p>
</div>
<div id="use-case" class="section level3">
<h3><strong>Use Case</strong></h3>
<p>We will now use the <code>reading_in</code> function to read in the FastQC results of at 4 fastq files (2 biological replicates and 2 technical replicates each). We will make use of the <code>sample_name</code> argument to <code>reading_in</code> to keep track of the sample name in the new R objects we are creating.</p>
<p>First we will select the files from the <code>sample_mapping.tsv</code> file included in the package to simulate a real NGS workflow. We will load in this runs accession table and filter for only those samples that we are interested in. For this use case, we will be using <code>WT_1</code> and <code>WT_2</code> <strong>biological replicates</strong>, as well as the <strong>technical replicates</strong> sequenced in both lanes 1 and 2 for both biological replicates.</p>
<div class="sourceCode" id="cb10"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb10-1"><a href="#cb10-1"></a>samp_map_file &lt;-<span class="st"> </span><span class="kw">system.file</span>(<span class="st">&quot;extdata&quot;</span>, <span class="st">&#39;sample_mapping.tsv&#39;</span>, <span class="dt">package=</span><span class="st">&quot;FastQCPlotR&quot;</span>)</span>
<span id="cb10-2"><a href="#cb10-2"></a></span>
<span id="cb10-3"><a href="#cb10-3"></a>sample_mapping &lt;-<span class="st"> </span><span class="kw">read.csv</span>(samp_map_file, <span class="dt">sep =</span> <span class="st">&#39;</span><span class="ch">\t</span><span class="st">&#39;</span>) </span>
<span id="cb10-4"><a href="#cb10-4"></a></span>
<span id="cb10-5"><a href="#cb10-5"></a>samples &lt;-<span class="st"> </span>sample_mapping[sample_mapping<span class="op">$</span>Sample <span class="op">==</span><span class="st"> &quot;WT&quot;</span> <span class="op">&amp;</span></span>
<span id="cb10-6"><a href="#cb10-6"></a><span class="st">               </span>sample_mapping<span class="op">$</span>Lane <span class="op">%in%</span><span class="st"> </span><span class="kw">c</span>(<span class="dv">1</span>,<span class="dv">2</span>) <span class="op">&amp;</span></span>
<span id="cb10-7"><a href="#cb10-7"></a><span class="st">               </span>sample_mapping<span class="op">$</span>BiolRep <span class="op">%in%</span><span class="st"> </span><span class="kw">c</span>(<span class="dv">1</span>,<span class="dv">2</span>), ]</span>
<span id="cb10-8"><a href="#cb10-8"></a></span>
<span id="cb10-9"><a href="#cb10-9"></a>samples <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">kable</span>()</span></code></pre></div>
<table>
<thead>
<tr class="header">
<th align="left"></th>
<th align="left">RunAccession</th>
<th align="right">Lane</th>
<th align="left">Sample</th>
<th align="right">BiolRep</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">1</td>
<td align="left">ERR458493</td>
<td align="right">1</td>
<td align="left">WT</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">2</td>
<td align="left">ERR458494</td>
<td align="right">2</td>
<td align="left">WT</td>
<td align="right">1</td>
</tr>
<tr class="odd">
<td align="left">344</td>
<td align="left">ERR458878</td>
<td align="right">1</td>
<td align="left">WT</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">345</td>
<td align="left">ERR458879</td>
<td align="right">2</td>
<td align="left">WT</td>
<td align="right">2</td>
</tr>
</tbody>
</table>
<p>Now that we have isolated our samples of interest, we can access the <code>FastQC</code> files associated with them. For this case we have included some raw data in the package for instructional purposes, though this is where the user <strong>should locate their own FastQC files on their file system</strong>.</p>
<div class="sourceCode" id="cb11"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb11-1"><a href="#cb11-1"></a>run_accs &lt;-<span class="st"> </span>samples<span class="op">$</span>RunAccession</span>
<span id="cb11-2"><a href="#cb11-2"></a></span>
<span id="cb11-3"><a href="#cb11-3"></a>fastqc_files &lt;-</span>
<span id="cb11-4"><a href="#cb11-4"></a><span class="st">   </span><span class="kw">system.file</span>(<span class="st">&quot;extdata&quot;</span>, </span>
<span id="cb11-5"><a href="#cb11-5"></a>      <span class="kw">paste0</span>(<span class="st">&#39;fastqc_files/&#39;</span>, run_accs, <span class="st">&#39;_fastqc_data.txt&#39;</span>),</span>
<span id="cb11-6"><a href="#cb11-6"></a>       <span class="dt">package=</span><span class="st">&quot;FastQCPlotR&quot;</span>)</span>
<span id="cb11-7"><a href="#cb11-7"></a></span>
<span id="cb11-8"><a href="#cb11-8"></a><span class="kw">names</span>(fastqc_files) &lt;-<span class="st"> </span>samples<span class="op">$</span>RunAccession</span>
<span id="cb11-9"><a href="#cb11-9"></a></span>
<span id="cb11-10"><a href="#cb11-10"></a>fastqc_files <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb11-11"><a href="#cb11-11"></a><span class="st">   </span><span class="kw">as.data.frame</span>() <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb11-12"><a href="#cb11-12"></a><span class="st">   </span><span class="kw">t</span>() <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb11-13"><a href="#cb11-13"></a><span class="st">   </span><span class="kw">kable</span>()</span></code></pre></div>
<table>
<colgroup>
<col width="0%"></col>
<col width="24%"></col>
<col width="24%"></col>
<col width="24%"></col>
<col width="24%"></col>
</colgroup>
<thead>
<tr class="header">
<th align="left"></th>
<th align="left">ERR458493</th>
<th align="left">ERR458494</th>
<th align="left">ERR458878</th>
<th align="left">ERR458879</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">.</td>
<td align="left">/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458493_fastqc_data.txt</td>
<td align="left">/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458494_fastqc_data.txt</td>
<td align="left">/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458878_fastqc_data.txt</td>
<td align="left">/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458879_fastqc_data.txt</td>
</tr>
</tbody>
</table>
<p>With these file paths, we can now make use to the <code>reading_in</code> function. Below, we:</p>
<ul>
<li>Pre-allocate a list for the results for each of the files of interest</li>
<li>Read in the <code>FastQC</code> results of interest with <code>reading_in</code></li>
<li>Bind these data frames with <code>dplyr::bind_rows</code></li>
</ul>
<div class="sourceCode" id="cb12"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb12-1"><a href="#cb12-1"></a>fastqc_results &lt;-<span class="st"> </span><span class="kw">vector</span>(<span class="st">&#39;list&#39;</span>, <span class="kw">length</span>(fastqc_files))</span>
<span id="cb12-2"><a href="#cb12-2"></a><span class="kw">names</span>(fastqc_results) &lt;-<span class="st"> </span><span class="kw">names</span>(fastqc_files)</span>
<span id="cb12-3"><a href="#cb12-3"></a></span>
<span id="cb12-4"><a href="#cb12-4"></a><span class="cf">for</span> (sample_name <span class="cf">in</span> <span class="kw">names</span>(fastqc_files)) {</span>
<span id="cb12-5"><a href="#cb12-5"></a>   fastqc_results[[sample_name]] &lt;-<span class="st"> </span></span>
<span id="cb12-6"><a href="#cb12-6"></a><span class="st">      </span><span class="kw">reading_in</span>(<span class="dt">file =</span> fastqc_files,</span>
<span id="cb12-7"><a href="#cb12-7"></a>                 <span class="dt">sample_name =</span> sample_name)</span>
<span id="cb12-8"><a href="#cb12-8"></a>}</span>
<span id="cb12-9"><a href="#cb12-9"></a></span>
<span id="cb12-10"><a href="#cb12-10"></a>df &lt;-<span class="st"> </span>fastqc_results <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb12-11"><a href="#cb12-11"></a><span class="st">   </span><span class="kw">bind_rows</span>() </span>
<span id="cb12-12"><a href="#cb12-12"></a></span>
<span id="cb12-13"><a href="#cb12-13"></a>df <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb12-14"><a href="#cb12-14"></a><span class="st">   </span><span class="kw">head</span>() <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb12-15"><a href="#cb12-15"></a><span class="st">   </span><span class="kw">kable</span>()</span></code></pre></div>
<table>
<colgroup>
<col width="5%"></col>
<col width="9%"></col>
<col width="7%"></col>
<col width="15%"></col>
<col width="15%"></col>
<col width="16%"></col>
<col width="16%"></col>
<col width="12%"></col>
</colgroup>
<thead>
<tr class="header">
<th align="right">Base</th>
<th align="right">Mean</th>
<th align="right">Median</th>
<th align="right">Lower Quartile</th>
<th align="right">Upper Quartile</th>
<th align="right">10th Percentile</th>
<th align="right">90th Percentile</th>
<th align="left">sample_name</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">1</td>
<td align="right">30.50709</td>
<td align="right">31</td>
<td align="right">30</td>
<td align="right">33</td>
<td align="right">28</td>
<td align="right">34</td>
<td align="left">ERR458493</td>
</tr>
<tr class="even">
<td align="right">2</td>
<td align="right">28.67558</td>
<td align="right">31</td>
<td align="right">28</td>
<td align="right">31</td>
<td align="right">16</td>
<td align="right">34</td>
<td align="left">ERR458493</td>
</tr>
<tr class="odd">
<td align="right">3</td>
<td align="right">27.46926</td>
<td align="right">31</td>
<td align="right">25</td>
<td align="right">31</td>
<td align="right">16</td>
<td align="right">34</td>
<td align="left">ERR458493</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="right">31.09976</td>
<td align="right">35</td>
<td align="right">28</td>
<td align="right">37</td>
<td align="right">19</td>
<td align="right">37</td>
<td align="left">ERR458493</td>
</tr>
<tr class="odd">
<td align="right">5</td>
<td align="right">33.49616</td>
<td align="right">35</td>
<td align="right">33</td>
<td align="right">37</td>
<td align="right">28</td>
<td align="right">37</td>
<td align="left">ERR458493</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">34.46542</td>
<td align="right">35</td>
<td align="right">35</td>
<td align="right">37</td>
<td align="right">31</td>
<td align="right">37</td>
<td align="left">ERR458493</td>
</tr>
</tbody>
</table>
</div>
<div id="plotting-fastqc-results" class="section level3">
<h3><strong>Plotting <code>FastQC</code> Results</strong></h3>
<p>We can use the function <code>FastQCPlotR::plot_per_base_seq_qual</code></p>
<div class="sourceCode" id="cb13"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb13-1"><a href="#cb13-1"></a><span class="kw">body</span>(plot_per_base_seq_qual)</span></code></pre></div>
<pre><code>## {
##     yaxis &lt;- if (base::missing(yaxis)) 
##         sym(&quot;Mean&quot;)
##     else enquo(yaxis)
##     color &lt;- if (base::missing(color)) 
##         sym(&quot;sample_name&quot;)
##     else enquo(color)
##     facet_by &lt;- if (base::missing(facet_by)) 
##         sym(&quot;sample_group&quot;)
##     else enquo(facet_by)
##     p &lt;- df %&gt;% ggplot() + geom_point(aes(x = Base, y = !!yaxis, 
##         color = !!color)) + facet_wrap(vars(!!facet_by))
##     plot(p)
##     invisible(p)
## }</code></pre>
<p>We can see that this function is just a helpful wrapper around <code>ggplot2::geom_point</code> and <code>ggplot2::facet_wrap</code> for plotting this sort of data.</p>
<div class="sourceCode" id="cb15"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb15-1"><a href="#cb15-1"></a>sample_groups &lt;-<span class="st"> </span><span class="kw">paste0</span>(samples<span class="op">$</span>Sample, <span class="st">&#39;_&#39;</span>, samples<span class="op">$</span>BiolRep)</span>
<span id="cb15-2"><a href="#cb15-2"></a><span class="kw">names</span>(sample_groups) &lt;-<span class="st"> </span>samples<span class="op">$</span>RunAccession</span>
<span id="cb15-3"><a href="#cb15-3"></a></span>
<span id="cb15-4"><a href="#cb15-4"></a>fastqc_plotr_sample_df &lt;-<span class="st"> </span>df <span class="op">%&gt;%</span></span>
<span id="cb15-5"><a href="#cb15-5"></a><span class="st">   </span><span class="kw">mutate</span>(<span class="dt">sample_group =</span> sample_groups[sample_name])</span>
<span id="cb15-6"><a href="#cb15-6"></a></span>
<span id="cb15-7"><a href="#cb15-7"></a><span class="co"># usethis::use_data(fastqc_plotr_sample_df)</span></span>
<span id="cb15-8"><a href="#cb15-8"></a></span>
<span id="cb15-9"><a href="#cb15-9"></a>fastqc_plotr_sample_df <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb15-10"><a href="#cb15-10"></a><span class="st">   </span><span class="kw">plot_per_base_seq_qual</span>()</span></code></pre></div>
<p><img src="data:image/png;base64,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" /><!-- --></p>
<p>For comparison, we can see the data accompanying the package will produce the same plot.</p>
<div class="sourceCode" id="cb16"><pre class="sourceCode r"><code class="sourceCode r"><span id="cb16-1"><a href="#cb16-1"></a>FastQCPlotR<span class="op">::</span>fastqc_plotr_sample_df <span class="op">%&gt;%</span><span class="st"> </span></span>
<span id="cb16-2"><a href="#cb16-2"></a><span class="st">   </span><span class="kw">plot_per_base_seq_qual</span>()</span></code></pre></div>
<p><img src="data:image/png;base64,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" /><!-- --></p>
</div>
</div>



<!-- code folding -->


<!-- dynamically load mathjax for compatibility with self-contained -->
<script>
  (function () {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
    document.getElementsByTagName("head")[0].appendChild(script);
  })();
</script>

</body>
</html>
