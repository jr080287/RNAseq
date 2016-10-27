plotPCA2.DESeqTransform = function(object, intgroup="condition", ntop=1000, returnData=FALSE, pcs=20)
{
    pdf("test_multi.pdf")
    # calculate the variance for each gene
    rowVars=function (x,na.rm = TRUE) {
        sqr = function(x) x * x
        n = rowSums(!is.na(x))
        n[n <= 1] = NA
        return(rowSums(sqr(x - rowMeans(x,na.rm = na.rm)), na.rm = na.rm)/(n - 1))
          }
    rv <- rowVars(assay(object))

  # select the ntop genes by variance
  select <- order(rv, decreasing=TRUE)[seq_len(min(ntop, length(rv)))]

    # perform a PCA on the data in assay(x) for the selected genes
    pca <- prcomp(t(assay(object)[select,]))

    # the contribution to the total variance for each component
    percentVar <- pca$sdev^2 / sum( pca$sdev^2 )

      if (!all(intgroup %in% names(colData(object)))) {
              stop("the argument 'intgroup' should specify columns of colData(dds)")
      }

      intgroup.df <- as.data.frame(colData(object)[, intgroup, drop=FALSE])
        
        # add the intgroup factors together to create a new grouping factor
        group <- if (length(intgroup) > 1) {
                factor(apply( intgroup.df, 1, paste, collapse=" : "))
        } else {
                colData(object)[[intgroup]]
          }

        # assembly the data for the plot
        for (i in 1:(pcs-1)){
           xlab1 = paste("PC",i,sep="")
           ylab1 = paste("PC",i+1,sep="")
            d <- data.frame(a=pca$x[,i], b=pca$x[,i+1], group=group, intgroup.df, name=colnames(object))

            if (returnData) {
                      attr(d, "percentVar") <- percentVar[1:2]
                return(d)
                  }
           print(ggplot(data=d, aes_string(x="a", y="b", color="group")) + geom_point(size=3) + 
                  xlab(paste(xlab1,round(percentVar[i] * 100),"% variance", sep=" ")) +
                  ylab(paste(ylab1,round(percentVar[i+1] * 100),"% variance", sep=" ")) +
                  theme_bw() +coord_fixed()+theme(aspect.ratio=1))
        }
        
        dev.off()            
}
