Class dc.data.rcc.JSON
{

ClassMethod Member(
	id = 0,
	ByRef list) As %DynamicObject
{
  &SQL(
    SELECT JSON_OBJECT('ID':MbrId,'name':Name,'Level':LEVL,'BadgeCount':BadgeCount),Badges 
      into :res,:list 
      from dc_data_rcc.DCmember
      where MbrId = :id
      )
  if SQLCODE set list="" quit {}   
  quit {}.%FromJSON(res)
}

ClassMethod Badge(
	id = 0,
	ByRef list) As %DynamicObject
{
  &SQL(
    SELECT JSON_OBJECT('ID':badgeId,'Title':Title,'MbCnt':MbCnt),Members into :res,:list 
      from dc_data_rcc.GMbadge
      where BadgeId = :id 
      )
  if SQLCODE set list="" quit {}  
  quit {}.%FromJSON(res)
}

ClassMethod byBadge(
	id = 0,
	verbose = 0) As %DynamicObject
{
  set badge=..Badge(id,.list)
  set res={}
    ,res.Badge=badge
    ,res.Members=[] 
  for f=1:1:$LL(list) {
    set mem=..Member($li(list,f))
     if mem.%Size() do res.Members.%Push(mem)
    }
  if verbose zzjson res
  quit res
}

ClassMethod byMember(
	id = 0,
	verbose = 0) As %DynamicObject
{
  set member=..Member(id,.list)
  set res={}
    ,res.Member=member
    ,res.Badges=[] 
  for f=1:1:$LL(list) {
    set bdg=..Badge($li(list,f))  
    if bdg.%Size() do res.Badges.%Push(bdg)
    }
  if verbose zzjson res  
  quit res
}

ClassMethod allBadges(verbose = 0) As %DynamicArray
{
  set sql(1)="SELECT JSON_OBJECT('ID':badgeId,'Title':Title,'MbCnt':MbCnt)"
    , sql(2)=" from dc_data_rcc.GMbadge"
    , sql=2
    , tRes = ##class(%SQL.Statement).%ExecDirect(,.sql)
    , arr=[]
  while tRes.%Next() {
    set bdg={}.%FromJSON(tRes.%GetData(1))
    do arr.%Push(bdg)
    }
  if verbose zzjson arr
  quit arr
}

ClassMethod activeMembers(
	minbadge = 1,
	verbose = 0) As %DynamicArray
{
  set sql(1)="SELECT JSON_OBJECT('ID':MbrId,'name':Name,'BadgeCount':BadgeCount)"
    , sql(2)=" from dc_data_rcc.DCmember"
    , sql(3)=" where NOT BadgeCount < "_minbadge 
    , sql(4)=" order by BadgeCount desc " 
    , sql=4
    , tRes = ##class(%SQL.Statement).%ExecDirect(,.sql)
    , arr=[]
  while tRes.%Next() {
    set mem={}.%FromJSON(tRes.%GetData(1))
    do arr.%Push(mem)
    }
  if verbose zzjson arr
  quit arr
}

/// might be required
ClassMethod BI() As %Status
{
  set sc1=##class(dc.data.rcc.DCmember).%BuildIndices()
  set sc2=##class(dc.data.rcc.GMbadge).%BuildIndices()
  quit sc1*sc2
}

}

