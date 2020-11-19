## Test environments
* local OS X install, R 3.6.1
* win-builder (devel, release and old_release)
* rhub	Windows Server 2008 R2 SP1, R-devel, 32/64 bit
* rhub  Ubuntu Linux 16.04 LTS, R-release, GCC
* rhub Fedora Linux, R-devel, clang, gfortran

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE on win-builder and rhub:

* checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Abdessabour Moutik <a.moutik@insea.ac.ma>'
  
  New submission
  Possibly mis-spelled words in DESCRIPTION:
    Indices (10:49)
    LeBoursier's (9:39)

  Indices is the plural of index, and LeBoursier is in French.

