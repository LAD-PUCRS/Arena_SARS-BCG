## 5-GetDendrogram_RPVCLUST

This step is responsible for processing the `CSV` files obtained in the previous [ImageJ step](../4-GetHistograms_ImageJ/README.md) and generating a dendrogram for data analysis. We use `R v3.6.1`, installed using miniconda, in this step.

**1. Install Necessary R Packages**

To install the package `pvclust` for `R`, open an `R shell` and run the installation command as follows.

```sh
R # Either run R on a shell or use R Studio.
install.packages("pvclust") # Run this line to install the package
```

**2. Merge All CSVs into One**

The R script `dendrogram_PVCLUST.R` which generates the dendrogram receives a single `CSV` as an input. In order to run it, we merge every complex CSV obtained from the execution of the [ImageJ step](../4-GetHistograms_ImageJ/README.md) into a single one. Use the following script to merge all CSVs into one.

```sh
# Give execution permission
chmod +x transpose.sh
# Merge the CSVs and transpose their format for easier processing in R
./transpose.sh ../4-GetHistograms_ImageJ/output/
```

The merged file will be available as `final.csv`.

**3. Dendrogram Generation**

The R script that generates the dendrogram using the merged file, `final.csv`, can be run as described below.

```sh
nohup bash -c 'time Rscript dendrogram_PVCLUST.R' &> pvclust_R.log &
```

Both the scripts `transpose.sh` and `dendrogram_PVCLUST.R` were designed in accordance with the [RoiSet_46diag.zip](../4-GetHistograms_ImageJ/RoiSet_46diag.zip) used in the previous [ImageJ step](../4-GetHistograms_ImageJ/README.md). Therefore, we recommend reviewing these scripts if the `RoiSet` is modified.