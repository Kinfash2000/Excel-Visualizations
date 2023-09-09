               -- (i)

Select state, avg(listprice) as AverageListPrice, avg(saleprice) as AverageSalePrice
  from purchase p
  natural join store s
  inner join address a 
  on s.addressid = a.addressid
  group by state



-----ii
Select state, storeid, storename, avg(listprice) as AverageListPrice, avg(saleprice) as AverageSalePrice
   from store s
natural join purchase p
  inner join address a 
     on s.addressid = a.addressid
  group by state,storeid, storename
  --order by state
  
  
  ---or
Select state, storeid, storename, avg(listprice) as AverageListPrice, avg(saleprice) as AverageSalePrice
   from store s
natural join purchase p
  inner join address a 
     on s.addressid = a.addressid
  group by cube(state,storeid, storename)
  order by state
  
     --iii

    -- gets the popular paint color
     
select * from (Select storeid, paintid, colorname, storename, count(colorname) as Colorcount
      from paint pt
   natural join bicycle b
     inner join purchase p
        on b.serialnumber = p.bicycleserialnumber
   natural join store s
   natural join address a
  group by cube(storeid, paintid, colorname, storename)
  order by Colorcount desc)
          where storeid is null and paintid is not null 
            and colorname is not null and storename is null
          --and storename not in('Walk-In', 'Direct Sales')
 
      -- code modified to show colornames(paint) as sold by stores in decseding order

select * from (Select storeid, paintid, colorname, storename, count(colorname) as Colorcount
      from paint pt
   natural join bicycle b
     inner join purchase p
        on b.serialnumber = p.bicycleserialnumber
   natural join store s
   natural join address a
  group by cube(storeid, paintid, colorname, storename)
  order by Colorcount desc)
          where storeid is null and paintid is not null 
            and colorname is not null and storename is not null
          and storename not in('Walk-In', 'Direct Sales')


    ---iv
select * from (Select storeid, storename, manufacturername, count(manufacturername) as manucount
     from part pr
  natural join component c
    inner join bicycle b
       on c.bicycleserialnumber = b.serialnumber
     join purchase p
       on b.serialnumber = p.bicycleserialnumber
  natural join store s
 group by cube(storeid, storename, manufacturername)
    order by manucount desc)
  
where storeid is null and storename is not null and storename not in('Walk-In', 'Direct Sales') and manufacturername is not null
