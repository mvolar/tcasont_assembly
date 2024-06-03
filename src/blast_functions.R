
blast_to_gff <- function(s_name,q_name,name,work_dir)
{

setwd(work_dir)
blasts <- readDNAStringSet(s_name)
#try(blasts <- blasts[1:10000])
blastq <- readDNAStringSet(q_name)

writeXStringSet(blasts,"C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blasts.fa",format="fasta")
writeXStringSet(blastq,"C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blastq.fa",format="fasta")

blast_dt <- blast_nucleotide_to_nucleotide(
                 query   = 'C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blastq.fa',
                 subject = 'C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blasts.fa',
                 output.path = tempdir(),
                 db.import  = FALSE,
                 evalue = 0.001,
                 cores= 16) %>% as.data.table(.)

q_tmp_dt <- data.table(query_id=names(blastq),widt=width(blastq))


casts_in_un <- blast_dt

gff_temp <- casts_in_un[qcovhsp>70 & perc_identity>70,c("subject_id","query_id","s_start","s_end","bit_score")]

setnames(gff_temp,c("subject_id","query_id","s_start","s_end","bit_score"),c("seqnames","feature","start","end","score"))

gff_temp[,source:="Rblast"]

gff_temp[,strand:="+"]

gff_temp[,frame:="."]

gff_temp[,group:=name]


gff_temp[start>end, c("end", "start") := .(start, end)]

#gff_temp[,feature:=str_extract(feature,"\\d+x\\d+")]

setcolorder(gff_temp,c("seqnames","source","feature","start","end","score","strand","frame","group"))

file = paste0(getwd(),"/",name,".gff")

fwrite(gff_temp, file = file, row.names=FALSE, sep="\t",quote=FALSE,col.names = FALSE)

return(gff_temp)
}






blast_to_raw<- function(s_name,q_name,name,work_dir)
{

  
setwd(work_dir)

blasts <- readDNAStringSet(s_name)
blastq <- readDNAStringSet(q_name)

writeXStringSet(blasts,"C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blasts.fa",format="fasta")
writeXStringSet(blastq,"C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blastq.fa",format="fasta")

blast_dt <- blast_nucleotide_to_nucleotide(
                 query   = 'C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blastq.fa',
                 subject = 'C:/Users/User/Documents/R/win-library/4.0/metablastr/seqs/blasts.fa',
                 output.path = tempdir(),
                 db.import  = FALSE,
                 evalue = 0.001,
                 cores= 16) %>% as.data.table(.)

q_tmp_dt <- data.table(query_id=names(blastq),widt=width(blastq))

casts_in_un <- blast_dt

blast_dt <- casts_in_un#[qcovhsp>70 & perc_identity>70]#,c("subject_id","query_id","s_start","s_end","bit_score","strand")]

#blast_dt[start>end, c("end", "start") := .(start, end)]

return(blast_dt)

}



rpt_fix <- function(dt,katalog)
{


dt <- copy(dt)

dt[,V10:=str_remove(V10,"Motif:")]

dt[,V3:=V10]


#imena kroz katalog repeatova da bi se dobile klase repeatova
crossref <- copy(katalog)
  setnames(crossref,c("pos in repeat: begin","repeat","class/family"),c("status","type","class"))
    crossref[grep("^\\D+",status),type:=class]
      crossref[grep("^\\D+",status),class:=status]
crossref <- crossref[,.(class,type)] %>% unique(.)

setnames(dt,"V10","type")


setkey(crossref,type)
setkey(dt,type)
print(dt)
dt <- dt
crossref<-crossref

dt2 <-  merge(crossref,dt,by="type",allow.cartesian=TRUE)

dt2[type==V3]

dt2[,V3:=class]

dt2[,class:=NULL]

#dt2 <- na.omit(dt2)

dt2[,V9:=type]

dt2[,type:=NULL]

print(dt2)
return(dt2)
}
