with xml_parse( xml ) as(
select XmlParse(
   'select sysdate as day, e.*, d.*,
           (select comm from bonus) x,
           s.grade
    from emp e, dept d , (select * from salgrade)s
    where
         e.deptno = d.deptno and empno = :1' ) from dual
    )
    select
      t.*
      from   xml_parse p,
      XmlTable( '/QUERY/SELECT/SELECT_LIST/SELECT_LIST_ITEM/COLUMN_REF'
                 passing p.xml
                                        columns
                 table_name varchar2(30) path 'TABLE',
                 column_name varchar2(30) path 'COLUMN'
) t

/