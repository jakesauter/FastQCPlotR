# **FastQCPlotR**

## **Install Instructions**

install.packages('https://github.com/jakesauter/FastQCPlotR/blob/main/FastQCPlotR_0.1.0.tar.gz?raw=true', type='source', repos=NULL)

## **Introduction and Dependencies**

Welcome to `FastQCPlotR`! The heart of this package is the 
`reading_in(file,test)` utility that we will soon review, however
at a high level this function can aid the user for reading in 
the results of their `FastQC` runs over NGS data, as well 
as **plotting** this data!

Before we continue, we will have to import a few packages that this
vignette relies on.


```r
library(FastQCPlotR)
library(magrittr)
library(ggplot2)
library(dplyr)
library(knitr)
```

## **Function: reading_in(file, test)**

The heart of the `FastQCPlotR` package is the `reading_in` function. This
function takes as arguments: 

### **Arguments**

```r
args(reading_in)
```

```
## function (file, test = "Per base sequence quality", sample_name = NULL) 
## NULL
```

* `file`: The `FastQC` output file to read in. This file is usually named
   `fastqc_data.txt` in the output directory of your `FastQC` run.
* `test`: The test results data to read from the `FastQC` results file.
 By default this is "Per base sequence quality", however the user can pass 
 any valid `FastQC` section identifier.
* `sample_name`: (optional) A name to give the sample, this name will be appended
   as a new column to every row.

We can see the function in action, and observe a few resultant 
rows of output below.


```r
fastqc_data_file <- 
   system.file('extdata', 
            '/fastqc_files/ERR458493_fastqc_data.txt', 
            package = "FastQCPlotR")

reading_in(fastqc_data_file) %>% 
   head() %>% 
   kable()
```



| Base|     Mean| Median| Lower Quartile| Upper Quartile| 10th Percentile| 90th Percentile|
|----:|--------:|------:|--------------:|--------------:|---------------:|---------------:|
|    1| 30.50709|     31|             30|             33|              28|              34|
|    2| 28.67558|     31|             28|             31|              16|              34|
|    3| 27.46926|     31|             25|             31|              16|              34|
|    4| 31.09976|     35|             28|             37|              19|              37|
|    5| 33.49616|     35|             33|             37|              28|              37|
|    6| 34.46542|     35|             35|             37|              31|              37|

Now that we have seen this function in action, we can review how
exactly it works. First, lets take a look at the body of the function.

### **Body**


```r
body(reading_in)
```

```
## {
##     syscommand <- paste0("sed -n '/", test, "/,/END_MODULE/p' ", 
##         file, " | grep -v '^>>'")
##     df <- data.table::fread(cmd = syscommand, header = TRUE) %>% 
##         as.data.frame() %>% rename(Base = `#Base`)
##     if (!is.null(sample_name) && is.character(sample_name)) {
##         df <- cbind(df, sample_name)
##     }
##     else if (!is.character(sample_name)) {
##         message(paste("sample_name parameter must be a character vector!"), 
##             " sample_name will not be included!")
##     }
##     return(df)
## }
```

We can see above that the `reading_in()` command makes use of
a `Unix` system command making using of `sed`. In order to
fully understand what the `reading_in()` function is doing, 
we will explain the use of `sed` in this context. 

Given the functions arguments of `test` and `file`, the function
forms a command that will look similar to below for the following
inputs: 


```r
test = "Per base sequence quality"
file = '/home/x1/Documents/Weill_Cornell/ANGSD/homework/FastQCPlotR/data/ERR458497_fastqc/fastqc_data.txt'

paste0("sed -n '/", test, "/,/END_MODULE/p' ", 
        file, " | grep -v '^>>'")
```

```
## [1] "sed -n '/Per base sequence quality/,/END_MODULE/p' /home/x1/Documents/Weill_Cornell/ANGSD/homework/FastQCPlotR/data/ERR458497_fastqc/fastqc_data.txt | grep -v '^>>'"
```

About the `sed` command: 

   * `sed` -- stream editor
   * `-n` -- silent option

In this case, `sed` is being used to extract the "Per base sequence quality" section
from the `fastqc_data.txt` file. From the `sed` manual page, we can find that 
the `p` option tells `sed` to **Print the current pattern space**. Thus this command
returns the whole matching subsection of the `FastQC` results file that we are 
interested in.

From section 5.1 of the `sed` manual, accessed through the `info sed` command, 


```bash
5.1 Overview of regular expression in 'sed'
===========================================

To know how to use 'sed', people should understand regular expressions
("regexp" for short).  A regular expression is a pattern that is matched
against a subject string from left to right.  Most characters are
"ordinary": they stand for themselves in a pattern, and match the
corresponding characters.  Regular expressions in 'sed' are specified
between two slashes.

   The following command prints lines containing the word 'hello':

     sed -n '/hello/p'

   The above example is equivalent to this 'grep' command:

     grep 'hello'
```


More specifically, this command uses `regular expressions` contained within `/.../` forward
slashes to dictate to `sed` the starting and ending patterns, followed
by `p` telling `sed` to print all of the lines in this section. This
function in particular uses a variable that allows for parsing 
the file to isolate different sections, with each section 
always ending with `END_MODULE`.

### **Use Case**

We will now use the `reading_in` function to read in the FastQC results of at 4 fastq files (2 biological replicates and 2 technical replicates each). We will make use of the `sample_name` argument to `reading_in` to keep track of the sample name in the new R objects we are creating.

First we will select the files from the `sample_mapping.tsv` file included 
in the package to simulate a real NGS workflow. We will load in this 
runs accession table and filter for only those samples that we are 
interested in. For this use case, we will be using `WT_1` and `WT_2` 
**biological replicates**, as well as the **technical replicates** sequenced
in both lanes 1 and 2 for both biological replicates.


```r
samp_map_file <- system.file("extdata", 'sample_mapping.tsv', package="FastQCPlotR")

sample_mapping <- read.csv(samp_map_file, sep = '\t') 

samples <- sample_mapping[sample_mapping$Sample == "WT" &
               sample_mapping$Lane %in% c(1,2) &
               sample_mapping$BiolRep %in% c(1,2), ]

samples %>% kable()
```



|    |RunAccession | Lane|Sample | BiolRep|
|:---|:------------|----:|:------|-------:|
|1   |ERR458493    |    1|WT     |       1|
|2   |ERR458494    |    2|WT     |       1|
|344 |ERR458878    |    1|WT     |       2|
|345 |ERR458879    |    2|WT     |       2|

Now that we have isolated our samples of interest, we can access the
`FastQC` files associated with them. For this case we have included 
some raw data in the package for instructional purposes, though this
is where the user **should locate their own FastQC files on their 
file system**.


```r
run_accs <- samples$RunAccession

fastqc_files <-
   system.file("extdata", 
      paste0('fastqc_files/', run_accs, '_fastqc_data.txt'),
       package="FastQCPlotR")

names(fastqc_files) <- samples$RunAccession

fastqc_files %>% 
   as.data.frame() %>% 
   t() %>% 
   kable()
```



|   |ERR458493                                                                                             |ERR458494                                                                                             |ERR458878                                                                                             |ERR458879                                                                                             |
|:--|:-----------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|
|.  |/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458493_fastqc_data.txt |/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458494_fastqc_data.txt |/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458878_fastqc_data.txt |/home/x1/R/x86_64-pc-linux-gnu-library/3.6/FastQCPlotR/extdata/fastqc_files/ERR458879_fastqc_data.txt |

With these file paths, we can now make use to the `reading_in` function. 
Below, we: 

   * Pre-allocate a list for the results for each of the files of interest
   * Read in the `FastQC` results of interest with `reading_in`
   * Bind these data frames with `dplyr::bind_rows`



```r
fastqc_results <- vector('list', length(fastqc_files))
names(fastqc_results) <- names(fastqc_files)

for (sample_name in names(fastqc_files)) {
   fastqc_results[[sample_name]] <- 
      reading_in(file = fastqc_files,
                 sample_name = sample_name)
}

df <- fastqc_results %>% 
   bind_rows() 

df %>% 
   head() %>% 
   kable()
```



| Base|     Mean| Median| Lower Quartile| Upper Quartile| 10th Percentile| 90th Percentile|sample_name |
|----:|--------:|------:|--------------:|--------------:|---------------:|---------------:|:-----------|
|    1| 30.50709|     31|             30|             33|              28|              34|ERR458493   |
|    2| 28.67558|     31|             28|             31|              16|              34|ERR458493   |
|    3| 27.46926|     31|             25|             31|              16|              34|ERR458493   |
|    4| 31.09976|     35|             28|             37|              19|              37|ERR458493   |
|    5| 33.49616|     35|             33|             37|              28|              37|ERR458493   |
|    6| 34.46542|     35|             35|             37|              31|              37|ERR458493   |

### **Plotting `FastQC` Results**

We can use the function `FastQCPlotR::plot_per_base_seq_qual`



```r
body(plot_per_base_seq_qual)
```

```
## {
##     yaxis <- if (base::missing(yaxis)) 
##         sym("Mean")
##     else enquo(yaxis)
##     color <- if (base::missing(color)) 
##         sym("sample_name")
##     else enquo(color)
##     facet_by <- if (base::missing(facet_by)) 
##         sym("sample_group")
##     else enquo(facet_by)
##     p <- df %>% ggplot() + geom_point(aes(x = Base, y = !!yaxis, 
##         color = !!color)) + facet_wrap(vars(!!facet_by))
##     plot(p)
##     invisible(p)
## }
```

We can see that this function is just a helpful wrapper around 
`ggplot2::geom_point` and `ggplot2::facet_wrap` for plotting this
sort of data.


```r
sample_groups <- paste0(samples$Sample, '_', samples$BiolRep)
names(sample_groups) <- samples$RunAccession

fastqc_plotr_sample_df <- df %>%
   mutate(sample_group = sample_groups[sample_name])

# usethis::use_data(fastqc_plotr_sample_df)

fastqc_plotr_sample_df %>% 
   plot_per_base_seq_qual()
```

![](/tmp/RtmpHXgJdN/preview-78c23d2cd447.dir/FastqPlotR_vignette_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

For comparison, we can see the data accompanying the package 
will produce the same plot. 



```r
FastQCPlotR::fastqc_plotr_sample_df %>% 
   plot_per_base_seq_qual()
```

![](/tmp/RtmpHXgJdN/preview-78c23d2cd447.dir/FastqPlotR_vignette_files/figure-html/unnamed-chunk-12-1.png)<!-- -->
