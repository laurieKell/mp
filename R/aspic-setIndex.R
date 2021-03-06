setGeneric("setIndex<-",  function(object,value)  standardGeneric('setIndex<-'))

setIndexFn=function(object,value){
  res=aspic()
  
  ### New index #################################
  ## aspic
  # a) expunge old index
  # b) count number of indices
  # c) expand relevant slots
  # d) calculate default values

  idxs=unique(value$name)

  ## a) expunge old index
  # index 
  res@index=value

  # stopmess  
  res@stopmess="not ran"

  # catch
  tmp=ddply(res@index, .(year), with, sum(catch,na.rm=TRUE))
  res@catch=as.FLQuant(tmp[,"V1"], dimnames=list(year=tmp[,"year"]))
  dmns=dimnames(res@catch)
  dmns$year=c(dmns$year,as.numeric(max(dmns$year))+1)
 
  # stock        
  res@stock=FLQuant(NA,dimnames=dmns)

  range(res)=range(as.numeric(dimnames(res@catch)$year))

  # diags       
  res@diags=data.frame(NULL)

  # params      
  res@params =FLPar(as.numeric(NA),dimnames=list(params=c("b0","msy","k"),iter=1))

  
  # control 
  res@control=FLPar(as.numeric(NA),c(length(c(c("b0","msy","k"),paste("q",seq(length(idxs)),sep=""))),5),
                       dimnames=list(params=c(c("b0","msy","k"),paste("q",seq(length(idxs)),sep="")),
                                   c("fit","min","val","max","lambda"),iter=1))

# vcov      
  res@vcov=FLPar(as.numeric(NA),dimnames=list(params=c("b0","msy","k"),param=c("b0","msy","k"),iter=1))

  # hessian       
  res@hessian=FLPar(as.numeric(NA),dimnames=list(params=c("b0","msy","k"),param=c("b0","msy","k"),iter=1))

  # objFn
  res@objFn  =FLPar(array(as.numeric(NA),dim=c(2,1),dimnames=list("value"=c("rss","rsq"),iter=1)))

  # mng 
  res@rnd=object@rnd
  
  # mng 
  res@mng=FLPar()
  
  # mngVcov      
  res@mngVcov=FLPar()

  # profile         
  res@profile=data.frame(NULL)

  # desc        
  res@desc=paste(res@desc,"new index")

  nms=dimnames(res@params)$params[dimnames(res@params)$params %in% dimnames(object@params)$params]
  res@params[nms]=object@params[nms]
  
  nms=dimnames(res@control)$params[dimnames(res@control)$params %in% dimnames(object@control)$params]
  res@control[nms,c("min","val","max")]=object@control[nms,c("min","val","max")]
  
  res@stock=object@stock
  
  ## add q??s
  #setParams( res)=value
  
  nms=c("b0","msy","k")
 
  res@params=res@params[nms]
  idx<-index(res)
  stk<-as.data.frame(stock(res),drop=T)
  
  q=ddply(idx,.(name), function(idx){
        with(merge(idx,stk),
        mean(index/data,na.rm=T))})
 
  q.=FLPar(q[,2])
  dimnames(q.)$params=paste("q",seq(dim(q)[1]),sep="")
  params(res)=rbind(params(res),q.)
  
  setControl(res)=params(res)
  
  res}

setMethod('setIndex<-', signature(object='aspic',value="data.frame"), 
          function(object,value) 
  setIndexFn(object,value))
setMethod('setIndex<-', signature(object='aspic',value="FLQuants"), 
  function(object,value) {
  
    value=as.data.frame(mcf(value),drop=TRUE)
    names(value)[c(2,3)]=c("index","name")
    value=cbind(value,code=factor("I1",levels=c("CE","CC","B0","B1","B2","I0","I1","I2")))[,c("name","year","code","index")]
    ctc  =as.data.frame(catch(object),drop=TRUE)
    ctc  =cbind(ctc,name=unique(value$name)[1])
    value=merge(value,ctc,by=c("year","name"),all=TRUE)
    
    value[value$name==unique(value$name)[1],"code"]="CC"
    names(value)[5]="catch"

    setIndexFn(object,value)})

# 
# object=asp
# value =rbind(asp@index,sdz)
# setIndex(object)=value  