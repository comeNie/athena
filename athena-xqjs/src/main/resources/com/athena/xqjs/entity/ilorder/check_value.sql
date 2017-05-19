create or replace function check_value(dingdlx in varchar2) return Integer is
acount Integer;

type curtype is ref cursor;--�α궨��
  cur_Cus curtype;
  str_sql varchar2(500);--ƴ��sqlԤ��
  p_table xqjs_maoxqhzpc%ROWTYPE;--ppģʽ�����ݸ�ʽ����
  s_table xqjs_maoxqhzsc%ROWTYPE;--psģʽ�����ݸ�ʽ����
  j_table xqjs_maoxqhzjc%ROWTYPE;--pjģʽ�����ݸ�ʽ����
  message varchar2(500);--��ϸ��Ϣ�ַ���
  TYPE gongysfe_re IS RECORD(--��Ӧ�̷ݶ���ʱ�����ݴ洢��ʽ
    lingjh     VARCHAR2(10),
    usercenter VARCHAR2(10),
    fene       number,
    jihydz     VARCHAR2(10),
    cangkdm   VARCHAR2(10),
    waibghms  VARCHAR2(10)) ;
  g_table gongysfe_re;
begin
  acount :=0;
  if dingdlx = 'PP' then--�ж��Ƿ���ppģʽ
    str_sql := 'select *
                from (select t.lingjbh,
                             t.usercenter,
                             sum(t.gongysfe) as fene,
                             t.jihydz,
                             t.cangkdm,
                             t.waibghms
                        from xqjs_maoxqhzpc t
                       group by t.lingjbh, t.usercenter,t.jihydz,t.cangkdm,t.waibghms) a
               where a.fene <> 1 or a.fene is null' ;--��ѯͬһ�û�������ͬһ����Ĺ�Ӧ�̷ݶ�ĺ��Ƿ񲻵���100
    open cur_Cus for str_sql;
    loop
    FETCH cur_Cus
      INTO g_table;
      EXIT WHEN cur_Cus%NOTFOUND;
      insert into xqjs_yicbj
        (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)--���ڹ�Ӧ�̷ݶΪ100�����������Ϣ���뵽�쳣������
      values
        ('31',
        g_table.lingjh,
         g_table.usercenter,
         '100',
         g_table.usercenter || '�û������µĺ���Ϊ' || g_table.lingjh ||
         '������Ĺ�Ӧ�̷ݶ��100%',
         g_table.jihydz,
         to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
      delete from xqjs_maoxqhzpc t--��ppģʽë�������_�ο�ϵ�����޳���Ӧ�̷ݶΪ100������
       where t.lingjbh = g_table.lingjh
         and t.usercenter = g_table.usercenter
         and t.cangkdm = g_table.cangkdm;
         acount := acount+1;
    end loop;

    str_sql := 'select * from xqjs_maoxqhzpc  order by id';--��ppģʽë�������_�ο�ϵ���α�
    open cur_Cus for str_sql;
    loop
    FETCH cur_Cus
      INTO p_table;
    EXIT WHEN cur_Cus%NOTFOUND;
      if p_table.zhizlx is null then--������·��Ϊ��ʱ
        insert into xqjs_yicbj--����Ϣ���뵽�쳣��������
          (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
        values
          ('31',
          p_table.lingjbh,
           p_table.usercenter,
           '100',
           p_table.usercenter || '�û������µĺ���Ϊ' || p_table.lingjbh ||
           '���������·��Ϊ��',
           p_table.jihydz,
           to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
           delete from xqjs_maoxqhzpc t--��ppģʽë�������_�ο�ϵ�����޳�����·��Ϊ�յ�����
       where t.id = p_table.id;
         acount := acount+1;
      else--�������·�߲�Ϊ�������ж�������زο�ϵ�Ĳ����Ƿ�Ϊ��
        select decode(d.cangkdm, null, '�ֿ���Ϊ��+') ||
               decode(d.dinghcj, null, '��������Ϊ��+') ||
               decode(d.anqkc, null, '��ȫ���Ϊ��+') ||
               decode(d.kuc, null, '���Ϊ��+') ||
               decode(d.gongysdm, null, '��Ӧ�̱��Ϊ��+') ||
               decode(d.fayzq, null, '��������Ϊ��+') ||
               decode(d.beihzq, null, '��������Ϊ��+') ||
               decode(d.gongysfe, null, '��Ӧ�̷ݶ�Ϊ��+') ||
               decode(d.tiaozjsz, null, '��������ֵΪ��+') ||
               decode(d.uabzlx, null, 'ua��װ����Ϊ��+') ||
               decode(d.uabzuclx, null, 'ua��װ��uc����Ϊ��+') ||
               decode(d.uabzucsl, null, 'ua��װ��uc��װ����Ϊ��+') ||
               decode(d.uabzucrl, null, 'ua��װ��uc��װ����Ϊ��+') ||
               decode(d.ziyhqrq, null, '��Դ��ȡ����Ϊ��+') ||
               decode(d.waibghms, null, '�ⲿ����ģʽΪ��+') ||
               decode(d.yugsfqz, null, 'Ԥ���Ƿ�ȡ��Ϊ��+') ||
               decode(d.shifylkc, null, '�Ƿ��������Ϊ��+') ||
               decode(d.shifylaqkc, null, '�Ƿ�������ȫ���Ϊ��+') ||
               decode(d.shifyldjf, null, '�Ƿ�����������Ϊ��+') ||
               decode(d.shifyldxh, null, '�Ƿ�����������Ϊ��+') ||
               decode(d.jihydz, null, '�ƻ�Ա����Ϊ��+') ||
               decode(d.lujdm, null, '·������Ϊ��+') ||
               decode(d.dingdlj, null, '�����ۻ�Ϊ��+') ||
               decode(d.jiaoflj, null, '�����ۻ�Ϊ��+')
          into message
          from xqjs_maoxqhzpc d
         where d.id = p_table.id;
        if message is not null then--��message��Ϊ��ʱ
          insert into xqjs_yicbj--������Ϣ���뵽�쳣������
            (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
          values
            ('31',p_table.lingjbh,
             p_table.usercenter,
             '200',
             p_table.usercenter || '�û������µĺ���Ϊ' || p_table.lingjbh ||
             '��������²���Ϊ��:' || message,
             p_table.jihydz,
             to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
              delete from xqjs_maoxqhzpc t--��ppģʽë�������_�ο�ϵ�����޳�����Ϊ�յ�����
       where t.id = p_table.id;
         acount := acount+1;
        end if;
      end if;
    end loop;
  elsif dingdlx = 'PS' then--�ж��Ƿ���psģʽ
    str_sql := 'select *
                from (select t.lingjbh,
                             t.usercenter,
                             sum(t.gongysfe) as fene,
                             t.jihyz,
                             t.cangkdm,
                             t.waibghms
                        from xqjs_maoxqhzsc t
                       group by t.lingjbh, t.usercenter, t.jihyz,t.cangkdm,t.waibghms) a
               where a.fene <> 1 or a.fene is null';--��ѯͬһ�û�������ͬһ����Ĺ�Ӧ�̷ݶ�ĺ��Ƿ񲻵���100

    open cur_Cus for str_sql;
    loop
    FETCH cur_Cus
      INTO g_table;

     EXIT WHEN cur_Cus%NOTFOUND;
      insert into xqjs_yicbj
        (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)--���ڹ�Ӧ�̷ݶΪ100�����������Ϣ���뵽�쳣������
      values
        ('31',
        g_table.lingjh,
         g_table.usercenter,
         '100',
         g_table.usercenter || '�û������µĺ���Ϊ' || g_table.lingjh ||
         '�Ĺ�Ӧ�̷ݶ��100%',
         g_table.jihydz,
         to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
      delete from XQJS_MAOXQHZSC t--��psģʽë�������_�ο�ϵ�����޳���Ӧ�̷ݶΪ100������
       where t.lingjbh = g_table.lingjh
         and t.usercenter = g_table.usercenter
         and t.cangkdm = g_table.cangkdm;
         acount := acount+1;
    end loop;

    str_sql := 'select * from xqjs_maoxqhzsc order by id';--��psģʽë�������_�ο�ϵ���α�
    open cur_Cus for str_sql;
    loop
    FETCH cur_Cus
      INTO s_table;
     EXIT WHEN cur_Cus%NOTFOUND;
      if s_table.zhizlx is null then--������·��Ϊ��ʱ
        insert into xqjs_yicbj--����Ϣ���뵽�쳣��������
          (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
        values
          ('31',
          s_table.lingjbh,
           s_table.usercenter,
           '100',
           s_table.usercenter || '�û������µĺ���Ϊ' || s_table.lingjbh ||
           '���������·��Ϊ��',
           s_table.jihyz,
           to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
           delete from xqjs_maoxqhzsc t--��psģʽë�������_�ο�ϵ�����޳�����·��Ϊ�յ�����
       where t.lingjbh = s_table.lingjbh
         and t.usercenter = s_table.usercenter
         and t.jihyz = s_table.jihyz;
         acount := acount+1;
      else--�������·�߲�Ϊ�������ж�������زο�ϵ�Ĳ����Ƿ�Ϊ��
        select decode(d.cangkdm, null, '�ֿ���Ϊ��+') ||
               decode(d.dinghcj, null, '��������Ϊ��+') ||
               decode(d.anqkc, null, '��ȫ���Ϊ��+') ||
               decode(d.kuc, null, '���Ϊ��+') ||
               decode(d.gongysdm, null, '��Ӧ�̱��Ϊ��+') ||
               decode(d.fayzq, null, '��������Ϊ��+') ||
               decode(d.beihzq, null, '��������Ϊ��+') ||
               decode(d.gongysfe, null, '��Ӧ�̷ݶ�Ϊ��+') ||
               decode(d.tiaozjsz, null, '��������ֵΪ��+') ||
               decode(d.uabzlx, null, 'ua��װ����Ϊ��+') ||
               decode(d.uabzuclx, null, 'ua��װ��uc����Ϊ��+') ||
               decode(d.uabzucsl, null, 'ua��װ��uc��װ����Ϊ��+') ||
               decode(d.uabzucrl, null, 'ua��װ��uc��װ����Ϊ��+') ||
               decode(d.ziyhqrq, null, '��Դ��ȡ����Ϊ��+') ||
               decode(d.waibghms, null, '�ⲿ����ģʽΪ��+') ||
                decode(d.yugsfqz, null, 'Ԥ���Ƿ�ȡ��Ϊ��+') ||
               decode(d.shifylkc, null, '�Ƿ��������Ϊ��+') ||
               decode(d.shifylaqkc, null, '�Ƿ�������ȫ���Ϊ��+') ||
               decode(d.shifyldjf, null, '�Ƿ�����������Ϊ��+') ||
               decode(d.shifyldxh, null, '�Ƿ�����������Ϊ��+') ||
               decode(d.jihyz, null, '�ƻ�Ա����Ϊ��+') ||
               decode(d.lujdm, null, '·������Ϊ��+') ||
               decode(d.dingdlj, null, '�����ۻ�Ϊ��+') ||
               decode(d.jiaoflj, null, '�����ۻ�Ϊ��+')
          into message
          from xqjs_maoxqhzsc d
         where d.id = s_table.id;
        if message is not null then--��message��Ϊ��ʱ
          insert into xqjs_yicbj--������Ϣ���뵽�쳣������
            (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
          values
            ('31',
            s_table.lingjbh,
             s_table.usercenter,
             '200',
             s_table.usercenter || '�û������µĺ���Ϊ' || s_table.lingjbh ||
             '��������²���Ϊ��:' || message,
             s_table.jihyz,
             to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
             delete from xqjs_maoxqhzsc t--��psģʽë�������_�ο�ϵ�����޳�����Ϊ�յ�����
       where t.id = s_table.id;
         acount := acount+1;
        end if;
      end if;
    end loop;
  elsif dingdlx = 'PJ' then--�����pjģʽ
     str_sql := 'select *
                from (select t.lingjbh,
                             t.usercenter,
                             sum(t.gongysfe) as fene,
                             t.jihyz,
                             t.cangkdm,
                             t.waibghms
                        from xqjs_maoxqhzjc t
                       group by t.lingjbh, t.usercenter,t.jihyz,t.cangkdm,t.waibghms) a
               where a.fene <> 1 or a.fene is null';--���ҹ�Ӧ�̷ݶΪ100������
    open cur_Cus for str_sql;
    loop
    FETCH cur_Cus
      INTO g_table;
     EXIT WHEN cur_Cus%NOTFOUND;
      insert into xqjs_yicbj--����Ӧ�̷ݶΪ100�Ĵ�����Ϣ���뵽�쳣������
        (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
      values
        ('31',
        g_table.lingjh,
         g_table.usercenter,
         '100',
         g_table.usercenter || '�û������µĺ���Ϊ' || g_table.lingjh ||
         '�Ĺ�Ӧ�̷ݶ��100%',
         g_table.jihydz,
         to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
      delete from xqjs_maoxqhzjc t--��pjģʽë�������_�ο�ϵ�����޳���Ӧ�̷ݶΪ100������
       where t.lingjbh = g_table.lingjh
         and t.usercenter = g_table.usercenter
         and t.cangkdm = g_table.cangkdm;
         acount := acount+1;
    end loop;

    str_sql := 'select * from  xqjs_maoxqhzjc   order by id';--��pjģʽë�������_�ο�ϵ���α�
    open cur_Cus for str_sql;
    loop
    FETCH cur_Cus
      INTO j_table;
     EXIT WHEN cur_Cus%NOTFOUND;
      if j_table.zhizlx is null then--�������·��Ϊ��
        insert into xqjs_yicbj--��������Ϣ���뵽�쳣������
          (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
        values
          ('31',
          j_table.lingjbh,
           j_table.usercenter,
           '100',
           j_table.usercenter || '�û������µĺ���Ϊ' || j_table.lingjbh ||
           '���������·��Ϊ��',
           j_table.jihyz,
            to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
           delete from xqjs_maoxqhzjc t--��pjģʽë�������_�ο�ϵ�����޳�����·��Ϊ�յ�����
       where t.id = j_table.id;
         acount := acount+1;
      else--�������·����Ϊ��
        select decode(d.cangkdm, null, '�ֿ���Ϊ��+') ||--��������ο�ϵ��ز����Ƿ�Ϊ��
               decode(d.dinghcj, null, '��������Ϊ��+') ||
               decode(d.anqkc, null, '��ȫ���Ϊ��+') ||
               decode(d.kuc, null, '���Ϊ��+') ||
               decode(d.gongysdm, null, '��Ӧ�̱��Ϊ��+') ||
               decode(d.fayzq, null, '��������Ϊ��+') ||
               decode(d.beihzq, null, '��������Ϊ��+') ||
               decode(d.gongysfe, null, '��Ӧ�̷ݶ�Ϊ��+') ||
               decode(d.tiaozjsz, null, '��������ֵΪ��+') ||
               decode(d.uabzlx, null, 'ua��װ����Ϊ��+') ||
               decode(d.uabzuclx, null, 'ua��װ��uc����Ϊ��+') ||
               decode(d.uabzucsl, null, 'ua��װ��uc��װ����Ϊ��+') ||
               decode(d.uabzucrl, null, 'ua��װ��uc��װ����Ϊ��+') ||
               decode(d.ziyhqrq, null, '��Դ��ȡ����Ϊ��+') ||
               decode(d.waibghms, null, '�ⲿ����ģʽΪ��+') ||
                decode(d.yugsfqz, null, 'Ԥ���Ƿ�ȡ��Ϊ��+') ||
               decode(d.shifylkc, null, '�Ƿ��������Ϊ��+') ||
               decode(d.shifylaqkc, null, '�Ƿ�������ȫ���Ϊ��+') ||
               decode(d.shifyldjf, null, '�Ƿ�����������Ϊ��+') ||
               decode(d.shifyldxh, null, '�Ƿ�����������Ϊ��+') ||
               decode(d.jihyz, null, '�ƻ�Ա����Ϊ��+') ||
               decode(d.lujdm, null, '·������Ϊ��+') ||
               decode(d.dingdlj, null, '�����ۻ�Ϊ��+') ||
               decode(d.jiaoflj, null, '�����ۻ�Ϊ��+')
          into message
          from xqjs_maoxqhzjc d
         where d.id = j_table.id;
        if message is not null then--���message��Ϊ��
          insert into xqjs_yicbj--��������Ϣ���뵽�쳣������
            (jismk,lingjbh, usercenter, cuowlx, cuowxxxx, jihyz,CREATE_TIME)
          values
            ('31',
            j_table.lingjbh,
             j_table.usercenter,
             '200',
             j_table.usercenter || '�û������µĺ���Ϊ' || j_table.lingjbh ||
             '��������²���Ϊ��:' || message,
             j_table.jihyz,
              to_timestamp(to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss.ff'),'yyyy-mm-dd hh24:mi:ss.ff'));
             delete from xqjs_maoxqhzjc t--��pjģʽë�������_�ο�ϵ�����޲���Ϊ�յ�����
       where t.id = j_table.id;
         acount := acount+1;
        end if;
      end if;
    end loop;
  end if;
return acount;
end check_value;
