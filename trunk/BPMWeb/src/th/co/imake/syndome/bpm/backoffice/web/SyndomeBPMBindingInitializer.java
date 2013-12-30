// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:04:30 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissConsultBindingInitializer.java

package th.co.imake.syndome.bpm.backoffice.web;

import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

public class SyndomeBPMBindingInitializer
    implements WebBindingInitializer
{

    public SyndomeBPMBindingInitializer()
    {
    }

    public void initBinder(WebDataBinder binder, WebRequest request)
    {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
        binder.registerCustomEditor(java.lang.String.class, new StringTrimmerEditor(false));
    }
}
