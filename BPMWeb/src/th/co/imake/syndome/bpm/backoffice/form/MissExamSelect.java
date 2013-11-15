// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:13:06 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissExamSelect.java

package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

public class MissExamSelect
    implements Serializable
{

    public MissExamSelect()
    {
    }

    public String getId()
    {
        return id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    private static final long serialVersionUID = 1L;
    private String id;
    private String name;
}
