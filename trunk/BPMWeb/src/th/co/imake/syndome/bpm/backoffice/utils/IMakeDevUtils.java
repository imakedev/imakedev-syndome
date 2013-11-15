// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:15:07 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   IMakeDevUtils.java

package th.co.imake.syndome.bpm.backoffice.utils;


public class IMakeDevUtils
{

    public IMakeDevUtils()
    {
    }

    public static final int calculatePage(int perPage, int total)
    {
        return total % perPage != 0 ? total / perPage + 1 : total / perPage;
    }
    public static final int PAGE_SIZE=20;
   // public static final int PAGE_SIZE=2;
    public static final String MODE_EDIT="edit";
    public static final String MODE_NEW="new";
    public static final String MODE_DELETE_ITEMS="deleteItems";
    public static final String MODE_DELETE="delete";
    public static final String MODE_DO_BACK="doBack";
}
