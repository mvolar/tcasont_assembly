# TcasONT assembly scripts

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Overview

This repository contains the necessary scripts to recreate the visualizations presented in the research paper  *Long-read genome assembly of the insect model organism Tribolium castaneum reveals spread of satellite DNA in gene-rich regions by recurrent burst events*. 

The aim of this study was to generate a new, high-quality Tribolium castaneum genome assembly (TcasONT) by combining Oxford Nanopore long-read sequencing, and reference-guided assembly approach. The new TcasONT assembly proved to be enhanced by nearly 53 Mb compared to the last version of the T. castaneum genome, Tcas5.2. 

The TcasONT assembly exhibits higher gene completeness and a 20-fold enrichment in the repetitive genome part. Indeed, the enlargement of the TcasONT assembly was up to 50 Mb when all classes of repetitive sequences were considered. Therefore, TcasONT assembly not only contributes to the identification of potential novel genes but also provides an excellent platform for the analysis of different repetitive genome fractions.

## Running the scripts

In order to run the scripts you need to unpack the TcasONT_annotations.zip present in the data folder and download the TcasONT assembly from the following link:

https://www.ebi.ac.uk/ena/browser/api/fasta/GCA_950066185.1?download=true&gzip=true

All scripts are Rmarkdown files and can be run using Rstudio after installing the neccessary libraries.

